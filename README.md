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
│   ├── .gemini/                 # global Gemini config
│   ├── .vscode/                 # global VSCode user settings
│   ├── .glzr/                   # GlazeWM config
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

## Apply

Install [yui]:

```sh
cargo install yui-cli
```

Then from this repo:

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
home_root = "~"        # set to "~/yui-test" for a safe trial run
production = true      # set to false to disable Windows-extras + the
                       # windows-setup hook (test mode)
```

For a fresh-machine bootstrap or a risky reorg, flip both
(`home_root = "~/yui-test"`, `production = false`), `yui apply`,
inspect the result, then flip back.

## Templates

Three files use Tera (`*.tera` → `*.<ext>` rendered as a sibling):

- `home/.config/autohotkey/AutoHotkey.ahk.tera` — gates Excel /
  Outlook / Neovim shortcuts on `vars.autohotkey.*` flags.
- `home/.config/zellij/config/config.kdl.tera` — Linux uses `Ctrl-t`,
  others use `Ctrl-b`.
- `home/.config/todoke/todoke.toml.tera` — selects the GUI editor
  (neovide / nvim-qt / nvim) at build time, lets todoke render the
  rest at dispatch.

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
