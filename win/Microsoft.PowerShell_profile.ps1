# =============================================================================
# File        : Microsoft.PowerShell_profile.ps1
# Author      : yukimemi
# Last Change : 2026/01/04 10:52:00.
# =============================================================================

# --- Pre-Environment Setup ---
$ErrorActionPreference = "Continue"

# --- Environment Setup ---
$Host.UI.RawUI.WindowTitle = "yukimemi-terminal"

function Test-IsWindows {
    ($PSVersionTable.PSVersion.Major -eq 5) -or ($PSVersionTable.Platform -eq "Win32NT")
}

if (Test-IsWindows) {
    [Console]::InputEncoding = [Console]::OutputEncoding = [System.Text.Encoding]::UTF8
    $env:LANG = "ja_JP.UTF-8"
    $env:EDITOR = "hitori"

    $MiseShims = "$env:LOCALAPPDATA\mise\shims"
    if (Test-Path $MiseShims) {
        if ($env:PATH -notlike "*$MiseShims*") {
            $env:PATH = "$MiseShims;" + $env:PATH
        }

        # Fix for zoxide not finding fzf on Windows with mise shims
        $fzfExe = Get-Command fzf.exe -ErrorAction SilentlyContinue
        if (!$fzfExe) {
            $actualFzf = Resolve-Path "$env:LOCALAPPDATA\mise\installs\fzf\*\fzf.exe" -ErrorAction SilentlyContinue | Select-Object -First 1
            if ($actualFzf) {
                $fzfBinDir = Split-Path $actualFzf.Path
                if ($env:PATH -notlike "*$fzfBinDir*") {
                    $env:PATH = "$fzfBinDir;" + $env:PATH
                }
            }
        }
    }
}

# --- Cache & Auto-Generation ---
$CacheDir = Join-Path $HOME ".cache\pwsh"
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
    $env:PATH = ($env:PATH -split ';' | Where-Object { $_ -notlike "*mise\shims*" }) -join ';'

    try {
        $starshipExe = (Get-Command starship.exe -ErrorAction SilentlyContinue).Source
        $zoxideExe = (Get-Command zoxide.exe -ErrorAction SilentlyContinue).Source

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
$LazyProfileModule = "$env:USERPROFILE\.dotfiles\win\LazyProfile.psm1"

if (Test-Path $ZoxideInit) {
    . $ZoxideInit
}

if (Test-Path $StarshipInit) {
    . $StarshipInit

    # Hook into Starship pre-command to load heavy profile lazily
    function global:Invoke-Starship-PreCommand {
        if ($null -ne $global:LazyProfilePath) {
            $path = $global:LazyProfilePath
            $global:LazyProfilePath = $null # Clear to run only once
            Import-Module -Global $path -ErrorAction SilentlyContinue
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
