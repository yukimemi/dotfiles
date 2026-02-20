sudo [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
winget install -q RustLang.Rustup
winget install -q Chocolatey.Chocolatey
winget install -q gsudo
sudo choco install cmake --installargs '"ADD_CMAKE_TO_PATH=System"' -y
sudo choco install llvm -y
cargo install --force --git https://github.com/neovide/neovide.git
