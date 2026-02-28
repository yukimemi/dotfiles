<#
  .SYNOPSIS
    setup.ps1
  .DESCRIPTION
    Initial windows setup scripts.
  .PARAMETER AdminOnly
    Internal use only. Skips user-level tasks and only runs admin tasks.
  .OUTPUTS
    - 0: SUCCESS / 1: ERROR
  .Last Change : 2026/03/01 16:12:36.
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
      log "Shortcut already exists: $link" "Gray"
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
    robocopy /e /r:1 /w:1 $subDirs[0].FullName $DestinationDir | Out-Null
  } else {
    robocopy /e /r:1 /w:1 $tempExtract $DestinationDir | Out-Null
  }

  # Cleanup
  Remove-Item $tempZip, $tempExtract -Recurse -Force
  log "Successfully installed $Name to $DestinationDir" "Green"
}

function Install-WingetPackages {
  param([string[]]$Packages)
  foreach ($pkg in $Packages) {
    log "Checking $pkg via winget..." "Cyan"
    & winget list --id $pkg --exact --accept-source-agreements >$null 2>&1
    if ($LASTEXITCODE -ne 0) {
      log "Installing $pkg via winget..." "Yellow"
      & winget install --id $pkg --exact --silent --accept-source-agreements --accept-package-agreements --no-upgrade 2>$null
    } else {
      log "$pkg is already installed via winget." "Gray"
    }
  }
}

function Install-BibataCursor {
  param (
    [string]$Version = "v2.0.7",
    [string]$Variant = "Bibata-Modern-Ice",
    [string]$Size = "Regular"
  )

  # Check if probably already installed (by folder name in C:\Windows\Cursors)
  if (Test-Path "C:\Windows\Cursors\$Variant-$Size") {
    log "$Variant cursor is already installed." "Gray"
    return
  }

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
      [User32.WinAPI]::SystemParametersInfo(0x0057, 0, 0, 0x03) | Out-Null

      log "$Variant ($Size) installed and applied successfully." "Green"
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
  log "Checking environment variables..." "Cyan"
  $envVars = @{
    "CARGO_NET_GIT_FETCH_WITH_CLI" = "true"
    "CARGO_HTTP_CHECK_REVOKE"      = "false"
    "YAZI_CONFIG_HOME"             = "${env:USERPROFILE}\.config\yazi"
    "YAZI_FILE_ONE"                = "${env:USERPROFILE}\scoop\apps\git\current\usr\bin\file.exe"
    "XDG_CONFIG_HOME"              = "${env:USERPROFILE}\.config"
    "PNPM_HOME"                    = "${env:LOCALAPPDATA}\pnpm"
  }
  foreach ($key in $envVars.Keys) {
    $current = [Environment]::GetEnvironmentVariable($key, "User")
    if ($current -ne $envVars[$key]) {
      [Environment]::SetEnvironmentVariable($key, $envVars[$key], "User")
      Set-Item -Path "env:$key" -Value $envVars[$key]
      log "Set $key = $($envVars[$key])" "Green"
    } else {
      # Ensure current process also has the variable
      if ((Get-Item -Path "env:$key" -ErrorAction SilentlyContinue).Value -ne $envVars[$key]) {
        Set-Item -Path "env:$key" -Value $envVars[$key]
      }
      log "$key is already set." "Gray"
    }
  }

  $targetPaths = @(
    "${env:USERPROFILE}\scoop\shims",
    "${env:USERPROFILE}\.cargo\bin",
    "${env:USERPROFILE}\.deno\bin",
    "${env:USERPROFILE}\.bun\bin",
    "${env:USERPROFILE}\go\bin",
    "${env:LOCALAPPDATA}\pnpm",
    "${env:LOCALAPPDATA}\Microsoft\WindowsApps",
    "${env:APPDATA}\npm",
    "${env:LOCALAPPDATA}\Microsoft\WinGet\Links",
    "${env:LOCALAPPDATA}\Programs\WinMerge",
    "${env:USERPROFILE}\.local\share\chezmoi\win\scripts",
    "${env:USERPROFILE}\src\github.com\yukimemi\ps1\cmd"
  )

  $userPath = [Environment]::GetEnvironmentVariable("PATH", "User")
  $currentPaths = $userPath -split ";" | Where-Object { $_ -ne "" }
  $remainingPaths = $currentPaths | Where-Object { $targetPaths -notcontains $_ }
  $newPathList = $targetPaths + $remainingPaths
  $updatedPath = $newPathList -join ";"

  if ($userPath -ne $updatedPath) {
    [Environment]::SetEnvironmentVariable("PATH", $updatedPath, "User")
    log "Updated USER PATH." "Green"
  } else {
    log "USER PATH is already up to date." "Gray"
  }
}

function Set-CapsLockToCtrl {
  log "Checking CapsLock mapping..." "Cyan"
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
  log "Checking Neovim..." "Cyan"
  if (Get-Command nvim -ErrorAction SilentlyContinue) {
    log "Neovim is already installed." "Gray"
    return
  }

  log "Installing Neovim Nightly via scoop..." "Yellow"
  Install-ScoopPackages @("neovim-nightly")
}

