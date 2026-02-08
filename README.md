# my dotfiles

## Setup

### Linux / Mac

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

