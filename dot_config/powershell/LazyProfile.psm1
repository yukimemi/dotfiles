# =============================================================================
# File        : lazy_profile.ps1
# Description : Functions, Aliases, PSReadLine (Optimized)
# Last Change : 2026/03/08 23:40:57.
# =============================================================================

# --- Functions ---
function gr {
  Set-LocationWithList $(git rev-parse --show-toplevel)
}

function Invoke-GitIgnoreGet {
  param([Parameter(Mandatory = $true)][string[]]$list)
  $params = ($list | ForEach-Object { [uri]::EscapeDataString($_) }) -join ","
  Invoke-WebRequest -Uri "https://www.toptal.com/developers/gitignore/api/$params" |
    Select-Object -ExpandProperty content |
    Out-File -FilePath (Join-Path $pwd ".gitignore") -Encoding ascii
}

function Set-LocationWithList {
  [CmdletBinding()] param([Parameter(ValueFromPipeline = $true)][string]$path)
  Set-Location $path -ErrorAction Stop; Get-ChildItem
}

function Set-LocationWithHistory {
  [CmdletBinding()] param([Parameter(ValueFromPipeline = $true)][string]$path)
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
  }
  Get-Job | Stop-Job -PassThru | Remove-Job -Force
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
  $target = Get-ChildItem -Force | Select-Object -ExpandProperty FullName | __FILTER | Select-Object -First 1
  if (!$target) {
    return
  }
  $target | Move-ToTrash
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
  vim -c "silent! call dein#update() | q"
}

function Install-Pip {
  [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.SecurityProtocolType]::Tls12
  Invoke-WebRequest -Uri "https://bootstrap.pypa.io/get-pip.py" -OutFile get-pip.py
  python ./get-pip.py; Remove-Item ./get-pip.py
}

function Install-Aider {
  Invoke-RestMethod -Uri https://aider.chat/install.ps1 | Invoke-Expression
}

function Install-Gut {
  if (Get-Command bun -ErrorAction SilentlyContinue) {
    Write-Host "Installing gut-cli via bun..."
    bun install -g gut-cli
  } else {
    Write-Error "bun is not installed. Please install bun first."
  }
}

function Install-PsmuxPpm {
  $ppmPath = Join-Path $env:USERPROFILE ".psmux/plugins/ppm"
  if (!(Test-Path $ppmPath)) {
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

function Install-Neovim {
  if ($IsWindows) {
    Write-Host "Installing Neovim Nightly (Windows)..."
    $nvimMsi = Join-Path $env:TEMP "nvim-win64.msi"
    Invoke-WebRequest -Uri "https://github.com/neovim/neovim/releases/download/nightly/nvim-win64.msi" -OutFile $nvimMsi
    Start-Process msiexec.exe -ArgumentList "/i `"$nvimMsi`" /quiet" -Wait
    Remove-Item $nvimMsi -ErrorAction SilentlyContinue
  } elseif ($IsMacOS) {
    Write-Host "Building Neovim (MacOS)..."
    bash -c "brew install ninja cmake gettext curl; rm -rf /tmp/neovim; git clone https://github.com/neovim/neovim /tmp/neovim; cd /tmp/neovim; make CMAKE_BUILD_TYPE=RelWithDebInfo; sudo make install"
  } elseif ($IsLinux) {
    Write-Host "Building Neovim (Linux)..."
    bash -c "sudo apt install -y ninja-build gettext cmake unzip curl; rm -rf /tmp/neovim; git clone https://github.com/neovim/neovim /tmp/neovim; cd /tmp/neovim; make CMAKE_BUILD_TYPE=RelWithDebInfo; sudo make install"
  } else {
    Write-Error "Unknown Operating System."
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
  param([string]$path = $pwd); Get-ChildItem -Force -Recurse -File $path -Filter *.ts | ForEach-Object { molt -w $_.FullName }
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
  $selected = $global:ZenoSnippets | ForEach-Object { "$($_.keyword)`t$($_.name)`t$($_.snippet)" } | __FILTER --header "Select Zeno Snippet" --tabstop 10
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
    __FILTER $filterArgs --preview "chezmoi diff $uHome/{2..} 2>$nullDev || bat --color=always $uHome/{2..} 2>$nullDev || cat $uHome/{2..} 2>$nullDev || type $uHome/{2..}" --header "Select files to 'chezmoi $Action'" |
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
