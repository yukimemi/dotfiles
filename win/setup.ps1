<#
  .SYNOPSIS
    setup.ps1
  .DESCRIPTION
    Initial windows setup scripts.
  .OUTPUTS
    - 0: SUCCESS / 1: ERROR
  .Last Change : 2025/12/30 15:10:46.
#>
$ErrorActionPreference = "Stop"
$DebugPreference = "SilentlyContinue"

# --- Helper Functions ---

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

      if (Get-Command gsudo -ErrorAction SilentlyContinue) {
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
    "${env:LOCALAPPDATA}\mise\shims",
    "${env:LOCALAPPDATA}\Programs\WinMerge"
  )

  $userPath = [Environment]::GetEnvironmentVariable("PATH", "User")
  $currentPaths = $userPath -split ";" | Where-Object { $_ -ne "" }
  $newPaths = @()

  foreach ($p in $targetPaths) {
    if ($currentPaths -notcontains $p) {
      $newPaths += $p
    }
  }

  if ($newPaths.Count -gt 0) {
    $updatedPath = ($newPaths + $currentPaths) -join ";"
    [Environment]::SetEnvironmentVariable("PATH", $updatedPath, "User")
    log "Added new paths to USER PATH: $($newPaths -join ', ')" "Green"
  } else {
    log "USER PATH is already up to date." "Gray"
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
    if (Get-Command gsudo -ErrorAction SilentlyContinue) {
      gsudo cmd /c $command
    } else {
      Start-Process reg -ArgumentList "add `"$regPath`" /v `"$regValueName`" /t REG_BINARY /d $regValueData /f" -Verb RunAs
    }
    log "Successfully set Scancode Map. Please reboot to apply." "Yellow"
  } catch {
    log "Failed to set Scancode Map: $_" "Red"
  }
}

function Install-Neovim {
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

function Install-Tools {
  $wingetPackages = @(
    "glzr-io.glazewm", "glzr-io.zebar", "Oven-sh.Bun",
    "BurntSushi.ripgrep.MSVC", "ImageMagick.ImageMagick", "alexpasmantier.television",
    "junegunn.fzf", "sharkdp.fd", "dandavison.delta", "gerardog.gsudo",
    "Slackadays.Clipboard", "Flameshot.Flameshot", "RustLang.Rustup",
    "Microsoft.WindowsTerminal", "Microsoft.PowerToys", "Git.Git",
    "GitHub.cli", "AutoHotkey.AutoHotkey", "Espanso.Espanso",
    "WinMerge.WinMerge", "Chocolatey.Chocolatey", "zig.zig",
    "Microsoft.PowerShell", "Neovide.Neovide", "hluk.CopyQ", "Byron.dua-cli"
  )
  Install-WingetPackages $wingetPackages

  # External Binary Tools
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

  Install-BibataCursor
}

function Start-Main {
  try {
    log "[Start-Main] Starting setup..."

    Set-RequiredEnv
    Set-CapsLockToCtrl
    Install-Neovim
    Install-Tools

    # Shortcuts
    $shortcuts = @(
      @{
        Link = "${env:APPDATA}\Microsoft\Windows\Start Menu\Programs\Startup\AutoHotkey.lnk"
        Target = "${env:USERPROFILE}\.dotfiles\win\AutoHotkey\AutoHotkey.ahk"
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

    log "[Start-Main] Setup completed successfully!" "Green"
    exit 0
  } catch {
    log "Error in Start-Main: $_" "Red"
    exit 1
  }
}

Start-Main
