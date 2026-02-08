<#
  .SYNOPSIS
    setup.ps1
  .DESCRIPTION
    Initial windows setup scripts.
  .PARAMETER AdminOnly
    Internal use only. Skips user-level tasks and only runs admin tasks.
  .OUTPUTS
    - 0: SUCCESS / 1: ERROR
  .Last Change : 2026/02/08 13:38:24.
#>
param(
  [switch]$AdminOnly
)

$ErrorActionPreference = "Stop"
$DebugPreference = "SilentlyContinue"

# --- Helper Functions ---

function Test-IsAdmin {
  return ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
}

function Test-IsAdminGroup {
  # Check via whoami (reliable even under UAC restriction)
  $groups = whoami /groups
  if ($groups -match "S-1-5-32-544") {
    return $true 
  }

  # Fallback: Check local group membership directly
  $isAdmin = $false
  try {
    $user = [Security.Principal.WindowsIdentity]::GetCurrent().Name
    $group = [ADSI]"WinNT://./Administrators,group"
    $members = $group.psbase.Invoke("Members") | ForEach-Object { $_.GetType().InvokeMember("Name", 'GetProperty', $null, $_, $null) }
    if ($members -contains ($user -split "\\")[-1]) {
      $isAdmin = $true 
    }
  } catch {
  }

  return $isAdmin
}

function log {
  param([string]$msg, [string]$color = "Cyan")
  $now = Get-Date -f "yyyy/MM/dd HH:mm:ss.fff"
  Write-Host -ForegroundColor $color "${now} ${msg}"
}

function New-Shortcut {
  param([string]$link, [string]$target)
  if (!(Test-Path $target)) {
    log "${target} is not found !" "Red"
    return
  }

  if (Test-Path $link) {
    $wsh = New-Object -ComObject WScript.Shell
    $existing = $wsh.CreateShortcut($link)
    if ($existing.TargetPath -eq (Get-Item $target).FullName) {
      log "Shortcut already exists and points to correct target: $link" "Gray"
      return
    }
  }

  $wsh = New-Object -ComObject WScript.Shell
  $shortcut = $wsh.CreateShortcut($link)
  $shortcut.TargetPath = $target
  $shortcut.WorkingDirectory = Split-Path -Path $target
  $shortcut.Save()
  log "Created/Updated shortcut: ${link} -> ${target}" "Green"
}

function Install-BinaryArchive {
  param (
    [string]$Name,
    [string]$Url,
    [string]$DestinationDir
  )
  if (Test-Path $DestinationDir) {
    log "$Name is already installed at $DestinationDir" "Gray"
    return
  }

  log "Installing $Name from $Url ..." "Yellow"
  $tempZip = Join-Path $env:TEMP "$Name.zip"
  $tempExtract = Join-Path $env:TEMP "$Name-extract"

  if (Test-Path $tempExtract) {
    Remove-Item $tempExtract -Recurse -Force
  }
  New-Item -ItemType Directory $tempExtract | Out-Null

  # Download
  Invoke-WebRequest -Uri $Url -OutFile $tempZip -UseBasicParsing

  # Extract
  Expand-Archive -Path $tempZip -DestinationPath $tempExtract -Force

  # Move to destination
  if (!(Test-Path (Split-Path $DestinationDir -Parent))) {
    New-Item -ItemType Directory (Split-Path $DestinationDir -Parent) -Force | Out-Null
  }

  # If there is a single subdirectory inside, move its content instead
  $subDirs = Get-ChildItem $tempExtract -Directory
  $files = Get-ChildItem $tempExtract -File
  if ($subDirs.Count -eq 1 -and $files.Count -eq 0) {
    robocopy /e /r:1 /w:1 $subDirs[0].FullName $DestinationDir
  } else {
    robocopy /e /r:1 /w:1 $tempExtract $DestinationDir
  }

  # Cleanup
  Remove-Item $tempZip, $tempExtract -Recurse -Force
  log "Successfully installed $Name to $DestinationDir" "Green"
}

