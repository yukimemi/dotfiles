<#
  .SYNOPSIS
    setup.ps1
  .DESCRIPTION
    Initial windows setup scripts.
  .OUTPUTS
    - 0: SUCCESS / 1: ERROR
  .Last Change : 2025/09/19 04:37:27.
#>
$ErrorActionPreference = "Stop"
$DebugPreference = "SilentlyContinue" # Continue SilentlyContinue Stop Inquire
# Enable-RunspaceDebug -BreakAll

<#
  .SYNOPSIS
    log
  .DESCRIPTION
    log message
  .INPUTS
    - msg
    - color
  .OUTPUTS
    - None
#>
function log {
  [CmdletBinding()]
  [OutputType([void])]
  param([string]$msg, [string]$color)
  trap {
    Write-Host "[log] Error $_" "Red"; throw $_
  }

  $now = Get-Date -f "yyyy/MM/dd HH:mm:ss.fff"
  if ($color) {
    Write-Host -ForegroundColor $color "${now} ${msg}"
  } else {
    Write-Host "${now} ${msg}"
  }
}

<#
  .SYNOPSIS
    New-Shortcut
  .DESCRIPTION
    Create new shortcut.
#>
function New-Shortcut {
  [CmdletBinding()]
  [OutputType([void])]
  param([string]$link, [string]$target)

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

<#
  .SYNOPSIS
    Install-Neovim
  .DESCRIPTION
    Install neovim
#>
function Install-Neovim {
  [CmdletBinding()]
  [OutputType([void])]
  param()
  trap {
    log "[Install-Neovim] Error $_"; throw $_
  }
  $nvimMsi = Join-Path $env:tmp "nvim-win64.msi"
  Invoke-WebRequest -Uri "https://github.com/neovim/neovim/releases/download/nightly/nvim-win64.msi" -OutFile $nvimMsi
  & msiexec /i $nvimMsi /quiet
  # winget install -q Neovim.Neovim
}

<#
  .SYNOPSIS
    Install-RequiredModules
  .DESCRIPTION
    Install require apps.
#>
function Install-RequiredModules {
  # winget install -q topgrade-rs.topgrade
  winget install -q BurntSushi.ripgrep.MSVC
  winget install -q alexpasmantier.television
  winget install -q junegunn.fzf
  winget install -q sharkdp.fd
  winget install -q dandavison.delta
  # winget install -q LGUG2Z.komorebi
  # winget install -q LGUG2Z.whkd
  winget install -q gerardog.gsudo
  winget install -q Slackadays.Clipboard
  winget install -q Flameshot.Flameshot
  # winget install -q JesseDuffield.lazygit
  # winget install -q NuShell.NuShell
  winget install -q RustLang.Rustup
  winget install -q Microsoft.WindowsTerminal
  winget install -q Microsoft.PowerToys
  winget install -q Git.Git
  winget install -q GitHub.cli
  winget install -q AutoHotkey.AutoHotkey
  winget install -q Espanso.Espanso
  # winget install -q Starship.Starship
  # winget install -q Microsoft.VisualStudioCode
  winget install -q WinMerge.WinMerge
  # winget install -q SlackTechnologies.Slack
  winget install -q Chocolatey.Chocolatey
  winget install -q zig.zig
  # winget install -q GoLang.Go
  winget install -q Microsoft.PowerShell
  winget install -q Neovide.Neovide
  winget install -q hluk.CopyQ
  winget install -q Byron.dua-cli
  # winget install -q dalance.procs
  sudo choco install -y zig
}

<#
  .SYNOPSIS
    Set-RequiredEnv
  .DESCRIPTION
    setx required env
#>
function Set-RequiredEnv {
  setx CARGO_NET_GIT_FETCH_WITH_CLI "true"
  setx YAZI_FILE_ONE "C:\Program Files\Git\usr\bin\file.exe"
  setx PATH "${env:USERPROFILE}\.cargo\bin;${env:USERPROFILE}\.deno\bin;${env:USERPROFILE}\.bun\bin;${env:USERPROFILE}\go\bin;${env:LOCALAPPDATA}\Microsoft\WindowsApps;${env:LOCALAPPDATA}\Programs\Espanso;%APPDATA%\npm;${env:LOCALAPPDATA}\Microsoft\WindowsApps;${env:LOCALAPPDATA}\Microsoft\WinGet\Links;${env:LOCALAPPDATA}\mise\shims;${env:LOCALAPPDATA}\Programs\WinMerge"
}

<#
  .SYNOPSIS
    Install-RequiredCargo
  .DESCRIPTION
    Install cargo modules
#>
function Install-RequiredCargo {
  cargo install ouch
  cargo install yazi-fm
  cargo install yazi-cli
  cargo +nightly install dua-cli
  cargo install du-dust
  cargo install zoxide
  cargo install television
  cargo install git-delta
  cargo install bat
  cargo install ripgrep
  cargo install starship
}

<#
  .SYNOPSIS
    Change-CapsLock2Ctrl
  .DESCRIPTION
    Change capslock to ctrl.
#>
function Change-CapsLock2Ctrl {
  [CmdletBinding()]
  [OutputType([void])]
  param()
  trap {
    log "[Change-CapsLock2Ctrl] Error $_"; throw $_
  }

  $regPath = "HKLM\SYSTEM\CurrentControlSet\Control\Keyboard Layout"
  $regValueName = "Scancode Map"
  # To map Caps Lock (0x3A) to Left Control (0x1D)
  $regValueData = "0000000000000000020000001d003a0000000000"

  log "Setting Scancode Map to change CapsLock to Ctrl"
  try {
    # Use gsudo to run reg.exe with admin privileges
    $command = "reg add `"$regPath`" /v `"$regValueName`" /t REG_BINARY /d $regValueData /f"
    gsudo cmd /c $command
    log "Successfully set Scancode Map. Please reboot your computer to apply the changes." "Yellow"
  } catch {
    log "Failed to set Scancode Map. Please make sure you are running this script as an administrator." "Red"
    log $_ "Red"
  }
}

<#
  .SYNOPSIS
    Main
  .DESCRIPTION
    Execute main
  .INPUTS
    - None
  .OUTPUTS
    - Result - 0 (SUCCESS), 1 (ERROR)
#>
function Start-Main {
  [CmdletBinding()]
  [OutputType([int])]
  param()

  try {
    log "[Start-Main] Start"

    Set-RequiredEnv
    Change-CapsLock2Ctrl

    # Invoke-RestMethod https://deno.land/install.ps1 | Invoke-Expression
    # Invoke-RestMethod https://astral.sh/uv/install.ps1 | Invoke-Expression

    Install-Neovim
    Install-RequiredModules
    # Install-RequiredCargo

    # Copy clnch.
    curl -O https://crftwr.github.io/clnch/download/clnch_340.zip
    tar zxvf .\clnch_340.zip
    & robocopy /e /r:1 /w:1 .\clnch ([System.IO.Path]::Combine($env:USERPROFILE, "app\clnch"))
    Remove-Item -Force .\clnch_340.zip
    Remove-Item -Force -Recurse .\clnch

    $target = Join-Path -Path $env:USERPROFILE -ChildPath ".dotfiles\win\AutoHotkey\AutoHotkey.ahk"
    $link = Join-Path -Path $env:APPDATA -ChildPath "Microsoft\Windows\Start Menu\Programs\Startup\AutoHotkey.lnk"
    New-Shortcut -link $link -target $target

    $target = Join-Path -Path $env:USERPROFILE -ChildPath "app\clnch\clnch.exe"
    $link = Join-Path -Path $env:APPDATA -ChildPath "Microsoft\Windows\Start Menu\Programs\Startup\clnch.lnk"
    New-Shortcut -link $link -target $target

    $target = Join-Path -Path $env:USERPROFILE -ChildPath "app\AlterDnD\AlterDnD64.exe"
    $link = Join-Path -Path $env:APPDATA -ChildPath "Microsoft\Windows\Start Menu\Programs\Startup\AlterDnD64.lnk"
    New-Shortcut -link $link -target $target

    exit 0
  } catch {
    log "Error ! $_" "Red"
    exit 1
  } finally {
    log "[Start-Main] End"
  }
}

# Call main.
Start-Main
