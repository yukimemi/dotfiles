# yukimemi's dotfiles

[yui]-managed dotfiles repository.

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
    └── bin/                     # hook scripts
        ├── mac-init.sh          # once / pre  / yui.os == 'macos'
        ├── brew-bundle.sh       # every / post / yui.os == 'macos'
        ├── setup-arch.sh        # onchange / post / installed Arch only
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

Review the `[[hook]]` entries in `config.toml` before applying. Hooks can
install software or change system configuration in addition to linking
your dotfiles.

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

Per-machine app choices (`browser`, `editor`, `use_excel`) also live in
`[vars]`; override them in the untracked `config.local.toml`.

## Arch desktop initialization

`.yui/bin/setup-arch.sh` installs the niri/Noctalia desktop packages, Japanese
input modules, Brave (`brave-bin`), and PlemolJP (`ttf-plemoljp-bin`). It runs
as the normal user through yay, with a full `-Syu` and normal package/AUR
review prompts. A missing yay is bootstrapped with `makepkg -si` after an
interactive review of the `yay-bin` recipe; an existing sudo-capable account
and working network on installed Arch are required. It does not install Arch
itself, partition disks, change passwords, or reboot.

The hook is `post` + `onchange`, gated by Linux and `vars.production`.
Because yui has no distro predicate, the script checks `/etc/os-release`
for exactly `ID=arch` before doing work; other distributions skip it.
The WSL hook separately checks the kernel and skips native Arch/Linux.
On Arch under WSL, the Arch hook preserves WSL-managed login/networking
instead of enabling native desktop system services.

Initialization is deliberately separate from yui-owned application settings:

- **greetd + tuigreet:** installed/configured only when no other installed,
  enabled or running display manager is found. Existing display-manager
  selections are preserved. A differing `/etc/greetd/config.toml` requires
  an explicit `yes` before a backup and atomic replacement. Changing an
  existing boot default to `graphical.target` needs its own confirmation.
  Login remains password-protected; no autologin is configured.
- **NetworkManager:** installed/enabled only when no enabled/running alternative
  manager/component (`systemd-networkd`, ConnMan, dhcpcd, netctl or iwd) is
  found. Existing networking is never disabled. System services are enabled
  for the next normal boot, never started or restarted by this script.
- **OMP:** when absent, the official `https://omp.sh/install` runs as the
  normal user. Existing working OMP installations are retained, not updated
  merely because this hook changed. Bash/Zsh PATH setup preserves existing
  settings and yui symlinks; edits to existing login files require `yes`
  and a backup. Bash's existing login-file precedence is respected.
- **Fcitx/Mozc:** a missing profile is atomically initialized with `keyboard-jp`
  and Mozc. Any existing profile is preserved, including a per-file symlink;
  concurrent first-run initialization cannot replace it. The mutable profile
  stays out of git. A new screenshot directory is private (0700); existing
  directories keep their permissions.

Normal package upgrade hooks still apply. User application settings remain in
`home/.config` and are not reset by this initializer. New session settings
take effect at the next login; the script does not interrupt the desktop.
Provider credentials are neither copied nor automatically authenticated.
The standalone `arch-niri-setup` installer is not called or required for this
installed-system desktop initialization; it must not overwrite yui's settings.

Run just this hook without applying unrelated hooks or decrypting secrets:

```sh
yui --source "$HOME/dotfiles" hooks run setup-arch
```

An unchanged successful script is skipped on subsequent applies. To deliberately
check for package updates again, use `hooks run setup-arch --force`.

Local preservation/policy regressions require no sudo, downloads or service
starts:

```sh
bash .yui/tests/setup-arch.sh
```

Real initialization smoke checks also exercised a private system root with
the real `install`/`systemctl`, explicit configuration/boot-target consent,
backups and manager conflicts, plus the actual official OMP installer in an
empty temporary HOME. These checks do not replace a new-machine boot,
greetd/PAM login or network-connection test.

On Arch/niri, `Super+B` and the XDG web associations use Brave.
`home/.config/brave-flags.conf` enables Wayland IME/text-input-v3 while keeping
the browser sandbox enabled. Chromium's existing profile and installation
are retained. The separate shun/F11 choice in `vars.browser` is left unchanged;
override it per machine in `config.local.toml` if needed.
Brave's own Sync is not Google Chrome Sync.

`home/.config/BraveSoftware/` contains browser profiles, cookies, passwords,
and Sync keys and is ignored by git. Never commit or copy those credentials
into setup storage; configure Sync yourself in the browser.

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

## Magi persona icons

`home/.config/magi/config.toml` sets display-only icons for all eight built-in
personas; their names and voice prompts remain unchanged. The images are
192×192 face crops from Bandai's Niformation Evangelion artwork; sources and
private-use terms are recorded beside the settings.

Only `home/.config/magi/icons/*.png.age` belongs in version control.
`yui apply` decrypts the ignored `.png` siblings, which magi reads from
`~/.config/magi/icons/` on every OS. To replace one, update its PNG and run
`yui secret encrypt --force home/.config/magi/icons/<id>.png`.
Encryption does not grant permission to redistribute the artwork or key.

## Alacritty font

`home/.config/alacritty/alacritty.toml` uses **PlemolJP Console NF**.
Install that font family on each machine separately; on Arch it is included in
the AUR package `ttf-plemoljp-bin`. Font binaries are not stored in this repo.

The legacy YAML was migrated with `alacritty migrate`; the existing 13pt size,
padding, opacity, and cursor settings were retained. Live reload now uses
`[general].live_config_reload`. With the `.config` directory link already
applied, new Alacritty processes read the TOML directly without another
`yui apply`.

## Shikigami AI messages

The PowerShell profile and Windows setup's user environment both set
`SHIKIGAMI_AI_CMD` to OMP with `anthropic/claude-haiku-5-5` and thinking off.
Shikigami pipes the selected change's diff to stdin; `Ctrl-g` in a description
prompt requests one short English commit summary. Built-in tools, discovered
extensions/rules/skills and session saving are disabled for this command.
The model is explicit: missing Anthropic access fails instead of selecting
another model. Interactive OMP's normal model setting is not changed.

OMP must be on PATH and Anthropic access configured separately on each machine,
for example with `omp login anthropic` or an `ANTHROPIC_API_KEY` supplied by
your credential manager. Claude CLI credentials are not migrated by this
configuration. Never store provider credentials in the repository.

Restart PowerShell and shikigami after applying: shikigami reads the command
once at startup. The Windows setup also updates the persisted user environment;
other existing terminals need to be reopened to see that update.

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