function Install-WingetPackages {
  param([string[]]$Packages)
  foreach ($pkg in $Packages) {
    log "Ensuring $pkg is installed via winget..."
    winget install -q $pkg --accept-source-agreements --accept-package-agreements
  }
}

function Install-BibataCursor {
  param (
    [string]$Version = "v2.0.7",
    [string]$Variant = "Bibata-Modern-Ice",
    [string]$Size = "Regular"
  )

  # Construct expected folder name part e.g. "Bibata-Modern-Ice-Regular"
  # Note: The actual folder in zip is like "Bibata-Modern-Ice-Regular-Windows"
  # We will use wildcard match *-$Size-*

  log "Installing $Variant ($Size) cursor..." "Yellow"
  $zipName = "${Variant}-Windows.zip"
  $url = "https://github.com/ful1e5/Bibata_Cursor/releases/download/${Version}/${zipName}"
  $tempZip = Join-Path $env:TEMP $zipName
  $tempExtract = Join-Path $env:TEMP "$Variant-extract"

  if (Test-Path $tempExtract) {
    Remove-Item $tempExtract -Recurse -Force
  }
  New-Item -ItemType Directory $tempExtract | Out-Null

  try {
    Invoke-WebRequest -Uri $url -OutFile $tempZip -UseBasicParsing
    Expand-Archive -Path $tempZip -DestinationPath $tempExtract -Force

    # Find install.inf matching the size
    $infFiles = Get-ChildItem -Path $tempExtract -Filter "install.inf" -Recurse
    $targetInf = $null

    foreach ($f in $infFiles) {
      if ($f.DirectoryName -match "-$Size-") {
        $targetInf = $f
        break
      }
    }

    # Fallback to first if not found (or if Size is invalid)
    if (-not $targetInf) {
      $targetInf = $infFiles | Select-Object -First 1
    }
    $infFile = $targetInf

    if ($infFile) {
      log "Making installation silent by removing RunOnce from install.inf ($($infFile.Directory.Name))..."
      $content = Get-Content $infFile.FullName
      $content | Where-Object { $_ -notmatch 'Runonce.*main\.cpl' } | Set-Content $infFile.FullName -Encoding ASCII

      log "Executing modified install.inf..."
      $command = "rundll32.exe setupapi.dll,InstallHinfSection DefaultInstall 128 $($infFile.FullName)"

      if (Test-IsAdmin) {
        cmd /c $command
      } elseif (Get-Command gsudo -ErrorAction SilentlyContinue) {
        gsudo cmd /c $command
      } else {
        Start-Process cmd -ArgumentList "/c $command" -Verb RunAs -Wait
      }

      log "Refreshing system cursors..."
      $csharp = '[DllImport("user32.dll")] public static extern bool SystemParametersInfo(uint uiAction, uint uiParam, uint pvParam, uint fWinIni);'
      try {
        Add-Type -MemberDefinition $csharp -Name WinAPI -Namespace User32 -ErrorAction SilentlyContinue
      } catch {
      }
      # SPI_SETCURSORS = 0x0057, SPIF_UPDATEINIFILE = 0x01, SPIF_SENDCHANGE = 0x02
      [User32.WinAPI]::SystemParametersInfo(0x0057, 0, 0, 0x03) | Out-Null

      log "$Variant ($Size) installed and applied successfully." "Green"
    } else {
      log "install.inf not found in downloaded archive for $Variant." "Red"
    }
  } catch {
    log "Failed to install ${Variant}: $_" "Red"
  } finally {
    if (Test-Path $tempZip) {
      Remove-Item $tempZip -Force
    }
    if (Test-Path $tempExtract) {
      Remove-Item $tempExtract -Recurse -Force
    }
  }
}

# --- Setup Logic ---

