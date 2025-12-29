# =============================================================================
# File        : Microsoft.PowerShell_profile.ps1
# Author      : yukimemi
# Last Change : 2025/12/30 01:43:18.
# =============================================================================

# --- Environment Setup ---

$Host.UI.RawUI.WindowTitle = "yukimemi-terminal"
$ErrorActionPreference = "Stop"

function Test-IsWindows {
  ($PSVersionTable.PSVersion.Major -eq 5) -or ($PSVersionTable.Platform -eq "Win32NT")
}

if (Test-IsWindows) {
  $OutputEncoding = [System.Text.Encoding]::UTF8
  [Console]::InputEncoding = [System.Text.Encoding]::UTF8
  [Console]::OutputEncoding = [System.Text.Encoding]::UTF8
  chcp 65001 | Out-Null
  $env:LANG = "ja_JP.UTF-8"
  $env:EDITOR = "hitori"
}

# --- Package Managers & Tool Init ---

# cargo-binstall
if (!(Get-Command cargo-binstall -ErrorAction SilentlyContinue)) {
  cargo install cargo-binstall
}

# mise
if (Get-Command mise -ErrorAction SilentlyContinue) {
  mise activate pwsh | Out-String | Invoke-Expression
} else {
  cargo binstall mise
}

# rhq
if (!(Get-Command rhq -ErrorAction SilentlyContinue)) {
  cargo binstall --git https://github.com/ubnt-intrepid/rhq.git
}

# starship
if (Get-Command starship -ErrorAction SilentlyContinue) {
  Invoke-Expression (&starship init powershell)
  function Invoke-Starship-PreCommand {
    $mode = (Get-PSReadLineOption).ViMode
    $env:STARSHIP_VIM_MODE = if ($mode -eq "Command") {
      "normal"
    } else {
      "insert"
    }
  }
}

# zoxide
if (Get-Command zoxide -ErrorAction SilentlyContinue) {
  Invoke-Expression (&zoxide init powershell | Out-String)
}

# fnm
if (Get-Command fnm -ErrorAction SilentlyContinue) {
  fnm env --use-on-cd | Out-String | Invoke-Expression
}

# pkgx
if (!(Get-Command pkgx -ErrorAction SilentlyContinue)) {
  powershell -Command "irm https://pkgx.sh | iex"
}

# Chocolatey
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path $ChocolateyProfile) {
  Import-Module $ChocolateyProfile
}

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

function Invoke-GitIgnoreGet {
  param([Parameter(Mandatory = $true)][string[]]$list)
  $params = ($list | ForEach-Object { [uri]::EscapeDataString($_) }) -join ","
  Invoke-WebRequest -Uri "https://www.toptal.com/developers/gitignore/api/$params" |
    Select-Object -ExpandProperty content |
    Out-File -FilePath (Join-Path $pwd ".gitignore") -Encoding ascii
}

# Navigation & History
function Set-LocationWithList {
  [CmdletBinding()]
  param([Parameter(ValueFromPipeline = $true)][string]$path)
  Set-Location $path -ErrorAction Stop
  Get-ChildItem
}

function Set-LocationWithHistory {
  [CmdletBinding()]
  param([Parameter(ValueFromPipeline = $true)][string]$path)
  Set-Location $path -ErrorAction Stop
  Get-ChildItem
  # Save location in background
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
    [array]::Reverse($c)
    $c = $c | Select-Object -Unique
    [array]::Reverse($c)
    $c | Set-Content -Encoding utf8 $z
  } -ArgumentList $funcs, (Get-Location).Path > $null
}

function Invoke-ZJump {
  z | Sort-Object -Descending Weight | Select-Object -ExpandProperty Path | __FILTER | Select-Object -First 1 | Invoke-TrimSetLocation
}

function Invoke-HistoryJump {
  $z = if (Test-IsWindows) {
    Join-Path $env:USERPROFILE ".cdhistory"
  } else {
    Join-Path $env:HOME ".cdhistory"
  }
  if (Test-Path $z) {
    $c = Get-Content $z
    [array]::Reverse($c)
    $c | __FILTER | Select-Object -First 1 | Invoke-TrimSetLocation
  }
  Get-Job | Stop-Job -PassThru | Remove-Job -Force
}

