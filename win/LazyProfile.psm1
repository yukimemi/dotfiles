# =============================================================================
# File        : lazy_profile.ps1
# Description : Functions, Aliases, PSReadLine (Optimized)
# Last Change : 2026/01/04 11:11:00.
# =============================================================================

# --- Functions ---
function b {
  Set-Location ..
}
function g {
  git $args
}
function s {
  git status
}
function d {
  git diff $args
}
function a {
  git add $args
}
function gp {
  git pull --rebase
}
function gpu {
  git push
}
function gbr {
  git browse
}
function gr {
  Set-Location $(git rev-parse --show-toplevel)
}
function t {
  exit
}
function l {
  Get-ChildItem $args
}
function la {
  Get-ChildItem -Force $args
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
  $funcs = "function Test-IsWindows { ${Function:Test-IsWindows} }"
  Start-Job {
    param([string]$funcs, [string]$path)
    Invoke-Expression $funcs
    $z = if (Test-IsWindows) {
      Join-Path $env:USERPROFILE ".cdhistory"
    } else {
      Join-Path $env:HOME ".cdhistory"
    }
    $path | Add-Content -Encoding utf8 $z
    $c = Get-Content -Encoding utf8 $z | Where-Object { ![string]::IsNullOrEmpty($_) }
    [array]::Reverse($c); $c = $c | Select-Object -Unique; [array]::Reverse($c)
    $c | Set-Content -Encoding utf8 $z
  } -ArgumentList $funcs, (Get-Location).Path > $null
}

function Invoke-ZJump {
  zoxide query --list @args | __FILTER | Select-Object -First 1 | Invoke-TrimSetLocation
}