function Set-RequiredEnv {
  log "Checking environment variables..."
  $envVars = @{
    "CARGO_NET_GIT_FETCH_WITH_CLI" = "true"
    "YAZI_FILE_ONE"                = "C:\Program Files\Git\usr\bin\file.exe"
    "XDG_CONFIG_HOME"              = "${env:USERPROFILE}\.config"
  }
  foreach ($key in $envVars.Keys) {
    $current = [Environment]::GetEnvironmentVariable($key, "User")
    if ($current -ne $envVars[$key]) {
      [Environment]::SetEnvironmentVariable($key, $envVars[$key], "User")
      log "Set $key = $($envVars[$key])" "Green"
    }
  }

  $targetPaths = @(
    "${env:USERPROFILE}\.cargo\bin",
    "${env:USERPROFILE}\.deno\bin",
    "${env:USERPROFILE}\.bun\bin",
    "${env:USERPROFILE}\go\bin",
    "${env:LOCALAPPDATA}\Microsoft\WindowsApps",
    "${env:LOCALAPPDATA}\Programs\Espanso",
    "${env:APPDATA}\npm",
    "${env:LOCALAPPDATA}\Microsoft\WinGet\Links",
    "${env:LOCALAPPDATA}\Programs\WinMerge"
  )

  $userPath = [Environment]::GetEnvironmentVariable("PATH", "User")
  $currentPaths = $userPath -split ";" | Where-Object { $_ -ne "" }

  # Filter out targetPaths from current paths to avoid duplicates when re-adding
  $remainingPaths = $currentPaths | Where-Object { $targetPaths -notcontains $_ }

  # Construct new path list: targetPaths (ordered) + remaining paths
  $newPathList = $targetPaths + $remainingPaths
  $updatedPath = $newPathList -join ";"

  if ($userPath -ne $updatedPath) {
    [Environment]::SetEnvironmentVariable("PATH", $updatedPath, "User")
    log "Reordered/Updated USER PATH." "Green"
  } else {
    log "USER PATH is already up to date and correctly ordered." "Gray"
  }
}

function Set-CapsLockToCtrl {
  log "Checking CapsLock mapping..."
  $regPath = "HKLM\SYSTEM\CurrentControlSet\Control\Keyboard Layout"
  $regValueName = "Scancode Map"
  $expectedData = ([byte[]](0,0,0,0,0,0,0,0,2,0,0,0,0x1d,0,0x3a,0,0,0,0,0))

  $current = Get-ItemProperty -Path "Registry::$regPath" -Name $regValueName -ErrorAction SilentlyContinue
  if ($current -and ($null -ne $current."$regValueName") -and ([BitConverter]::ToString($current."$regValueName") -eq [BitConverter]::ToString($expectedData))) {
    log "CapsLock is already mapped to Ctrl." "Gray"
    return
  }

  log "Setting Scancode Map to change CapsLock to Ctrl..." "Yellow"
  $regValueData = "0000000000000000020000001d003a0000000000"
  try {
    $command = "reg add `"$regPath`" /v `"$regValueName`" /t REG_BINARY /d $regValueData /f"
    if (Test-IsAdmin) {
      cmd /c $command
    } elseif (Get-Command gsudo -ErrorAction SilentlyContinue) {
      gsudo cmd /c $command
    } else {
      Start-Process reg -ArgumentList "add `"$regPath`" /v `"$regValueName`" /t REG_BINARY /d $regValueData /f" -Verb RunAs
    }
    log "Successfully set Scancode Map. Please reboot to apply." "Yellow"
  } catch {
    log "Failed to set Scancode Map: $_" "Red"
  }
}

function Install-Neovim-Win {
  if (Get-Command nvim -ErrorAction SilentlyContinue) {
    log "Neovim is already installed. Skipping nightly download." "Gray"
    return
  }

  log "Installing Neovim Nightly..."
  $nvimMsi = Join-Path $env:TEMP "nvim-win64.msi"
  Invoke-WebRequest -Uri "https://github.com/neovim/neovim/releases/download/nightly/nvim-win64.msi" -OutFile $nvimMsi
  Start-Process msiexec.exe -ArgumentList "/i $nvimMsi /quiet" -Wait
  Remove-Item $nvimMsi
}

