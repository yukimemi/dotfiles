# =============================================================================
# File        : Microsoft.PowerShell_profile.ps1
# Author      : yukimemi
# Last Change : 2025/10/05 19:12:19.
# =============================================================================

# Set title.
$Host.UI.RawUI.WindowTitle = "yukimemi-pwsh"

# Options.
$ErrorActionPreference = "Stop"

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

# Utility functions.
function Is-Windows {
  ($PSVersionTable.PSVersion.Major -eq 5) -or ($PSVersionTable.Platform -eq "Win32NT")
}

# Use utf-8
if (Is-Windows) {
  chcp 65001
  $OutputEncoding = [Console]::OutputEncoding
  $env:LANG = "ja_JP.UTF-8"
  $env:EDITOR = "hitori"
}

# starship
if (Get-Command starship -ErrorAction SilentlyContinue) {
  Invoke-Expression (&starship init powershell)
}

# OS commands.
function b {
  Set-Location ..
}

# git commands.
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

# git ignore for PowerShell
function gig {
  param(
    [Parameter(Mandatory = $true)]
    [string[]]$list
  )
  $params = ($list | ForEach-Object { [uri]::EscapeDataString($_) }) -join ","
  Invoke-WebRequest -Uri "https://www.toptal.com/developers/gitignore/api/$params" | Select-Object -ExpandProperty content | Out-File -FilePath $(Join-Path -Path $pwd -ChildPath ".gitignore") -Encoding ascii
}

function gr {
  Set-Location $(git rev-parse --show-toplevel)
}

# Auto ls on cd.
function cd-ls {
  [CmdletBinding()]
  param(
    [Parameter(ValueFromPipeline = $true)]
    [string]$path
  )
  trap {
    $_
  }
  Set-Location $path -ea Stop
  Get-ChildItem
  # Save location.
  $funcs = "function Is-Windows { ${Function:Is-Windows} }"
  Start-Job {
    param([string]$funcs, [string]$path)
    Invoke-Expression $funcs
    $z = & {
      if (Is-Windows) {
        (Join-Path $env:USERPROFILE ".cdhistory")
      } else {
        (Join-Path $env:HOME ".cdhistory")
      }
    }
    $path | Add-Content -Encoding utf8 $z
    # $c = Get-Content -Encoding utf8 $z | Where-Object { ![string]::IsNullOrEmpty($_) } | Where-Object { Test-Path $_ }
    $c = Get-Content -Encoding utf8 $z | Where-Object { ![string]::IsNullOrEmpty($_) }
    [array]::Reverse($c)
    if (Get-Command uq -ErrorAction SilentlyContinue) {
      $c | uq | Set-Variable c
    } else {
      $c | Sort-Object -Unique | Set-Variable c
    }
    [array]::Reverse($c)
    $c | Set-Content -Encoding utf8 $z
  } -ArgumentList $funcs, (Get-Location).Path > $null
}

function cdls {
  [CmdletBinding()]
  param(
    [Parameter(ValueFromPipeline = $true)]
    [string]$path
  )
  trap {
    $_
  }
  Set-Location $path -ea Stop
  Get-ChildItem
}

function t {
  exit
}

function RemoveTo-Trash {
  # https://qiita.com/Zuishin/items/1fa77bccd111b55f7bf6
  [CmdletBinding(SupportsShouldProcess = $true, DefaultParameterSetName = 'Path')]
  param (
    [SupportsWildCards()]
    [Parameter(
      Mandatory = $true,
      Position = 0,
      ParameterSetName = 'Path',
      ValueFromPipeline = $true,
      ValueFromPipelineByPropertyName = $true
    )]
    [string[]]$Path,

    [Alias('LP')]
    [Alias('PSPath')]
    [Parameter(
      Mandatory = $true,
      Position = 0,
      ParameterSetName = 'LiteralPath',
      ValueFromPipeline = $false,
      ValueFromPipelineByPropertyName = $true
    )]
    [string[]]$LiteralPath
  )
  begin {
    $shell = New-Object -ComObject Shell.Application
    $trash = $shell.NameSpace(10)
  }
  process {
    $Path = $Path.Trim()
    $Path = $Path -replace '^[^A-Z]+', ""
    if ($PSBoundParameters.ContainsKey('Path')) {
      $Path | Where-Object { ![string]::IsNullOrWhiteSpace($_) } | Set-Variable Path
      $targets = Convert-Path $Path
    } else {
      $targets = Convert-Path -LiteralPath $LiteralPath
    }
    $targets | ForEach-Object {
      if ($PSCmdlet.ShouldProcess($_)) {
        $trash.MoveHere($_)
      }
    }
  }
}

