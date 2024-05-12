# my dotfiles

## Linux / Mac

Copy and paste it.

```sh
curl -fsS https://pkgx.sh | sh
pkgx cargo install --git https://github.com/ubnt-intrepid/dot.git
dot init yukimemi/dotfiles

# and then
zsh
```

## Windows

- First Install BuildTools

```bat
winget install Microsoft.VisualStudio.2022.BuildTools --override "--add Microsoft.VisualStudio.Workload.VCTools"
```

After installed, reboot OS.

[Use command-line parameters to install Visual Studio | Microsoft Learn](https://learn.microsoft.com/en-us/visualstudio/install/use-command-line-parameters-to-install-visual-studio)

- Execute setup.bat

```bat
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/yukimemi/dotfiles/main/win/setup.ps1" -OutFile "setup.ps1"
powershell -File .\setup.ps1
```

- dot init

```bat
git config --global core.autocrlf false
git clone https://github.com/yukimemi/dotfiles .dotfiles
rustup default stable
cargo install --git https://github.com/ubnt-intrepid/dot.git
cd .dotfiles
sudo dot link
```
