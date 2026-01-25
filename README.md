# my dotfiles

## Setup

### Linux / Mac

```sh
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply yukimemi
```

### Windows

```powershell
winget install TWPayne.chezmoi
chezmoi init --apply yukimemi
powershell -ExecutionPolicy ByPass -File (Join-Path (chezmoi source-path) "win/setup.ps1")
```