function Install-BuildTools {
  log "Checking Visual Studio Build Tools..." "Cyan"
  if (Test-Path "${env:ProgramFiles(x86)}\Microsoft Visual Studio\Installer\vswhere.exe") {
    $vs = & "${env:ProgramFiles(x86)}\Microsoft Visual Studio\Installer\vswhere.exe" -latest -products * -requires Microsoft.VisualStudio.Workload.VCTools
    if ($vs) {
      log "Visual Studio Build Tools already installed." "Gray"
      return
    }
  }
  log "Installing Visual Studio Build Tools..." "Yellow"
  winget install Microsoft.VisualStudio.2022.BuildTools --override "--add Microsoft.VisualStudio.Workload.VCTools --includeRecommended --passive"
}

function Install-GoTools {
  log "Checking Go tools..." "Cyan"
  if (!(Get-Command go -ErrorAction SilentlyContinue)) {
    log "Go is not installed." "Gray"
    return
  }

  $goTools = @(
    "github.com/satococoa/wtp/v2/cmd/wtp@latest"
  )

  foreach ($tool in $goTools) {
    $binName = ($tool -split "/")[-1].Split("@")[0]
    if (!(Get-Command $binName -ErrorAction SilentlyContinue)) {
      log "Installing $tool ..." "Yellow"
      go install $tool
    } else {
      log "$tool is already installed." "Gray"
    }
  }
}

function Install-Mise {
  log "Checking mise..." "Cyan"
  if (Get-Command mise -ErrorAction SilentlyContinue) {
    log "mise is already installed." "Gray"
    return
  }

  log "Installing mise via scoop..." "Yellow"
  Install-ScoopPackages @("mise")
}

function Install-UserTools {
  log "Checking user binary tools..." "Cyan"
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
  Install-Scoop

  $scoopPackages = @(
    "7zip",
    "autohotkey",
    "bat",
    "bun",
    "copyq",
    "delta",
    "dua",
    "espanso",
    "fd",
    "ffmpeg",
    "file",
    "fzf",
    "gh",
    "git",
    "glazewm",
    "go",
    "gsudo",
    "imagemagick",
    "jq",
    "ksnip",
    "less",
    "mingw",
    "mise",
    "neovide",
    "neovim",
    "neovim-qt",
    "obsidian",
    "pnpm",
    "powertoys",
    "pwsh",
    "ripgrep",
    "rustup-msvc",
    "starship",
    "topgrade",
    "windows-terminal",
    "winmerge",
    "yazi",
    "zebar",
    "zig"
  )

  log "Ensuring tools via scoop..." "Cyan"
  Install-ScoopPackages $scoopPackages

  $wingetPackages = @(
    "alexpasmantier.television",
    "Slackadays.Clipboard"
  )
  log "Ensuring remaining tools via winget..." "Cyan"
  Install-WingetPackages $wingetPackages
}

function Install-Scoop {
  $scoopRoot = Join-Path $env:USERPROFILE "scoop"
  $scoopBin = Join-Path $scoopRoot "apps\scoop\current\bin\scoop.ps1"

  if (Test-Path $scoopBin) {
    log "Scoop is already installed." "Gray"
    return
  }

  log "Installing scoop via git clone..." "Yellow"
  try {
    $scoopRepo = "https://github.com/ScoopInstaller/Scoop"
    $scoopDest = Join-Path $scoopRoot "apps\scoop\current"
    if (!(Test-Path $scoopDest)) {
      git clone $scoopRepo $scoopDest
    }

    New-Item -ItemType Directory -Path (Join-Path $scoopRoot "shims"), (Join-Path $scoopRoot "buckets") -Force | Out-Null

    $scoopShimPath = Join-Path $scoopRoot "shims"
    if ($env:PATH -notmatch [regex]::Escape($scoopShimPath)) {
      $env:PATH = "$scoopShimPath;$env:PATH"
    }

    powershell.exe -NoProfile -ExecutionPolicy Bypass -File $scoopBin "bucket", "add", "main"
  } catch {
    log "Failed to install scoop: $_" "Red"
  }
}

function Install-ScoopPackages {
  param([string[]]$Packages)

  $scoopRoot = Join-Path $env:USERPROFILE "scoop"
  $scoopBin = Join-Path $scoopRoot "apps\scoop\current\bin\scoop.ps1"

  if (!(Test-Path $scoopBin)) {
    log "Scoop bin not found!" "Red"
    return
  }

  function Invoke-Scoop {
    param([string[]]$ScoopArgs)
    $argStr = $ScoopArgs -join ' '
    # Use pwsh.exe (PowerShell 7) if available, as it is more robust than powershell.exe
    if (Get-Command pwsh -ErrorAction SilentlyContinue) {
      pwsh.exe -NoProfile -ExecutionPolicy Bypass -Command "& '$scoopBin' $argStr"
    } else {
      powershell.exe -NoProfile -ExecutionPolicy Bypass -Command "& '$scoopBin' $argStr"
    }
  }

  $buckets = Invoke-Scoop "bucket", "list"
  $requiredBuckets = @("main", "extras", "versions", "nerd-fonts")
  foreach ($bucket in $requiredBuckets) {
    if (!($buckets -match "\b$bucket\b")) {
      log "Adding $bucket bucket..." "Yellow"
      Invoke-Scoop "bucket", "add", $bucket
    } else {
      log "Bucket $bucket is already added." "Gray"
    }
  }

  foreach ($pkg in $Packages) {
    # Match the package directory specifically
    $pkgPath = Join-Path $scoopRoot "apps\$pkg"
    if (!(Test-Path $pkgPath)) {
      log "Installing $pkg via scoop..." "Yellow"
      Invoke-Scoop "install", $pkg
    } else {
      log "$pkg is already installed via scoop." "Gray"
    }
  }
}

