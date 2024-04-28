function log {
  param([string]$msg)
  trap {
    Write-Host "[log] Error $_"
  }
  $now = Get-Date -f "yyyy/MM/dd HH:mm:ss.fff"
  Write-Host "${now} ${msg}"
}

function Install-RequiredModules {
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
}

function New-Shortcut {
  param (
    [string]$link,
    [string]$target
  )

  if (!(Test-Path $target)) {
    log "${target} is not found !"
    return
  }

  $wsh = New-Object -ComObject WScript.Shell
  $shortcut = $wsh.CreateShortcut($link)
  $shortcut.TargetPath = $target
  $shortcut.WorkingDirectory = Split-Path -Path $target
  Write-Host "Created shortcut: ${link} -> ${target}"
  $shortcut.Save()
}

Install-RequiredModules

$target = Join-Path -Path $env:USERPROFILE -ChildPath ".dotfiles\win\AutoHotkey\AutoHotkey.ahk"
$link = Join-Path -Path $env:APPDATA -ChildPath "Microsoft\Windows\Start Menu\Programs\Startup\AutoHotkey.lnk"
New-Shortcut -link $link -target $target

$target = "C:\Program Files (x86)\clnch\clnch.exe"
$link = Join-Path -Path $env:APPDATA -ChildPath "Microsoft\Windows\Start Menu\Programs\Startup\clnch.lnk"
New-Shortcut -link $link -target $target

