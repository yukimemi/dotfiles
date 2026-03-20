# my dotfiles

## Setup

### macOS

1.  **Install Xcode Command Line Tools** (Required for `git` and `brew`):
    ```sh
    xcode-select --install
    ```
    *Wait for the installation to complete.*

2.  **Initialize Dotfiles**:
    ```sh
    sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply yukimemi
    ```
    *This will automatically install Homebrew, mise, and all CLI tools (gh, nvim, etc.).*

### Linux

```sh
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply yukimemi
```

### Windows

```powershell
winget install gerardog.gsudo --source winget
gsudo winget settings --enable BypassCertificatePinningForMicrosoftStore
winget upgrade Microsoft.AppInstaller --accept-source-agreements --accept-package-agreements
gsudo winget settings --disable BypassCertificatePinningForMicrosoftStore
winget install twpayne.chezmoi --source winget
chezmoi init --apply yukimemi
powershell -ExecutionPolicy ByPass -File (Join-Path (chezmoi source-path) "win/setup.ps1")
```