function Get-DriveInfo {
  Get-PSDrive -PSProvider FileSystem | Where-Object { $_.Used } | Where-Object { $_.Name -ne "Temp" } | Sort-Object Name
}

function Get-DriveInfoView {
  Get-DriveInfo | Format-Table -AutoSize
}

# rhq.
function Trim-Cd {
  [CmdletBinding()]
  param (
    [Parameter(
      Mandatory = $false,
      Position = 0,
      ParameterSetName = "Path",
      ValueFromPipeline = $true,
      ValueFromPipelineByPropertyName = $true,
      HelpMessage = "Path to location."
    )]
    [ValidateNotNullOrEmpty()]
    [string]
    $Path
  )

  process {
    $p = $Path.Trim()
    $p = $p -replace '^[^A-Z]+', ""
    Write-Host "cd [${p}]"
    Set-Location $p
  }
}
function rhl {
  rhq list | __FILTER | Select-Object -First 1 | Trim-Cd
}
function ghl {
  ghr list | __FILTER | Select-Object -First 1 | Trim-Cd
}
function gsl {
  gsr "${env:USERPROFILE}\src" | __FILTER | Select-Object -First 1 | Trim-Cd
}
function jd {
  Get-ChildItem -Force -Directory -Recurse | Select-Object -ExpandProperty FullName | __FILTER | Select-Object -First 1 | Trim-Cd
}