function Install-BuildTools {
  log "Installing Visual Studio Build Tools..." "Yellow"
  winget install Microsoft.VisualStudio.2022.BuildTools --override "--add Microsoft.VisualStudio.Workload.VCTools --includeRecommended --passive"
}

function Install-GoTools {
  if (!(Get-Command go -ErrorAction SilentlyContinue)) {
    log "Go is not installed. Skipping Go tools installation." "Yellow"
    return
  }

  log "Installing Go tools..."
  $goTools = @(
    "github.com/satococoa/wtp/v2/cmd/wtp@latest"
  )

  foreach ($tool in $goTools) {
    log "Installing $tool ..."
    go install $tool
  }
}

function Install-Mise {
  if (Get-Command mise -ErrorAction SilentlyContinue) {
    log "mise is already installed." "Gray"
    return
  }

  log "Installing mise..." "Yellow"
  Install-WingetPackages @("jdx.mise")
}

function Install-UserTools {
  # External Binary Tools (No admin required)
  $binTools = @(
    @{
      Name = "clnch"
      Url = "https://crftwr.github.io/clnch/download/clnch_340.zip"
      Dest = "${env:USERPROFILE}\app\clnch"
    },
    @{
      Name = "AlterDnD"
      Url = "https://dl.freesoft-100.com/p/AlterDnD_1.3.0.zip"
      Dest = "${env:USERPROFILE}\app\AlterDnD"
    }
  )

  foreach ($tool in $binTools) {
    Install-BinaryArchive -Name $tool.Name -Url $tool.Url -DestinationDir $tool.Dest
  }
}

function Install-Tools {
  $wingetPackages = @(
    "glzr-io.glazewm", "glzr-io.zebar", "Oven-sh.Bun",
    "BurntSushi.ripgrep.MSVC", "ImageMagick.ImageMagick", "alexpasmantier.television",
    "junegunn.fzf", "sharkdp.fd", "dandavison.delta", "gerardog.gsudo",
    "Slackadays.Clipboard", "Flameshot.Flameshot", "RustLang.Rustup",
    "Microsoft.WindowsTerminal", "Microsoft.PowerToys", "Git.Git",
    "GitHub.cli", "AutoHotkey.AutoHotkey", "Espanso.Espanso",
    "WinMerge.WinMerge", "Chocolatey.Chocolatey", "zig.zig", "GoLang.Go",
    "Microsoft.PowerShell", "Neovide.Neovide", "hluk.CopyQ", "Byron.dua-cli",
    "Obsidian.Obsidian"
  )
  Install-WingetPackages $wingetPackages
}

