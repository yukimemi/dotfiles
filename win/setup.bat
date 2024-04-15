@echo off
REM setlocal enabledelayedexpansion
REM ======================================================================
set tm=%time: =0%
set today=%date:~-10,4%%date:~-5,2%%date:~-2,2%
set nowtime=%tm:~0,2%%tm:~3,2%%tm:~6,2%%tm:~9,2%
set now=%today%_%nowtime%
set cmdDir=%~dp0
set cmdFile=%~f0
set cmdName=%~n0
set cmdFileName=%~nx0
REM ======================================================================

pushd "%cmdDir%"

winget install -q gsudo
winget install -q RustLang.Rustup
winget install -q DenoLand.Deno
winget install -q Microsoft.WindowsTerminal
winget install -q Microsoft.PowerToys
winget install -q Git.Git
winget install -q GitHub.cli
winget install -q AutoHotkey.AutoHotkey
winget install -q Espanso.Espanso
winget install -q Starship.Starship
winget install -q Microsoft.VisualStudioCode
winget install -q Neovim.Neovim
winget install -q WinMerge.WinMerge
winget install -q SlackTechnologies.Slack
winget install -q Chocolatey.Chocolatey
winget install -q zig.zig
winget install -q GoLang.Go
winget install -q Microsoft.PowerShell
winget install -q Neovide.Neovide
winget install -q BurntSushi.ripgrep.MSVC
winget install -q sharkdp.bat
winget install -q junegunn.fzf
winget install -q ajeetdsouza.zoxide

set exitCode=%errorlevel%
echo Exit Code: [%exitCode%]

pause
popd

exit /b %exitCode%

