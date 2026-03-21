# my dotfiles

## Setup

### macOS

1.  **Install Xcode Command Line Tools**:
    ```sh
    xcode-select --install
    ```
    *Wait for the installation to complete.*

2.  **Initialize Dotfiles**:
    ```sh
    sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply yukimemi
    ```
    *This will automatically install Homebrew, mise, and all CLI tools.*

### Linux

```sh
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply yukimemi
```

### Windows

```powershell
winget install twpayne.chezmoi --source winget
chezmoi init --apply yukimemi
```
*This will automatically install scoop, winget packages, and all CLI tools.*