function j {
  zi
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

function t {
  exit
}

# File Utils
function Move-ToTrash {
  [CmdletBinding(SupportsShouldProcess = $true, DefaultParameterSetName = 'Path')]
  param (
    [SupportsWildCards()]
    [Parameter(Mandatory = $true, Position = 0, ParameterSetName = 'Path', ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
    [string[]]$Path,
    [Alias('LP', 'PSPath')]
    [Parameter(Mandatory = $true, Position = 0, ParameterSetName = 'LiteralPath', ValueFromPipeline = $false, ValueFromPipelineByPropertyName = $true)]
    [string[]]$LiteralPath
  )
  begin {
    $shell = New-Object -ComObject Shell.Application
    $trash = $shell.NameSpace(10)
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
  Get-PSDrive -PSProvider FileSystem | Where-Object { $_.Used } | Where-Object { $_.Name -ne "Temp" } | Sort-Object Name
}

function Get-DriveInfoView {
  Get-DriveInfo | Format-Table -AutoSize
}

function Invoke-TrimSetLocation {
  param([Parameter(ValueFromPipeline = $true)][string]$Path)
  process {
    $p = $Path.Trim() -replace '^[^A-Z]+', ""
    Write-Host "cd [$p]"
    Set-Location $p
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
  python ./get-pip.py
  Remove-Item ./get-pip.py
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
  param([string]$path = $pwd)
  Get-ChildItem -Force -Recurse -File $path -Filter *.ts | ForEach-Object { molt -w $_.FullName }
}

function Get-FileAndHash {
  Get-ChildItem | ForEach-Object { [PSCustomObject]@{ path = $_.Name; hash = (Get-FileHash -Algorithm MD5 $_.FullName).Hash } }
}

# --- Aliases ---

# Remove default aliases before setting
"r", "rm", "cd", "ls", "h" | ForEach-Object { if (Get-Alias $_ -ErrorAction SilentlyContinue) {
    Remove-Item "alias:$_" -Force
  } }

$aliases = @{
  rm    = "Move-ToTrash"
  o     = "Start-Process"
  c     = "Clear-Host"
  which = "Get-Command"
  df    = "Get-DriveInfoView"
  cd    = "Set-LocationWithList"
  ls    = "Get-ChildItem"
  h     = "hitori"
}

foreach ($alias in $aliases.GetEnumerator()) {
  Set-Alias -Name $alias.Key -Value $alias.Value -Force
}

if (Test-IsWindows) {
  Set-Alias -Name e -Value nvim -Force
} else {
  Set-Alias -Name e -Value neovide -Force
}

# Filter tool setup
$filterTools = "gof", "tv", "fzf", "peco"
foreach ($tool in $filterTools) {
  if (Get-Command $tool -ErrorAction SilentlyContinue) {
    Set-Alias -Name __FILTER -Value $tool -Force
    break
  }
}

function l {
  Get-ChildItem $args
}
function la {
  Get-ChildItem -Force $args
}

# --- PSReadLine & KeyHandlers ---

$PSReadLineOptions = @{
  EditMode        = "Vi"
  ViModeIndicator = "Cursor"
}
if ($PSVersionTable.PSVersion.Major -ge 7) {
  $PSReadLineOptions.PredictionSource = "HistoryAndPlugin"
  $PSReadLineOptions.PredictionViewStyle = "InlineView"
}
Set-PSReadLineOption @PSReadLineOptions

# Mode transition handlers
Set-PSReadLineKeyHandler -Chord Escape -ViMode Insert -ScriptBlock {
  [Microsoft.PowerShell.PSConsoleReadLine]::ViCommandMode($null, $null)
  [Microsoft.PowerShell.PSConsoleReadLine]::InvokePrompt()
}

"i:ViInsertMode", "a:ViInsertWithAppend", "I:ViInsertAtBegining", "A:ViInsertAtEnd", "o:InsertLineBelow", "O:InsertLineAbove", "s:ViInsertWithDelete", "S:ViReplaceLine" | ForEach-Object {
  $parts = $_ -split ":"
  $k = $parts[0]
  $f = $parts[1]
  Set-PSReadLineKeyHandler -Chord $k -ViMode Command -ScriptBlock {
    [Microsoft.PowerShell.PSConsoleReadLine]::$f($null, $null)
    if ($k -match "o|O") {
      [Microsoft.PowerShell.PSConsoleReadLine]::ViInsertMode($null, $null)
    }
    [Microsoft.PowerShell.PSConsoleReadLine]::InvokePrompt()
  }.GetNewClosure()
}

Set-PSReadLineKeyHandler -Chord "C" -ViMode Command -ScriptBlock {
  [Microsoft.PowerShell.PSConsoleReadLine]::KillLine($null, $null)
  [Microsoft.PowerShell.PSConsoleReadLine]::ViInsertMode($null, $null)
  [Microsoft.PowerShell.PSConsoleReadLine]::InvokePrompt()
}

# Neovim integration
if ($env:NVIM) {
  Set-PSReadLineKeyHandler -Chord Escape -ViMode Command -ScriptBlock {
    & nvim --server $env:NVIM --remote-send "<C-\><C-n>"
  }
}

# Predictions & Emacs-like shortcuts
Set-PSReadLineKeyHandler -Chord Ctrl+Shift+G -ScriptBlock {
  $current = (Get-PSReadLineOption).PredictionViewStyle
  Set-PSReadLineOption -PredictionViewStyle (if ($current -eq 'InlineView') { 'ListView' } else { 'InlineView' })
}

Set-PSReadLineKeyHandler -Chord Ctrl+f -Function AcceptNextSuggestionWord -ViMode Insert
Set-PSReadLineKeyHandler -Chord Ctrl+e -Function AcceptSuggestion -ViMode Insert
Set-PSReadLineKeyHandler -Chord Shift+Spacebar -Function PossibleCompletions -ViMode Insert

$emacsKeys = @{
  "Ctrl+a" = "BeginningOfLine"; "Ctrl+b" = "BackwardChar"; "Ctrl+d" = "DeleteChar";
  "Ctrl+h" = "BackwardDeleteChar"; "Ctrl+l" = "ClearScreen"; "Ctrl+n" = "HistorySearchForward";
  "Ctrl+p" = "HistorySearchBackward"; "Ctrl+u" = "BackwardDeleteLine"; "Ctrl+w" = "BackwardDeleteWord"
}
foreach ($key in $emacsKeys.GetEnumerator()) {
  Set-PSReadLineKeyHandler -Chord $key.Key -Function $key.Value -ViMode Insert
}
