---
name: kata-language-layer
description: "Author or debug a kata template layer (pj-lang + pj-presets entry) for yukimemi's project templates — file modes, when/once adopt semantics, Renovate preset chaining, and the traps that silently break the daily kata-apply sweep."
---

# Authoring a kata language layer

kata (github.com/yukimemi/kata) composes template repos: `pj-base` (language-agnostic) + one language layer, selected by a preset in `pj-presets`. Read the closest sibling layer first — `pj-nvim` and `pj-denops` are the two-layer shape (interpreted language, no build layer), `pj-rust` + `pj-rust-{cli,lib,workspace}` is the three-layer shape.

## Files a new layer needs

| File | Purpose |
|---|---|
| `template.toml` | `name`, `version`, and the `[[file]]` entries |
| `default.json` | Renovate preset: `extends` the layer below + rules this layer owns |
| `renovate.json` | `{"extends": ["github>yukimemi/pj-<lang>"]}` — doubles as the layer repo's own config |
| `vars.<lang>.toml` | Action pins with `# renovate: datasource=… depName=…` annotations |
| `.github/workflows/ci.yml.tera` | `.tera` so GitHub Actions won't run it in the template repo |
| `AGENTS.md.<lang>` | Guidance inside `<!-- kata:agents:<lang>:begin/end -->` markers |
| `README.md`, `LICENSE` | |

Then add `pj-presets/<lang>.toml` (a `name` field is REQUIRED) listing `pj-base` first, the new layer second, and a row in `pj-presets/README.md`.

Every layer ships the same self-naming Renovate sync — kata's "last layer wins" then resolves the consumer's `extends` to the topmost applied layer:

```toml
[[file]]
src = "renovate.json"
how = "merge-json"
when = "always"
paths = ["extends"]
```

A layer disables the Renovate `github-actions` manager only for the workflows IT renders. Otherwise Renovate bumps the rendered file, kata reverts it on the next apply, forever.

## The four traps

### 1. `once` against an existing file is *adopted*, not written

kata records the `once` gate per destination path. An existing destination is left untouched, and a project that adopts the layer later via `kata add` gets `skipped` for anything `pj-base` already wrote (notably `.kata/vars.toml`). So a `once` entry can never back-fill. Anything the layer must guarantee everywhere needs a second narrow entry:

```toml
[[file]]
src = "vars.<lang>.toml"
dst = ".kata/vars.toml"
how = "merge-toml"
when = "always"
paths = ["actions.<the_pin>"]
```

### 2. A back-filled pin needs a Renovate carve-out

`when = "always"` on a Renovate-tracked pin loops: Renovate bumps it in the consumer, `kata apply` reverts it, Renovate re-opens the PR. Pair the back-fill with a rule in the layer's `default.json`:

```json
{
  "matchDepNames": ["<owner>/<action>"],
  "matchFileNames": [".kata/vars.toml"],
  "enabled": false
}
```

The canonical bump then happens upstream in the layer's own `vars.<lang>.toml` (pj-base's customManager scans `vars.<layer>.toml`) and reaches every consumer on the next apply. Scope the rule to `.kata/vars.toml` so the layer's own seed is still scanned. This is pj-base's `anthropics/claude-code-action` model.

Keep genuinely per-project knobs (`os_matrix`, a test-runner selector) on `once` only — an `always` reset would undo a deliberate consumer choice.

### 3. `merge-json` is strict JSON only

kata parses the existing file with `serde_json`. A JSONC destination — `deno.json` is the common one, since comments are legal there and Deno accepts them — makes every `kata apply` exit 1:

```
merge: merge-json: parsing existing …: key must be a string at line 2 column 3
```

`kata-apply.yml` runs `kata apply` as a bare step, so the daily sweep goes permanently red and no upstream fix ever lands. Nothing looks broken from inside the repo. Document a strict-JSON prerequisite rather than reaching for JSONC support — re-serialisation drops the comments it just parsed.

Related: the `once` gate keys on the destination *path*, so a `foo.jsonc` project is not adopted at all — kata writes a fresh `foo.json` beside it, the tool prefers `foo.json`, and the real config is silently ignored.

### 4. The language formatter will fight the kata-managed files

Any formatter that also covers markdown/json/yaml (`deno fmt`, `prettier`) reformats every kata-managed file, so the project's `--check` gate fails immediately after an apply. Running the formatter over them is not a fix: they are `when = "always"` and the next apply reverts it.

Have the layer own the exclude list (`merge-json`, `when = "always"`, `paths = ["fmt.exclude"]`), covering everything `pj-base` writes — `AGENTS.md`, `CLAUDE.md`, `GEMINI.md`, `OPENCODE.md`, `apm.yml`, `apm.lock.yaml`, `opencode.json`, `renri.toml`, `renovate.json`, `.agents/`, `.claude/`, `.gemini/`, `.github/`, `.kata/` — plus the config file kata co-owns, since `merge-json` re-serialises it with a hard-coded 2-space printer. Send project-specific exclusions to the tool's own top-level `exclude`.

## Tera rendering is strict

An undefined variable aborts `kata apply` for every consumer, including ones whose `.kata/vars.toml` predates the key. Guard every lookup:

```tera
{%- set_global os_matrix = ["ubuntu-latest"] -%}
{%- if vars.<lang> is defined and vars.<lang>.os_matrix is defined -%}
{%- set_global os_matrix = vars.<lang>.os_matrix -%}
{%- endif -%}
```

`is defined` rather than a `default(...)` filter, because Tera cannot express an empty-map fallback for the intermediate table. `set_global` because a plain `set` inside an `if` does not escape the block. Wrap every GitHub Actions `${{ … }}` in `{% raw %}`, since the delimiters collide.

Order the `[[file]]` entries so the `.kata/vars.toml` merge lands BEFORE any `.tera` that reads those vars.

## Verifying a layer

1. `deno eval`/`jq` every JSON fragment — a malformed `default.json` is invisible until Renovate runs.
2. `npx --yes --package renovate renovate-config-validator default.json renovate.json`
3. Apply to a real consumer, then apply AGAIN — the second run must write nothing. Non-idempotent applies fight the daily sweep.
4. Run the project's actual gate (`deno task ci`, `cargo make check`) after applying, not just before.
5. Parse the rendered workflow (`@std/yaml`) and check the matrix expands for both a 1-element and a 3-element list.
6. Push the layer before applying — kata fetches templates from GitHub, so local-only edits are invisible to `kata init`/`update`.

## Per-repo onboarding kata cannot ship

`KATA_APPLY_TOKEN` (a PAT; `GITHUB_TOKEN` pushes never trigger CI), `CLAUDE_CODE_OAUTH_TOKEN` (or `ANTHROPIC_API_KEY`) for the Claude workflows, `allow_auto_merge`, and — if automerge should be CI-gated — branch protection requiring the first matrix leg's check name (`ci (<first os>)`). GitHub only arms auto-merge on a PR that is currently blocked, so with no required check it rejects the request.

Also `kata register <path>`: unregistered projects are invisible to `kata list/status/apply --all`, which is exactly how repos get left out of fleet-wide fixes.

Note `kata status --all` reports `drift` for every project as a matter of course — `merge-section` / `merge-json` / `merge-toml` / adopted `once` files legitimately diverge from the recorded template hash. Compare the drift count against the fleet rather than treating non-zero as a fault.
