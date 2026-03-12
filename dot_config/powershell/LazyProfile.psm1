# =============================================================================
# File        : lazy_profile.ps1
# Description : Functions, Aliases, PSReadLine (Optimized)
# Last Change : 2026/03/13 03:00:00.
# =============================================================================

# --- Functions ---
function log {
  param([string]$msg, [string]$color = "Cyan")
  $now = Get-Date -f "yyyy/MM/dd HH:mm:ss.fff"
  Write-Host -ForegroundColor $color "${now} ${msg}"
}

function gr {
  Set-LocationWithList $(git rev-parse --show-toplevel)
}

function Invoke-GitIgnoreGet {
  [CmdletBinding(SupportsShouldProcess)]
  param([Parameter(Mandatory = $true)][string[]]$list)
  $params = ($list | ForEach-Object { [uri]::EscapeDataString($_) }) -join ","
  if ($PSCmdlet.ShouldProcess(".gitignore", "Fetch and write gitignore from toptal.com")) {
    Invoke-WebRequest -Uri "https://www.toptal.com/developers/gitignore/api/$params" |
      Select-Object -ExpandProperty content |
      Out-File -FilePath (Join-Path $pwd ".gitignore") -Encoding ascii
  }
}

function Set-LocationWithList {
  [CmdletBinding(SupportsShouldProcess)]
  param([Parameter(ValueFromPipeline = $true)][string]$path)
  if ($PSCmdlet.ShouldProcess($path, "Set-Location and Get-ChildItem")) {
    Set-Location $path -ErrorAction Stop; Get-ChildItem
  }
}

function Set-LocationWithHistory {
  [CmdletBinding(SupportsShouldProcess)]
  param([Parameter(ValueFromPipeline = $true)][string]$path)
  if ($PSCmdlet.ShouldProcess($path, "Set-Location, Get-ChildItem and Add to history")) {
    Set-Location $path -ErrorAction Stop; Get-ChildItem
    Start-Job {
      param([string]$path)
      $z = if ($IsWindows) {
        Join-Path $env:USERPROFILE ".cdhistory"
      } else {
        Join-Path $env:HOME ".cdhistory"
      }
      $path | Add-Content -Encoding utf8 $z
      $c = Get-Content -Encoding utf8 $z | Where-Object { ![string]::IsNullOrEmpty($_) }
      [array]::Reverse($c); $c = $c | Select-Object -Unique; [array]::Reverse($c)
      $c | Set-Content -Encoding utf8 $z
    } -ArgumentList $path > $null
  }
}

function Invoke-ZJump {
  zoxide query --list @args | __FILTER | Select-Object -First 1 | Invoke-TrimSetLocation
}

function Invoke-HistoryJump {
  $z = if ($IsWindows) {
    Join-Path $env:USERPROFILE ".cdhistory"
  } else {
    Join-Path $env:HOME ".cdhistory"
  }
  if (Test-Path $z) {
    $c = Get-Content $z; [array]::Reverse($c)
    $c | __FILTER | Select-Object -First 1 | Invoke-TrimSetLocation
  } else {
    Get-Job | Stop-Job -PassThru | Remove-Job -Force
  }
}

function Move-ToTrash {
  [CmdletBinding(SupportsShouldProcess = $true, DefaultParameterSetName = 'Path')]
  param (
    [SupportsWildCards()][Parameter(Mandatory = $true, Position = 0, ParameterSetName = 'Path', ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)][string[]]$Path,
    [Alias('LP', 'PSPath')][Parameter(Mandatory = $true, Position = 0, ParameterSetName = 'LiteralPath', ValueFromPipeline = $false, ValueFromPipelineByPropertyName = $true)][string[]]$LiteralPath
  )
  begin {
    if ($IsWindows) {
      $shell = New-Object -ComObject Shell.Application; $trash = $shell.NameSpace(10)
    }
  }
  process {
    $targets = if ($PSBoundParameters.ContainsKey('Path')) {
      if ($IsWindows) {
        Convert-Path ($Path.Trim() -replace '^[^A-Z]+', "")
      } else {
        Convert-Path $Path
      }
    } else {
      Convert-Path -LiteralPath $LiteralPath
    }
    foreach ($target in $targets) {
      if ($PSCmdlet.ShouldProcess($target)) {
        if ($IsWindows) {
          $trash.MoveHere($target)
        } elseif (Get-Command gio -ErrorAction SilentlyContinue) {
          gio trash $target
        } elseif (Get-Command trash -ErrorAction SilentlyContinue) {
          trash $target
        } elseif (Get-Command trash-put -ErrorAction SilentlyContinue) {
          trash-put $target
        } else {
          Remove-Item -Recurse -Force $target
        }
      }
    }
  }
}