function Install-PlemolJP {
  log "Checking latest PlemolJP version..."
  $latestUrl = "https://api.github.com/repos/yuru7/PlemolJP/releases/latest"
  try {
    $json = Invoke-RestMethod -Uri $latestUrl
    $asset = $json.assets | Where-Object { $_.name -match "PlemolJP_NF_v.*\.zip" } | Select-Object -First 1

    if (!$asset) {
      log "Could not find PlemolJP NF asset." "Red"
      return
    }

    $version = $json.tag_name
    $fontsDir = Join-Path $env:LOCALAPPDATA "Microsoft\Windows\Fonts"
    if (!(Test-Path $fontsDir)) {
      New-Item -ItemType Directory -Path $fontsDir | Out-Null
    }

    # Check if already installed (simple check based on expected file existence, might not be perfect)
    # Checking for one main file like "PlemolJPConsoleNF-Regular.ttf" if we knew the content,
    # but since we don't know exact content, we proceed to download if we can't verify easily.
    # To avoid re-downloading every time, we can check a marker file or registry, but let's just proceed for now
    # or check if specific registry key exists.
    $regPath = "HKCU:\Software\Microsoft\Windows NT\CurrentVersion\Fonts"
    $checkName = "PlemolJP Console NF Regular (TrueType)" # Guessing name
    if (Get-ItemProperty -Path $regPath -Name $checkName -ErrorAction SilentlyContinue) {
      log "PlemolJP ($version) seems to be installed." "Gray"
      return
    }

    log "Installing PlemolJP $version ..." "Yellow"

    $zipName = $asset.name
    $downloadUrl = $asset.browser_download_url
    $tempZip = Join-Path $env:TEMP $zipName
    $tempExtract = Join-Path $env:TEMP "PlemolJP-extract"

    if (Test-Path $tempExtract) {
      Remove-Item $tempExtract -Recurse -Force
    }
    New-Item -ItemType Directory $tempExtract | Out-Null

    Invoke-WebRequest -Uri $downloadUrl -OutFile $tempZip -UseBasicParsing
    Expand-Archive -Path $tempZip -DestinationPath $tempExtract -Force

    $ttfFiles = Get-ChildItem -Path $tempExtract -Filter "*.ttf" -Recurse
    foreach ($ttf in $ttfFiles) {
      $destPath = Join-Path $fontsDir $ttf.Name
      if (!(Test-Path $destPath)) {
        Copy-Item $ttf.FullName $destPath -Force
      }

      # Register in Registry
      # Key name example: "PlemolJP Console NF Regular (TrueType)"
      # Value: Path to file
      $fontName = [System.IO.Path]::GetFileNameWithoutExtension($ttf.Name)
      # Improve readability of registry key
      $regName = "$fontName (TrueType)"
      Set-ItemProperty -Path $regPath -Name $regName -Value $destPath
    }

    log "PlemolJP installed successfully." "Green"

    # Cleanup
    Remove-Item $tempZip -Force
    Remove-Item $tempExtract -Recurse -Force

  } catch {
    log "Failed to install PlemolJP: $_" "Red"
  }
}

function Start-Main {
  try {
    log "[Start-Main] Starting setup..."

    $isAdmin = Test-IsAdmin
    $canElevate = Test-IsAdminGroup

    if (-not $AdminOnly) {
      log "--- User Level Setup ---" "Cyan"
      Set-RequiredEnv
      Install-PlemolJP
      Install-GoTools
      Install-Mise
      Install-UserTools

      # Create Shortcuts (User level)
      $shortcuts = @(
        @{
          Link = "${env:APPDATA}\Microsoft\Windows\Start Menu\Programs\Startup\AutoHotkey.lnk"
          Target = "${env:USERPROFILE}\.local\share\chezmoi\win\AutoHotkey\AutoHotkey.ahk"
        },
        @{
          Link = "${env:APPDATA}\Microsoft\Windows\Start Menu\Programs\Startup\clnch.lnk"
          Target = "${env:USERPROFILE}\app\clnch\clnch.exe"
        },
        @{
          Link = "${env:APPDATA}\Microsoft\Windows\Start Menu\Programs\Startup\AlterDnD64.lnk"
          Target = "${env:USERPROFILE}\app\AlterDnD\AlterDnD64.exe"
        }
      )
      foreach ($s in $shortcuts) {
        New-Shortcut -link $s.Link -target $s.Target
      }
    }

    if ($isAdmin) {
      log "--- Admin Level Setup ---" "Green"
      Set-CapsLockToCtrl
      Install-BibataCursor
      # Install-BuildTools
      Install-Neovim-Win
      Install-Tools
    } elseif ($canElevate) {
      log "Not elevated, but you are in the Administrators group. Attempting to relaunch for Admin tasks..." "Yellow"
      try {
        Start-Process powershell -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`" -AdminOnly" -Verb RunAs -Wait
      } catch {
        log "Elevation failed or cancelled. Skipping Admin-only tasks." "Red"
      }
    } else {
      log "Running with User privileges only. Skipping Admin-only tasks." "Yellow"
    }

    log "[Start-Main] Setup process finished." "Green"
    exit 0
  } catch {
    log "Error in Start-Main: $_" "Red"
    exit 1
  }
}

if ($MyInvocation.InvocationName -ne '.') {
  Start-Main
}