# Remove-Alias r
Remove-Item alias:r
function r {
  if (Get-Command trash -ErrorAction SilentlyContinue) {
    trash $(Get-ChildItem -Force | Select-Object -ExpandProperty FullName | __FILTER | Select-Object -First 1)
  } else {
    Get-ChildItem -Force | Select-Object -ExpandProperty FullName | __FILTER | Select-Object -First 1 | RemoveTo-Trash
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
  Invoke-WebRequest -sSL "https://bootstrap.pypa.io/get-pip.py" -o get-pip.py
  .\python .\get-pip.py
  Remove-Item .\get-pip.py
}

function Install-Aider {
  powershell -ExecutionPolicy ByPass -c "irm https://aider.chat/install.ps1 | iex"
}

function Install-Neovim {
  $nvimMsi = Join-Path $env:tmp "nvim-win64.msi"
  Invoke-WebRequest -Uri "https://github.com/neovim/neovim/releases/download/nightly/nvim-win64.msi" -OutFile $nvimMsi
  & msiexec /i $nvimMsi
}

# Alias.
if (Is-Windows) {
  Remove-Item alias:rm
}
Set-Alias rm RemoveTo-Trash
Set-Alias o Start-Process
if (Is-Windows) {
  Set-Alias e nvim
} else {
  Set-Alias e neovide
}
Set-Alias c Clear-Host
Set-Alias which Get-Command
Set-Alias df Get-DriveInfoView
# Remove-Alias cd
Remove-Item alias:cd
# Set-Alias cd cd-ls
Set-Alias cd cdls
# filter tool.
if (Get-Command peco -ErrorAction SilentlyContinue) {
  Set-Alias __FILTER peco
}
if (Get-Command gof -ErrorAction SilentlyContinue) {
  Set-Alias __FILTER gof
}
if (Get-Command tv -ErrorAction SilentlyContinue) {
  Set-Alias __FILTER tv
}
if (Get-Command fzf -ErrorAction SilentlyContinue) {
  Set-Alias __FILTER fzf
}
# Remove-Alias ls
if (Is-Windows) {
  Remove-Item alias:ls
}
Set-Alias ls Get-ChildItem
function l {
  Get-ChildItem $args
}
function la {
  Get-ChildItem -Force $args
}
if (Is-Windows) {
  Remove-Item alias:h
}
Set-Alias h hitori

# Readline setting.
Set-PSReadLineOption -EditMode Vi
Set-PSReadLineOption -ViModeIndicator cursor
if ($PSVersionTable.PSVersion.Major -ge 7) {
  Set-PSReadLineOption -PredictionSource HistoryAndPlugin
}
Set-PSReadLineKeyHandler -Key "Ctrl+f" -Function AcceptNextSuggestionWord
Set-PSReadLineKeyHandler -Key 'Ctrl+e' -Function AcceptSuggestion

Set-PSReadLineKeyHandler -Key 'Shift+Spacebar' -Function PossibleCompletions

Set-PSReadLineKeyHandler -Key 'Ctrl+a' -Function BeginningOfLine
Set-PSReadLineKeyHandler -Key 'Ctrl+b' -Function BackwardChar
Set-PSReadLineKeyHandler -Key 'Ctrl+d' -Function DeleteChar
Set-PSReadLineKeyHandler -Key 'Ctrl+h' -Function BackwardDeleteChar
Set-PSReadLineKeyHandler -Key 'Ctrl+l' -Function ClearScreen
Set-PSReadLineKeyHandler -Key 'Ctrl+n' -Function HistorySearchForward
Set-PSReadLineKeyHandler -Key 'Ctrl+p' -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Key 'Ctrl+u' -Function BackwardDeleteLine
Set-PSReadLineKeyHandler -Key 'Ctrl+w' -Function BackwardDeleteWord

# Write-Host -Foreground Green "`n[ZLocation] knows about $((Get-ZLocation).Keys.Count) locations.`n"

# z.
function _j1 {
  z | Sort-Object -Descending Weight | Select-Object -ExpandProperty Path | __FILTER | Select-Object -First 1 | Trim-Cd
}

function _j2 {
  $z = & {
    if (Is-Windows) {
      (Join-Path $env:USERPROFILE ".cdhistory")
    } else {
      (Join-Path $env:HOME ".cdhistory")
    }
  }
  $c = Get-Content $z
  [array]::Reverse($c)
  $c | __FILTER | Select-Object -First 1 | Trim-Cd
  # Get-Content $z | __FILTER | Trim-Cd
  Get-Job | Stop-Job -PassThru | Remove-Job -Force
}

function j {
  zi
}

# zoxide.
if (Get-Command zoxide -ErrorAction SilentlyContinue) {
  Invoke-Expression (& { (zoxide init powershell | Out-String) })
}

# yazi
function y {
  $tmp = [System.IO.Path]::GetTempFileName()
  yazi $args --cwd-file="$tmp"
  $cwd = Get-Content -Path $tmp
  if (-not [String]::IsNullOrEmpty($cwd) -and $cwd -ne $PWD.Path) {
    Set-Location -LiteralPath $cwd
  }
  Remove-Item -Path $tmp
}

# molt
function Update-WithMolt {
  param([string]$path = $pwd)
  Get-ChildItem -Force -Recurse -File $path | Where-Object {
    $_.Extension -eq ".ts"
  } | ForEach-Object {
    molt -w $_.FullName
  }
}

# hash.
function Get-FileAndHash {
  Get-ChildItem . | ForEach-Object { [PSCustomObject]@{ path = $_.Name; hash = (Get-FileHash -a md5 $_.FullName).Hash } }
}

# Chocolatey profile
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}

# fnm
if (Get-Command fnm -ErrorAction SilentlyContinue) {
  fnm env --use-on-cd | Out-String | Invoke-Expression
}

# pkgx
if (-not (Get-Command pkgx -ErrorAction SilentlyContinue)) {
  powershell -Command "irm https://pkgx.sh | iex"
}