function Remove-Fzf {
  [CmdletBinding(SupportsShouldProcess)]
  param()
  $target = Get-ChildItem -Force | Select-Object -ExpandProperty FullName | __FILTER | Select-Object -First 1
  if (!$target) {
    return
  }
  if ($PSCmdlet.ShouldProcess($target, "Move to trash")) {
    $target | Move-ToTrash
  }
}

function Invoke-TrimSetLocation {
  param([Parameter(ValueFromPipeline = $true)][string]$Path)
  process {
    $p = if ($IsWindows) {
      $Path.Trim() -replace '^[^A-Z]+', ""
    } else {
      $Path.Trim()
    }
    Write-Host "cd [$p]"; Set-LocationWithList $p
  }
}

function fe {
  nvim $(fd -H -t f | __FILTER | Select-Object -First 1)
}
function VimDeinUpdate {
  [CmdletBinding(SupportsShouldProcess)]
  param()
  if ($PSCmdlet.ShouldProcess("Vim", "Update dein plugins")) {
    vim -c "silent! call dein#update() | q"
  }
}

function Install-Pip {
  [CmdletBinding(SupportsShouldProcess)]
  param()
  if ($PSCmdlet.ShouldProcess("Pip", "Install pip")) {
    [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.SecurityProtocolType]::Tls12
    Invoke-WebRequest -Uri "https://bootstrap.pypa.io/get-pip.py" -OutFile get-pip.py
    python ./get-pip.py; Remove-Item ./get-pip.py
  }
}

