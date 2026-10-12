# yukimemi's dotfiles

[yui]-managed dotfiles repository. Migrated from
[chezmoi](https://chezmoi.io) in April 2026 — see commit
[0fe1121c](https://github.com/yukimemi/dotfiles/commit/0fe1121c) for the
full layout shift.

## Layout

```
.
├── config.toml                  # yui mount + hook config
├── home/                        # files mounted at ~ (`home/.zshrc` → ~/.zshrc)
│   ├── .config/
│   │   ├── .yuilink             # parent marker — junction the whole .config dir
│   │   └── <app>/
│   │       └── .yuilink         # per-app marker (Windows extras, OS filters, …)
│   ├── .claude/                 # global Claude Code settings
│   ├── .codex/                  # global Codex settings and custom skills
│   ├── .gemini/                 # global Gemini config
│   ├── .vscode/                 # global VSCode user settings
│   ├── .zshrc / .zshenv / …     # individual top-level dotfiles
│   └── …
└── .yui/
    └── bin/                     # hook scripts (was: chezmoi run_*.tmpl)
        ├── mac-init.sh          # once / pre  / yui.os == 'macos'
        ├── brew-bundle.sh       # every / post / yui.os == 'macos'
        ├── setup-wsl.sh         # onchange / post / yui.os == 'linux'
        ├── setup-openclaw.sh    # onchange / post / yui.os == 'linux'
        ├── enable-openclaw.sh   # onchange / post / yui.os == 'linux'
        └── windows-setup.ps1    # onchange / post / yui.os == 'windows'
```

`home/<X>` files / dirs link to `~/<X>`. Every `[[mount.entry]]` and
`[[hook]]` lives in `config.toml`.

## Initial bootstrap

### 1. Install yui first

No Rust, Homebrew, Scoop, or administrator privileges are needed to
install [yui]. The installers download the latest pre-built release.

**macOS (Apple Silicon) / Linux (x86_64)**

```sh
curl -fsSL https://raw.githubusercontent.com/yukimemi/yui/main/install.sh | sh
export PATH="$HOME/.local/bin:$PATH"
yui --version
```

The executable is installed to `~/.local/bin/yui`. The `export` above
applies to the current sh/bash/zsh session; add it to your shell's startup
file if needed. For fish, use `fish_add_path "$HOME/.local/bin"` instead.
Intel Mac is not supported by the installer.

**Windows (x86_64, PowerShell 5.1+)**

```powershell
irm https://raw.githubusercontent.com/yukimemi/yui/main/install.ps1 | iex
yui --version
```

The executable is installed to `%LOCALAPPDATA%\yui\bin\yui.exe`.
The installer updates the current PowerShell session and the user `PATH`;
reopen other terminals to pick up the change. For legacy Windows/.NET
TLS troubleshooting, see [yui's installation instructions](https://github.com/yukimemi/yui#install).

### 2. Get the dotfiles repository

Install Git, then clone this repository. Skip the clone if `~/dotfiles`
already exists. These commands work in sh/bash/zsh and PowerShell:

```sh
git clone https://github.com/yukimemi/dotfiles.git "$HOME/dotfiles"
```

### 3. Restore the existing secrets identity

This repository contains encrypted `*.age` files and uses Bitwarden
(`[secrets.vault]` in `config.toml`). Before the first apply, install the
[Bitwarden CLI](https://bitwarden.com/help/cli/), sign in, unlock the vault,
and set `BW_SESSION` as described in its documentation. Then:

```sh
yui secret unlock --source "$HOME/dotfiles"
```

Alternatively, securely restore the existing age identity to
`~/.config/yui/age.txt`. A new identity generated with `yui secret init`
cannot decrypt the existing secrets.

On Windows, also install PowerShell 7 (`pwsh`) before applying: the
`windows-setup` hook uses it.

## Apply

Use an explicit source path for the first apply; this works before
the dotfiles have configured your shell:

To redirect managed targets for a trial, use the
[migration toggles](#migration-toggles) below. They are not a sandbox:
review or disable hooks before applying, because hooks can change the host
outside the trial directory.

```sh
yui list --source "$HOME/dotfiles"
yui apply --source "$HOME/dotfiles" --dry-run
yui apply --source "$HOME/dotfiles"
```

Once your shell is configured, from this repo:

```sh
yui list                # show every src→dst mapping
yui apply --dry-run     # preview
yui apply               # render templates + link targets + auto-absorb
yui status              # report drift
yui doctor              # environment sanity check
```

## Migration toggles

Top of `config.toml`:

```toml
[vars]
home_root = "~"        # set to "~/yui-test" to redirect managed targets
production = true      # set to false to disable Windows-extras + the
                       # windows-setup hook (Windows-only gating)
```

For a target-only trial, set `home_root = "~/yui-test"` and
`production = false`. **These toggles do not disable macOS or Linux
hooks.** Pre- and post-hooks can still install software or change system
configuration outside `~/yui-test`.

Review the `[[hook]]` entries in `config.toml` before applying. For a
target-only trial, temporarily set `when = "false"` on every hook, run
`yui apply --dry-run`, then apply and inspect the result. Restore the
original hook conditions and both migration toggles before the real apply.

Per-machine app choices (`browser`, `editor`, `use_excel`) also live in
`[vars]`; override them in the untracked `config.local.toml`.

## Templates

These files use Tera (`*.tera` → `*.<ext>` rendered as a sibling):

- `home/.config/shun/config.toml.tera` — binds the F11 browser hotkey
  to `vars.browser` (edge / brave / chrome / comet) and adds the F9
  Excel hotkey when `vars.use_excel` is true.
- `home/.config/zellij/config/config.kdl.tera` — Linux uses `Ctrl-t`,
  others use `Ctrl-b`.
- `home/.config/todoke/todoke.toml.tera` — selects the GUI editor
  (`vars.editor`: neovide / nvim-qt / nvim) at build time, lets todoke
  render the rest at dispatch.

Rendered files are written next to the `.tera` source and added to a
managed section of `.gitignore` automatically.

## Runtime state

Apps that write into `~/.config/<app>/` write into this repo through
the junction. Per-machine state (atuin db, copyq logs, gh OAuth,
shun history, opencode `node_modules`, …) lives on disk so the apps
keep working, but is excluded from git via `.gitignore` so it never
ends up in commits.

## License

Personal config — no claim to fitness for any purpose. Borrow what's
useful, leave the rest.

[yui]: https://github.com/yukimemi/yui
