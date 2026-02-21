# =============================================================================
# File        : Microsoft.PowerShell_profile.ps1
# Author      : yukimemi
# Last Change : 2026/01/28 19:01:42.
# =============================================================================

# --- Pre-Environment Setup ---
if ($null -eq $IsWindows) { $IsWindows = $true }
if ($null -eq $IsMacOS) { $IsMacOS = $false }
if ($null -eq $IsLinux) { $IsLinux = $false }
$ErrorActionPreference = "Continue"

# --- Environment Setup ---
$Host.UI.RawUI.WindowTitle = "yukimemi-terminal"

function Test-IsWsl {
  if ($IsWindows) {
    return $false
  }
  return (Test-Path /proc/version) -and (Get-Content /proc/version | Select-String "microsoft" -Quiet)
}

function Get-DriveInfo {
  Get-PSDrive -PSProvider FileSystem | Where-Object { $_.Used -and $_.Name -ne "Temp" } | Sort-Object Name
}

function Get-DriveInfoView {
  Get-DriveInfo | Format-Table -AutoSize
}
Set-Alias -Name df -Value Get-DriveInfoView -Force

if ($IsWindows) {
  [Console]::InputEncoding = [Console]::OutputEncoding = [System.Text.Encoding]::UTF8
}
$env:LANG = "ja_JP.UTF-8"
$env:EDITOR = "nvim"

# Browser
if (Test-IsWsl) {
  try {
    $winCmd = "/mnt/c/Windows/System32/cmd.exe"
    if (Test-Path $winCmd) {
      $winLocalAppData = (wslpath (& $winCmd /c "echo %LOCALAPPDATA%" 2>$null).Trim())
      $cometPath = "$winLocalAppData/Perplexity/Comet/Application/comet.exe"
      $chromePath = "/mnt/c/Progra~1/Google/Chrome/Application/chrome.exe"

      if (Test-Path $cometPath) {
        $env:BROWSER = $cometPath
      } elseif (Test-Path $chromePath) {
        $env:BROWSER = $chromePath
      }
    } else {
      $env:BROWSER = "chromium-browser"
    }
  } catch {
    $env:BROWSER = "chromium-browser"
  }
} elseif (!($IsWindows)) {
  $env:BROWSER = "chromium-browser"
}

# --- Path Setup ---
$PathSeparator = [IO.Path]::PathSeparator
$UserHome = if ($IsWindows) {
  $env:USERPROFILE
} else {
  $env:HOME
}

# Private Config
$PrivateConfig = Join-Path $UserHome "src/github.com/yukimemi/private/.config_private.ps1"
if (Test-Path $PrivateConfig) {
  . $PrivateConfig
}

$AdditionalPaths = @(
  (Join-Path $UserHome ".cargo/bin"),
  (Join-Path $UserHome ".bun/bin"),
  (Join-Path $UserHome ".deno/bin"),
  (Join-Path $UserHome "go/bin")
)

foreach ($p in $AdditionalPaths) {
  if ((Test-Path $p) -and ($env:PATH -notlike "*$p*")) {
    $env:PATH = "$p$PathSeparator" + $env:PATH
  }
}

if (Get-Command mise -ErrorAction SilentlyContinue) {
  Invoke-Expression (mise activate pwsh | Out-String)
}

# --- Cache & Auto-Generation ---
$CacheDir = Join-Path $HOME ".cache/pwsh"
if (!(Test-Path $CacheDir)) {
  New-Item -ItemType Directory -Force -Path $CacheDir | Out-Null
}

$StarshipInit = Join-Path $CacheDir "starship_init.ps1"
$ZoxideInit = Join-Path $CacheDir "zoxide_init.ps1"

# Generate cache if missing
if (!(Test-Path $StarshipInit) -or !(Test-Path $ZoxideInit)) {
  Write-Host "Generating initialization cache..." -ForegroundColor Cyan

  # Temporarily remove shims from PATH to avoid recursion error
  $OldPath = $env:PATH
  $env:PATH = ($env:PATH -split $PathSeparator | Where-Object { $_ -notlike "*mise/shims*" -and $_ -notlike "*mise\shims*" }) -join $PathSeparator

  try {
    $starshipName = if ($IsWindows) {
      "starship.exe"
    } else {
      "starship"
    }
    $zoxideName = if ($IsWindows) {
      "zoxide.exe"
    } else {
      "zoxide"
    }
    $starshipExe = (Get-Command $starshipName -ErrorAction SilentlyContinue).Source
    $zoxideExe = (Get-Command $zoxideName -ErrorAction SilentlyContinue).Source

    if ($starshipExe) {
      & $starshipExe init powershell --print-full-init | Set-Content $StarshipInit -Encoding utf8
    }
    if ($zoxideExe) {
      & $zoxideExe init powershell | Set-Content $ZoxideInit -Encoding utf8
    }
  } finally {
    # Restore PATH
    $env:PATH = $OldPath
  }
}

# --- Static Loading (Fastest) ---
$ConfigHome = if ($env:XDG_CONFIG_HOME) {
  $env:XDG_CONFIG_HOME
} else {
  Join-Path $HOME ".config"
}
$LazyProfileModule = Join-Path $ConfigHome "powershell/LazyProfile.psm1"

if (Test-Path $StarshipInit) {
  . $StarshipInit

  # Hook into Starship pre-command to load heavy profile lazily
  $global:LastAutoJjPath = ""
  function global:Invoke-Starship-PreCommand {
    if ($null -ne $global:LazyProfilePath) {
      $path = $global:LazyProfilePath
      $global:LazyProfilePath = $null # Clear to run only once
      Import-Module -Global $path -ErrorAction SilentlyContinue
    }

    # Auto jj init
    $currentPath = (Get-Location).Path
    if ($currentPath -ne $global:LastAutoJjPath) {
      $global:LastAutoJjPath = $currentPath
      if ((Test-Path -LiteralPath ".git" -PathType Container) -and -not (Test-Path -LiteralPath ".jj" -PathType Container)) {
        Write-Host "Initializing jujutsu in git repo..." -ForegroundColor Cyan
        jj git init --colocate
      }
    }

    $mode = (Get-PSReadLineOption).ViMode
    $env:STARSHIP_VIM_MODE = if ($mode -eq "Command") {
      "normal"
    } else {
      "insert"
    }
  }
  $global:LazyProfilePath = $LazyProfileModule
} elseif (Test-Path $LazyProfileModule) {
  Import-Module -Global $LazyProfileModule -ErrorAction SilentlyContinue
}

if (Test-Path $ZoxideInit) {
  . $ZoxideInit
}
