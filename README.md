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
winget install Microsoft.VisualStudio.2022.BuildTools
```

After installed, open Visual Studio Installer and add C++ Desktop app.
Reboot.

- Execute setup.bat

```bat
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/yukimemi/dotfiles/main/win/setup.bat" -OutFile "setup.bat"
& .\setup.bat
```

- dot init

```bat
git config --global core.autocrlf false
git clone https://github.com/yukimemi/dotfiles .dotfiles
cargo install --git https://github.com/ubnt-intrepid/dot.git
rustup default stable
cd .dotfiles
sudo dot link
```