function Install-Aider {
  [CmdletBinding(SupportsShouldProcess)]
  param()
  if ($PSCmdlet.ShouldProcess("Aider", "Install aider")) {
    & ([scriptblock]::Create((Invoke-RestMethod -Uri https://aider.chat/install.ps1)))
  }
}

function Install-Gut {
  [CmdletBinding(SupportsShouldProcess)]
  param()
  if ($PSCmdlet.ShouldProcess("gut-cli", "Install gut-cli via bun")) {
    if (Get-Command bun -ErrorAction SilentlyContinue) {
      Write-Host "Installing gut-cli via bun..."
      bun install -g gut-cli
    } else {
      Write-Error "bun is not installed. Please install bun first."
    }
  }
}

function Install-PsmuxPpm {
  [CmdletBinding(SupportsShouldProcess)]
  param()
  $ppmPath = Join-Path $env:USERPROFILE ".psmux/plugins/ppm"
  if (!(Test-Path $ppmPath)) {
    if ($PSCmdlet.ShouldProcess($ppmPath, "Install psmux plugin manager (ppm)")) {
      Write-Host "Installing psmux plugin manager (ppm)..."
      $tempDir = Join-Path $env:TEMP "psmux-plugins"
      if (Test-Path $tempDir) {
        Remove-Item $tempDir -Recurse -Force
      }
      git clone https://github.com/marlocarlo/psmux-plugins.git $tempDir
      if (!(Test-Path (Split-Path $ppmPath -Parent))) {
        New-Item -ItemType Directory (Split-Path $ppmPath -Parent) -Force | Out-Null
      }
      Copy-Item (Join-Path $tempDir "ppm") $ppmPath -Recurse -Force
      Remove-Item $tempDir -Recurse -Force
      Write-Host "Successfully installed ppm. Please run 'Prefix + I' in psmux to install plugins."
    }
  }
}

function Install-Neovim {
  [CmdletBinding(SupportsShouldProcess)]
  param()
  if ($IsWindows) {
    if ($PSCmdlet.ShouldProcess("Neovim", "Install Neovim Nightly (Windows)")) {
      Write-Host "Installing Neovim Nightly (Windows)..."
      $nvimMsi = Join-Path $env:TEMP "nvim-win64.msi"
      Invoke-WebRequest -Uri "https://github.com/neovim/neovim/releases/download/nightly/nvim-win64.msi" -OutFile $nvimMsi
      Start-Process msiexec.exe -ArgumentList "/i `"$nvimMsi`" /quiet" -Wait
      Remove-Item $nvimMsi -ErrorAction SilentlyContinue
    }
  } elseif ($IsMacOS) {
    if ($PSCmdlet.ShouldProcess("Neovim", "Build and install Neovim (MacOS)")) {
      Write-Host "Building Neovim (MacOS)..."
      bash -c "brew install ninja cmake gettext curl; rm -rf /tmp/neovim; git clone https://github.com/neovim/neovim /tmp/neovim; cd /tmp/neovim; make CMAKE_BUILD_TYPE=RelWithDebInfo; sudo make install"
    }
  } elseif ($IsLinux) {
    if ($PSCmdlet.ShouldProcess("Neovim", "Build and install Neovim (Linux)")) {
      Write-Host "Building Neovim (Linux)..."
      bash -c "sudo apt install -y ninja-build gettext cmake unzip curl; rm -rf /tmp/neovim; git clone https://github.com/neovim/neovim /tmp/neovim; cd /tmp/neovim; make CMAKE_BUILD_TYPE=RelWithDebInfo; sudo make install"
    }
  } else {
    Write-Error "Unknown Operating System."
  }
}

function Invoke-PSFmt {
  [CmdletBinding(SupportsShouldProcess)]
  param(
    [Parameter(ValueFromPipeline = $true)]
    [string[]]$Path = @(".")
  )
  process {
    if (!(Get-Module -ListAvailable PSScriptAnalyzer)) {
      log "PSScriptAnalyzer is required. Installing..." "Yellow"
      Install-Module -Name PSScriptAnalyzer -Scope CurrentUser -Force
    }

    $fmtSettings = @{
      IncludeRules = @(
        "PSPlaceOpenBrace",
        "PSPlaceCloseBrace",
        "PSUseConsistentIndentation",
        "PSUseCorrectCasing"
      )
      Rules = @{
        PSPlaceOpenBrace = @{
          Enable = $true
          OnSameLine = $true
          NewLineAfter = $true
          IgnoreOneLineBlock = $true
        }
        PSPlaceCloseBrace = @{
          Enable = $true
          NewLineAfter = $false
          IgnoreOneLineBlock = $true
          NoEmptyLineBefore = $false
        }
        PSUseConsistentIndentation = @{
          Enable = $true
          IndentationSize = 2
        }
        PSUseCorrectCasing = @{ Enable = $true }
      }
    }

    foreach ($p in $Path) {
      $files = if (Test-Path $p -PathType Leaf) { @(Get-Item $p) } else { Get-ChildItem -Path $p -Include "*.ps1", "*.psm1" -Recurse }
      foreach ($file in $files) {
        log "Formatting $($file.FullName) ..." "Cyan"
        $content = Get-Content $file.FullName -Raw
        if ([string]::IsNullOrWhiteSpace($content)) { continue }

        $formatted = Invoke-Formatter -ScriptDefinition $content -Settings $fmtSettings
        
        # Ensure exactly one newline at the end of the file (EditorConfig style)
        $formatted = $formatted.TrimEnd() + "`r`n"

        # Ensure no BOM and consistent content
        $utf8NoBom = New-Object System.Text.UTF8Encoding($false)
        if ($content -ne $formatted) {
          [System.IO.File]::WriteAllText($file.FullName, $formatted, $utf8NoBom)
          log "Updated $($file.Name)" "Green"
        } else {
          # Even if no formatting changes, re-save to strip BOM if it exists
          $bytes = [System.IO.File]::ReadAllBytes($file.FullName)
          if ($bytes.Count -ge 3 -and $bytes[0] -eq 0xEF -and $bytes[1] -eq 0xBB -and $bytes[2] -eq 0xBF) {
            [System.IO.File]::WriteAllText($file.FullName, $content, $utf8NoBom)
            log "Stripped BOM from $($file.Name)" "Yellow"
          } else {
            log "No changes for $($file.Name)" "Gray"
          }
        }
      }
    }
  }
}

function Invoke-PSLint {
  [CmdletBinding()]
  param(
    [Parameter(ValueFromPipeline = $true)]
    [string[]]$Path = @("."),
    [switch]$CI
  )
  process {
    if (!(Get-Module -ListAvailable PSScriptAnalyzer)) {
      Write-Host "PSScriptAnalyzer is required. Installing..." -ForegroundColor Yellow
      Install-Module -Name PSScriptAnalyzer -Scope CurrentUser -Force
    }
    $results = @()
    foreach ($p in $Path) {
      log "Linting $p ..." "Cyan"
      $results += Invoke-ScriptAnalyzer -Path $p -Recurse
    }

    if ($results) {
      $results | Format-Table -AutoSize
      if ($CI) {
        throw "PSScriptAnalyzer found issues."
      }
    } else {
      log "No issues found." "Green"
    }
  }
}

function Update-CargoTool {
  [CmdletBinding(SupportsShouldProcess)]
  param()
  if ($PSCmdlet.ShouldProcess("Cargo tools", "Update all cargo tools")) {
    Write-Host "Updating all cargo tools..." -ForegroundColor Cyan
    if (!(Get-Command cargo-install-update -ErrorAction SilentlyContinue)) {
      if (!(Get-Command cargo-binstall -ErrorAction SilentlyContinue)) {
        Write-Host "Installing cargo-binstall..." -ForegroundColor Yellow
        cargo +stable-x86_64-pc-windows-gnu install cargo-binstall
      }
      Write-Host "Installing cargo-update via cargo-binstall..." -ForegroundColor Yellow
      cargo binstall --no-confirm --target x86_64-pc-windows-gnu cargo-update
    }
    cargo install-update -a
  }
}

function y {
  $tmp = [System.IO.Path]::GetTempFileName()
  yazi $args --cwd-file="$tmp"
  if (Test-Path $tmp) {
    $cwd = Get-Content -Path $tmp
    if ($cwd -and $cwd -ne $PWD.Path) {
      Set-LocationWithList -LiteralPath $cwd
    }
    Remove-Item -Path $tmp
  }
}

function Update-WithMolt {
  [CmdletBinding(SupportsShouldProcess)]
  param([string]$path = $pwd)
  if ($PSCmdlet.ShouldProcess($path, "Update with molt")) {
    Get-ChildItem -Force -Recurse -File $path -Filter *.ts | ForEach-Object { molt -w $_.FullName }
  }
}

function Invoke-ZenoSnippet {
  if ($null -eq $global:ZenoSnippets) {
    $configPath = Join-Path $ConfigHome "zeno/config.yml"
    if (!(Test-Path $configPath)) {
      return
    }

    # YAML to JSON using Deno with JSR
    $uPath = $configPath.Replace("\", "/")
    $denoScript = "import { parse } from 'jsr:@std/yaml'; console.log(JSON.stringify(parse(Deno.readTextFileSync('$uPath'))))"
    $snippetsJson = $denoScript | deno run --allow-read - 2>$null

    if ($null -eq $snippetsJson -or $snippetsJson -eq "") {
      return
    }
    $global:ZenoSnippets = ($snippetsJson | ConvertFrom-Json).snippets
  }

  # Select snippet with fzf (__FILTER)
  $selected = $global:ZenoSnippets | ForEach-Object { "$($_.keyword)`t$($_.name)`t$($_.snippet)" } | fzf --header "Select Zeno Snippet" --tabstop 10
  if (!$selected) {
    return
  }

  $snippetText = ($selected -split "`t")[2]

  # Handle simple placeholders (e.g. {{commit_message}})
  while ($snippetText -match '\{\{(?<Param>[^}]+)\}\}') {
    $param = $Matches['Param']
    $val = Read-Host "Enter $param"
    if ($null -eq $val) {
      $val = ""
    }
    $snippetText = $snippetText -replace "\{\{$param\}\}", $val
  }

  [Microsoft.PowerShell.PSConsoleReadLine]::Insert($snippetText)
}


function Get-FileAndHash {
  Get-ChildItem | ForEach-Object { [PSCustomObject]@{ path = $_.Name; hash = (Get-FileHash -Algorithm MD5 $_.FullName).Hash } }
}

function Select-ChezmoiAdd {
  Invoke-ChezmoiFuzzy "add" -MultiSelect
}
function Select-ChezmoiDiff {
  Invoke-ChezmoiFuzzy "diff" -MultiSelect
}
function Select-ChezmoiMerge {
  Invoke-ChezmoiFuzzy "merge"
}

function Invoke-ChezmoiFuzzy {
  param(
    [Parameter(Mandatory = $true)][string]$Action,
    [switch]$MultiSelect
  )
  $userHomeLocal = if ($IsWindows) { $env:USERPROFILE } else { $env:HOME }
  $uHome = $userHomeLocal.Replace("\", "/")
  $filterArgs = if ($MultiSelect) {
    @("-m")
  } else {
    @()
  }
  $nullDev = if ($IsWindows) {
    "NUL"
  } else {
    "/dev/null"
  }

  $selected = chezmoi status |
    Out-String -Stream |
    Where-Object { $_ -match '^[ MAD?]' } |
    fzf $filterArgs --preview "chezmoi diff $uHome/{2..} 2>$nullDev || bat --color=always $uHome/{2..} 2>$nullDev || cat $uHome/{2..} 2>$nullDev || type $uHome/{2..}" --header "Select files to 'chezmoi $Action'" |
    ForEach-Object { $_.Substring(3).Trim() }

  if ($selected) {
    $selected | ForEach-Object { chezmoi $Action "$uHome/$_" }
  }
}

# --- Aliases ---
Remove-Item alias:r, alias:rm, alias:cd, alias:ls, alias:h, alias:z, alias:zi -ErrorAction SilentlyContinue

# Filter tool setup
if (Get-Command fzf -ErrorAction SilentlyContinue) {
  Set-Alias __FILTER fzf
} elseif (Get-Command tv -ErrorAction SilentlyContinue) {
  Set-Alias __FILTER tv
}

# --- PSReadLine & KeyHandlers ---
if (Get-Module -ListAvailable PSReadLine) {
  Set-PSReadLineOption -EditMode Vi -ViModeIndicator Cursor
  if ($PSVersionTable.PSVersion.Major -ge 7) {
    Set-PSReadLineOption -PredictionSource HistoryAndPlugin -PredictionViewStyle InlineView
  }

  $invokePrompt = { [Microsoft.PowerShell.PSConsoleReadLine]::InvokePrompt() }

  # --- Abbreviation Expansion (zeno.zsh style) ---
  $rmTarget = "Move-ToTrash"

  # Initial hardcoded abbrs (can be overridden by config.yml)
  $abbrs = @{
    "a"     = "git add"
    "b"     = "cd .."
    "c"     = "Clear-Host"
    "ca"    = "chezmoi apply -v"
    "cd"    = "Set-LocationWithList"
    "cdiff" = "Select-ChezmoiDiff"
    "ce"    = "chezmoi edit-config"
    "cm"    = "Select-ChezmoiMerge"
    "cs"    = "chezmoi status"
    "cup"   = "Update-CargoTool"
    "cza"   = "Select-ChezmoiAdd"
    "d"     = "jj diff"
    "e"     = "nvim"
    "g"     = "git"
    "gc"    = "gut commit"
    "ghl"   = "ghr list | __FILTER | Select-Object -First 1 | Invoke-TrimSetLocation"
    "gsl"   = "gsr `"${env:USERPROFILE}\src`" | __FILTER | Select-Object -First 1 | Invoke-TrimSetLocation"
    "gt"    = "gut"
    "h"     = "hitori"
    "j"     = "Invoke-ZJump"
    "jd"    = "Get-ChildItem -Force -Directory -Recurse | Select-Object -ExpandProperty FullName | __FILTER | Select-Object -First 1 | Invoke-TrimSetLocation"
    "jp"    = "jj done; jj git push"
    "ju"    = "jj pull; jj up"
    "l"     = "Get-ChildItem"
    "la"    = "Get-ChildItem -Force"
    "ls"    = "Get-ChildItem"
    "o"     = "Start-Process"
    "pm"    = "psmux"
    "r"     = "Remove-Fzf"
    "rhl"   = "rhq list | __FILTER | Select-Object -First 1 | Invoke-TrimSetLocation"
    "rm"    = $rmTarget
    "s"     = "jj status --no-pager"
    "v"     = "gvim --remote-silent"
    "which" = "Get-Command"
    "z"     = "Invoke-ZJump"
    "zi"    = "Invoke-ZJump"
  }

  # Load from config.yml
  $configHomeLocal = if ($env:XDG_CONFIG_HOME) {
    $env:XDG_CONFIG_HOME
  } else {
    Join-Path $(if ($IsWindows) { $env:USERPROFILE } else { $env:HOME }) ".config"
  }
  $configPath = Join-Path $configHomeLocal "zeno/config.yml"
  if ($configPath -and (Test-Path $configPath)) {
    if ($null -eq $global:ZenoSnippets) {
      $uPath = $configPath.Replace("\", "/")
      $denoScript = "import { parse } from 'jsr:@std/yaml'; console.log(JSON.stringify(parse(Deno.readTextFileSync('$uPath'))))"
      $snippetsJson = $denoScript | deno run --allow-read - 2>$null
      if ($null -ne $snippetsJson -and $snippetsJson -ne "") {
        $global:ZenoSnippets = ($snippetsJson | ConvertFrom-Json).snippets
      }
    }
    if ($null -ne $global:ZenoSnippets) {
      foreach ($s in $global:ZenoSnippets) {
        if ($s.keyword -and $s.snippet -and -not $s.snippet.Contains("{{")) {
          # Only add if not already defined in $abbrs (LazyProfile prioritizes local definitions)
          if (-not $abbrs.ContainsKey($s.keyword)) {
            $abbrs[$s.keyword] = $s.snippet
          }
        }
      }
    }
  }

  $expandAbbrLogic = {
    $line = $null
    $cursor = $null
    [Microsoft.PowerShell.PSConsoleReadLine]::GetBufferState([ref]$line, [ref]$cursor)

    if ($cursor -gt 0) {
      $sub = $line.Substring(0, $cursor)
      if ($sub -match '(?<Word>\S+)$') {
        $word = $Matches['Word']
        $preContext = $sub.Substring(0, $sub.Length - $word.Length)

        if ($abbrs.ContainsKey($word) -and ($preContext -match '^\s*$|[\;|]\s*$')) {
          [Microsoft.PowerShell.PSConsoleReadLine]::Delete($cursor - $word.Length, $word.Length)
          [Microsoft.PowerShell.PSConsoleReadLine]::Insert($abbrs[$word])
        }
      }
    }
  }

  Set-PSReadLineKeyHandler -Key Spacebar -ViMode Insert -ScriptBlock {
    . $expandAbbrLogic
    [Microsoft.PowerShell.PSConsoleReadLine]::Insert(' ')
  }.GetNewClosure()

  Set-PSReadLineKeyHandler -Key Enter -ViMode Insert -ScriptBlock {
    . $expandAbbrLogic
    [Microsoft.PowerShell.PSConsoleReadLine]::AcceptLine()
  }.GetNewClosure()

  Set-PSReadLineKeyHandler -Chord Escape -ViMode Insert -ScriptBlock {
    [Microsoft.PowerShell.PSConsoleReadLine]::ViCommandMode($null, $null)
    & $invokePrompt
  }

  Set-PSReadLineKeyHandler -Chord i -ViMode Command -ScriptBlock { [Microsoft.PowerShell.PSConsoleReadLine]::ViInsertMode($null, $null); & $invokePrompt }
  Set-PSReadLineKeyHandler -Chord a -ViMode Command -ScriptBlock { [Microsoft.PowerShell.PSConsoleReadLine]::ViInsertWithAppend($null, $null); & $invokePrompt }
  Set-PSReadLineKeyHandler -Chord I -ViMode Command -ScriptBlock { [Microsoft.PowerShell.PSConsoleReadLine]::ViInsertAtBegining($null, $null); & $invokePrompt }
  Set-PSReadLineKeyHandler -Chord A -ViMode Command -ScriptBlock { [Microsoft.PowerShell.PSConsoleReadLine]::ViInsertAtEnd($null, $null); & $invokePrompt }
  Set-PSReadLineKeyHandler -Chord o -ViMode Command -ScriptBlock { [Microsoft.PowerShell.PSConsoleReadLine]::InsertLineBelow($null, $null); [Microsoft.PowerShell.PSConsoleReadLine]::ViInsertMode($null, $null); & $invokePrompt }
  Set-PSReadLineKeyHandler -Chord O -ViMode Command -ScriptBlock { [Microsoft.PowerShell.PSConsoleReadLine]::InsertLineAbove($null, $null); [Microsoft.PowerShell.PSConsoleReadLine]::ViInsertMode($null, $null); & $invokePrompt }
  Set-PSReadLineKeyHandler -Chord s -ViMode Command -ScriptBlock { [Microsoft.PowerShell.PSConsoleReadLine]::ViInsertWithDelete($null, $null); & $invokePrompt }
  Set-PSReadLineKeyHandler -Chord S -ViMode Command -ScriptBlock { [Microsoft.PowerShell.PSConsoleReadLine]::ViReplaceLine($null, $null); & $invokePrompt }

  Set-PSReadLineKeyHandler -Chord "C" -ViMode Command -ScriptBlock {
    [Microsoft.PowerShell.PSConsoleReadLine]::KillLine($null, $null)
    [Microsoft.PowerShell.PSConsoleReadLine]::ViInsertMode($null, $null)
    & $invokePrompt
  }

  if ($env:NVIM) {
    Set-PSReadLineKeyHandler -Chord Escape -ViMode Command -ScriptBlock { & nvim --server $env:NVIM --remote-send "<C-\><C-n>" }
  }

  Set-PSReadLineKeyHandler -Chord Ctrl+Shift+G -ScriptBlock {
    $current = (Get-PSReadLineOption).PredictionViewStyle
    Set-PSReadLineOption -PredictionViewStyle $(if ($current -eq 'InlineView') { 'ListView' } else { 'InlineView' })
  }

  Set-PSReadLineKeyHandler -Chord Ctrl+s -ViMode Insert -ScriptBlock { Invoke-ZenoSnippet }.GetNewClosure()

  Set-PSReadLineKeyHandler -Chord Ctrl+f -Function AcceptNextSuggestionWord -ViMode Insert
  Set-PSReadLineKeyHandler -Chord Ctrl+e -Function AcceptSuggestion -ViMode Insert
  Set-PSReadLineKeyHandler -Chord Shift+Spacebar -Function PossibleCompletions -ViMode Insert

  # Emacs bindings
  Set-PSReadLineKeyHandler -Chord "Ctrl+a" -Function BeginningOfLine -ViMode Insert
  Set-PSReadLineKeyHandler -Chord "Ctrl+b" -Function BackwardChar -ViMode Insert
  Set-PSReadLineKeyHandler -Chord "Ctrl+d" -Function DeleteChar -ViMode Insert
  # Set-PSReadLineKeyHandler -Chord "Ctrl+h" -Function BackwardDeleteChar -ViMode Insert
  # Set-PSReadLineKeyHandler -Chord "Ctrl+l" -Function ClearScreen -ViMode Insert
  Set-PSReadLineKeyHandler -Chord "Ctrl+n" -Function HistorySearchForward -ViMode Insert
  Set-PSReadLineKeyHandler -Chord "Ctrl+p" -Function HistorySearchBackward -ViMode Insert
  Set-PSReadLineKeyHandler -Chord "Ctrl+u" -Function BackwardDeleteLine -ViMode Insert
  Set-PSReadLineKeyHandler -Chord "Ctrl+w" -Function BackwardDeleteWord -ViMode Insert

  # High-performance Psmux navigation (Direct background execution)
  $invokePsmux = {
    param([string]$direction)
    $si = [System.Diagnostics.ProcessStartInfo]@{
      FileName = "psmux.exe"
      Arguments = "select-pane $direction"
      CreateNoWindow = $true
      UseShellExecute = $false
    }
    [System.Diagnostics.Process]::Start($si) | Out-Null
  }

  $psmuxModes = @('Insert', 'Command')
  foreach ($mode in $psmuxModes) {
    Set-PSReadLineKeyHandler -Chord "Ctrl+h", "Ctrl+Backspace" -BriefDescription 'Psmux Left'  -ScriptBlock { & $invokePsmux "-L" } -ViMode $mode
    Set-PSReadLineKeyHandler -Chord "Ctrl+j", "Ctrl+Enter" -BriefDescription 'Psmux Down'  -ScriptBlock { & $invokePsmux "-D" } -ViMode $mode
    Set-PSReadLineKeyHandler -Chord "Ctrl+k" -BriefDescription 'Psmux Up'    -ScriptBlock { & $invokePsmux "-U" } -ViMode $mode
    Set-PSReadLineKeyHandler -Chord "Ctrl+l" -BriefDescription 'Psmux Right' -ScriptBlock { & $invokePsmux "-R" } -ViMode $mode
  }
}

if (!(Get-Command gut -ErrorAction SilentlyContinue)) {
  Install-Gut
}

if (Get-Command psmux -ErrorAction SilentlyContinue) {
  Install-PsmuxPpm
}

Export-ModuleMember -Function * -Alias *
