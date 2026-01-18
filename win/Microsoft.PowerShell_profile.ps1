# =============================================================================
# File        : Microsoft.PowerShell_profile.ps1
# Author      : yukimemi
# Last Change : 2026/01/12 16:54:20.
# =============================================================================

# --- Pre-Environment Setup ---
$ErrorActionPreference = "Continue"

# --- Environment Setup ---
$Host.UI.RawUI.WindowTitle = "yukimemi-terminal"

function Test-IsWindows {
    ($PSVersionTable.PSVersion.Major -eq 5) -or ($PSVersionTable.Platform -eq "Win32NT")
}

function Test-IsWsl {
    if (Test-IsWindows) { return $false }
    return (Test-Path /proc/version) -and (Get-Content /proc/version | Select-String "microsoft" -Quiet)
}

function Get-DriveInfo {
    Get-PSDrive -PSProvider FileSystem | Where-Object { $_.Used -and $_.Name -ne "Temp" } | Sort-Object Name
}

function Get-DriveInfoView {
    Get-DriveInfo | Format-Table -AutoSize
}
Set-Alias -Name df -Value Get-DriveInfoView -Force

if (Test-IsWindows) {
    [Console]::InputEncoding = [Console]::OutputEncoding = [System.Text.Encoding]::UTF8
}
$env:LANG = "ja_JP.UTF-8"
$env:EDITOR = "nvim"

# Browser
if (Test-IsWsl) {
    $winLocalAppData = (wslpath (/mnt/c/Windows/System32/cmd.exe /c "echo %LOCALAPPDATA%" 2>$null).Trim())
    $cometPath = "$winLocalAppData/Perplexity/Comet/Application/comet.exe"
    $chromePath = "/mnt/c/Progra~1/Google/Chrome/Application/chrome.exe"

    if (Test-Path $cometPath) {
        $env:BROWSER = $cometPath
    } elseif (Test-Path $chromePath) {
        $env:BROWSER = $chromePath
    }
} elseif (!(Test-IsWindows)) {
    $env:BROWSER = "chromium-browser"
}

# --- Path Setup ---
$PathSeparator = [IO.Path]::PathSeparator
$UserHome = if (Test-IsWindows) { $env:USERPROFILE } else { $env:HOME }

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
        $starshipName = if (Test-IsWindows) { "starship.exe" } else { "starship" }
        $zoxideName = if (Test-IsWindows) { "zoxide.exe" } else { "zoxide" }
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
$LazyProfileModule = Join-Path $HOME ".dotfiles/win/LazyProfile.psm1"

if (Test-Path $ZoxideInit) {
    . $ZoxideInit
}

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