function Install-PlemolJP {
  log "Checking PlemolJP-NF..." "Cyan"
  $regPath = "HKCU:\Software\Microsoft\Windows NT\CurrentVersion\Fonts"
  $checkName = "PlemolJP Console NF Regular (TrueType)"
  if (Get-ItemProperty -Path $regPath -Name $checkName -ErrorAction SilentlyContinue) {
    log "PlemolJP seems to be installed." "Gray"
    return
  }

  log "Checking latest PlemolJP version..." "Yellow"
  $latestUrl = "https://api.github.com/repos/yuru7/PlemolJP/releases/latest"
  try {
    $json = Invoke-RestMethod -Uri $latestUrl
    $asset = $json.assets | Where-Object { $_.name -match "PlemolJP_NF_v.*\.zip" } | Select-Object -First 1

    if (!$asset) {
      log "Could not find PlemolJP NF asset." "Red"
      return
    }

    $version = $json.tag_name
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

    $fontsDir = Join-Path $env:LOCALAPPDATA "Microsoft\Windows\Fonts"
    if (!(Test-Path $fontsDir)) {
      New-Item -ItemType Directory -Path $fontsDir | Out-Null
    }

    $ttfFiles = Get-ChildItem -Path $tempExtract -Filter "*.ttf" -Recurse
    foreach ($ttf in $ttfFiles) {
      $destPath = Join-Path $fontsDir $ttf.Name
      if (!(Test-Path $destPath)) {
        Copy-Item $ttf.FullName $destPath -Force
      }
      $fontName = [System.IO.Path]::GetFileNameWithoutExtension($ttf.Name)
      $regName = "$fontName (TrueType)"
      Set-ItemProperty -Path $regPath -Name $regName -Value $destPath
    }

    log "PlemolJP installed successfully." "Green"
    Remove-Item $tempZip, $tempExtract -Recurse -Force
  } catch {
    log "Failed to install PlemolJP: $_" "Red"
  }
}

function Install-PnpmConfig {
  log "Checking pnpm config..." "Cyan"
  if (!(Get-Command pnpm -ErrorAction SilentlyContinue)) {
    log "pnpm is not installed." "Gray"
    return
  }

  $pnpmHome = "${env:LOCALAPPDATA}\pnpm"
  $currentBinDir = pnpm config get global-bin-dir
  if ($currentBinDir -ne $pnpmHome) {
    log "Setting pnpm global-bin-dir to $pnpmHome ..." "Yellow"
    pnpm config set global-bin-dir "$pnpmHome"
  } else {
    log "pnpm global-bin-dir is already set to $pnpmHome." "Gray"
  }
}

function Install-Rhq {
  log "Checking rhq..." "Cyan"
  if (Get-Command rhq -ErrorAction SilentlyContinue) {
    log "rhq is already installed." "Gray"
    return
  }

  log "Installing rhq via cargo (GNU target)..." "Yellow"
  if (!(Get-Command g++ -ErrorAction SilentlyContinue)) {
    log "Installing mingw for rhq build..." "Yellow"
    Install-ScoopPackages @("mingw")
  }
  # Ensure mingw's bin is in PATH for current process
  $mingwBin = "${env:USERPROFILE}\scoop\apps\mingw\current\bin"
  if (Test-Path $mingwBin) {
    $env:PATH = "${mingwBin};${env:PATH}"
  }

  log "Adding GNU toolchain for rustup..." "Yellow"
  rustup toolchain install stable-x86_64-pc-windows-gnu

  log "Compiling rhq using GNU toolchain..." "Yellow"
  cargo +stable-x86_64-pc-windows-gnu install --git https://github.com/ubnt-intrepid/rhq.git
}

function Start-Main {
  try {
    log "[Start-Main] Starting setup..."

    $isAdmin = Test-IsAdmin
    $canElevate = Test-IsAdminGroup

    if (-not $AdminOnly) {
      log "--- User Level Setup ---" "Cyan"
      Set-RequiredEnv
      Install-Tools
      Install-PlemolJP
      Install-PnpmConfig
      Install-GoTools
      Install-UserTools
      Install-Rhq

      log "Checking shortcuts..." "Cyan"
      $shortcuts = @(
        @{
          Link = "${env:APPDATA}\Microsoft\Windows\Start Menu\Programs\Startup\AutoHotkey.lnk"
          Target = "${env:USERPROFILE}\.local\share\chezmoi\win\AutoHotkey\AutoHotkey.ahk"
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