function Invoke-HistoryJump {
  $z = if (Test-IsWindows) {
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

function j {
  Invoke-ZJump @args
}
function rhl {
  rhq list | __FILTER | Select-Object -First 1 | Invoke-TrimSetLocation
}
function ghl {
  ghr list | __FILTER | Select-Object -First 1 | Invoke-TrimSetLocation
}
function gsl {
  gsr "${env:USERPROFILE}\src" | __FILTER | Select-Object -First 1 | Invoke-TrimSetLocation
}
function jd {
  Get-ChildItem -Force -Directory -Recurse | Select-Object -ExpandProperty FullName | __FILTER | Select-Object -First 1 | Invoke-TrimSetLocation
}

function Move-ToTrash {
  [CmdletBinding(SupportsShouldProcess = $true, DefaultParameterSetName = 'Path')]
  param (
    [SupportsWildCards()][Parameter(Mandatory = $true, Position = 0, ParameterSetName = 'Path', ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)][string[]]$Path,
    [Alias('LP', 'PSPath')][Parameter(Mandatory = $true, Position = 0, ParameterSetName = 'LiteralPath', ValueFromPipeline = $false, ValueFromPipelineByPropertyName = $true)][string[]]$LiteralPath
  )
  begin {
    $shell = New-Object -ComObject Shell.Application; $trash = $shell.NameSpace(10)
  }
  process {
    $targets = if ($PSBoundParameters.ContainsKey('Path')) {
      Convert-Path ($Path.Trim() -replace '^[^A-Z]+', "")
    } else {
      Convert-Path -LiteralPath $LiteralPath
    }
    foreach ($target in $targets) {
      if ($PSCmdlet.ShouldProcess($target)) {
        $trash.MoveHere($target)
      }
    }
  }
}

function r {
  $target = Get-ChildItem -Force | Select-Object -ExpandProperty FullName | __FILTER | Select-Object -First 1
  if (!$target) {
    return
  }
  if (Get-Command trash -ErrorAction SilentlyContinue) {
    trash $target
  } else {
    $target | Move-ToTrash
  }
}

function Get-DriveInfo {
  Get-PSDrive -PSProvider FileSystem | Where-Object { $_.Used -and $_.Name -ne "Temp" } | Sort-Object Name
}
function Get-DriveInfoView {
  Get-DriveInfo | Format-Table -AutoSize
}

function Invoke-TrimSetLocation {
  param([Parameter(ValueFromPipeline = $true)][string]$Path)
  process {
    $p = $Path.Trim() -replace '^[^A-Z]+', ""; Write-Host "cd [$p]"; Set-Location $p
  }
}

function fe {
  nvim $(fd -H -t f | __FILTER | Select-Object -First 1)
}
function v {
  gvim --remote-silent $args
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

function Install-Neovim {
  $nvimMsi = Join-Path $env:TEMP "nvim-win64.msi"
  Invoke-WebRequest -Uri "https://github.com/neovim/neovim/releases/download/nightly/nvim-win64.msi" -OutFile $nvimMsi
  Start-Process msiexec.exe -ArgumentList "/i `"$nvimMsi`"" -Wait
}

function y {
  $tmp = [System.IO.Path]::GetTempFileName()
  yazi $args --cwd-file="$tmp"
  if (Test-Path $tmp) {
    $cwd = Get-Content -Path $tmp
    if ($cwd -and $cwd -ne $PWD.Path) {
      Set-Location -LiteralPath $cwd
    }
    Remove-Item -Path $tmp
  }
}

function Update-WithMolt {
  param([string]$path = $pwd); Get-ChildItem -Force -Recurse -File $path -Filter *.ts | ForEach-Object { molt -w $_.FullName }
}
function Get-FileAndHash {
  Get-ChildItem | ForEach-Object { [PSCustomObject]@{ path = $_.Name; hash = (Get-FileHash -Algorithm MD5 $_.FullName).Hash } }
}

# --- Aliases ---
Remove-Item alias:r, alias:rm, alias:cd, alias:ls, alias:h, alias:z, alias:zi -ErrorAction SilentlyContinue
Set-Alias rm Move-ToTrash
Set-Alias o Start-Process
Set-Alias c Clear-Host
Set-Alias which Get-Command
Set-Alias df Get-DriveInfoView
Set-Alias cd Set-LocationWithList -Option AllScope
Set-Alias ls Get-ChildItem
Set-Alias h hitori
Set-Alias e nvim
Set-Alias z Invoke-ZJump -Option AllScope -Force
Set-Alias zi Invoke-ZJump -Option AllScope -Force

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
    Set-PSReadLineOption -PredictionViewStyle (if ($current -eq 'InlineView') { 'ListView' } else { 'InlineView' })
  }

  Set-PSReadLineKeyHandler -Chord Ctrl+f -Function AcceptNextSuggestionWord -ViMode Insert
  Set-PSReadLineKeyHandler -Chord Ctrl+e -Function AcceptSuggestion -ViMode Insert
  Set-PSReadLineKeyHandler -Chord Shift+Spacebar -Function PossibleCompletions -ViMode Insert

  # Emacs bindings
  Set-PSReadLineKeyHandler -Chord "Ctrl+a" -Function BeginningOfLine -ViMode Insert
  Set-PSReadLineKeyHandler -Chord "Ctrl+b" -Function BackwardChar -ViMode Insert
  Set-PSReadLineKeyHandler -Chord "Ctrl+d" -Function DeleteChar -ViMode Insert
  Set-PSReadLineKeyHandler -Chord "Ctrl+h" -Function BackwardDeleteChar -ViMode Insert
  Set-PSReadLineKeyHandler -Chord "Ctrl+l" -Function ClearScreen -ViMode Insert
  Set-PSReadLineKeyHandler -Chord "Ctrl+n" -Function HistorySearchForward -ViMode Insert
  Set-PSReadLineKeyHandler -Chord "Ctrl+p" -Function HistorySearchBackward -ViMode Insert
  Set-PSReadLineKeyHandler -Chord "Ctrl+u" -Function BackwardDeleteLine -ViMode Insert
  Set-PSReadLineKeyHandler -Chord "Ctrl+w" -Function BackwardDeleteWord -ViMode Insert
}

Export-ModuleMember -Function * -Alias *
