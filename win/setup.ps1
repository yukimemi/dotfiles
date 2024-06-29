<#
  .SYNOPSIS
    setup.ps1
  .DESCRIPTION
    Initial windows setup scripts.
  .OUTPUTS
    - 0: SUCCESS / 1: ERROR
  .Last Change : 2024/06/22 16:44:29.
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
    Install-RequiredModules
  .DESCRIPTION
    Install require apps.
#>
function Install-RequiredModules {
  $nvimMsi = Join-Path $env:tmp "nvim-win64.msi"
  Invoke-WebRequest -Uri "https://github.com/neovim/neovim/releases/download/nightly/nvim-win64.msi" -OutFile $nvimMsi
  & msiexec /i $nvimMsi /quiet
  # winget install -q Neovim.Neovim
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
  winget install -q WinMerge.WinMerge
  winget install -q SlackTechnologies.Slack
  winget install -q Chocolatey.Chocolatey
  winget install -q zig.zig
  winget install -q GoLang.Go
  winget install -q Microsoft.PowerShell
  winget install -q Neovide.Neovide
  winget install -q BurntSushi.ripgrep.MSVC
  winget install -q sharkdp.bat
  winget install -q dandavision.delta
  winget install -q junegunn.fzf
  winget install -q ajeetdsouza.zoxide
  sudo winget install hluk.CopyQ
  sudo choco install -y zig
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

    Install-RequiredModules

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

