# module
# Install-Module -Force -Scope CurrentUser core
# Install-Module -Force -Scope CurrentUser ZLocation
# Install-Module -Force -Scope CurrentUser -AllowClobber Get-ChildItemColor
# Install-Module -Force -Scope CurrentUser PendingReboot
# Install-Module -Force -Scope CurrentUser VSSetup
# Install-Module -Force -Scope CurrentUser Pester
# Install-Module -Force -Scope CurrentUser MicrosoftTeams
# Install-Module -Force -Scope CurrentUser VcRedist
# Install-Module -Force -Scope CurrentUser -AllowClobber Pscx
# Install-Module -Force -Scope CurrentUser PSReadLine
# Install-Module -Force -Scope CurrentUser PowerHTML
# Install-Module -Force -Scope CurrentUser ComputerManagementDsc; Get-DscResource -Module ComputerManagementDsc
# Install-Module -Force -Scope CurrentUser PSFzf

# wsl
# Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux
# Invoke-WebRequest -Uri https://aka.ms/wslubuntu2004 -OutFile ubuntu-2004.appx -UseBasicParsing
# Add-AppxPackage .\ubuntu-2004.appx

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

$ErrorActionPreference = "SilentlyContinue"
Stop-Transcript | Out-Null
$ErrorActionPreference = "Stop"
$transcriptPath = [System.IO.Path]::Combine($env:USERPROFILE, ".cache", "ps1", "logs")
New-Item -Force -ItemType Directory $transcriptPath | Out-Null
Start-Transcript -OutputDirectory $transcriptPath

# starship
if (Get-Command starship -ErrorAction SilentlyContinue) {
  Invoke-Expression (&starship init powershell)
}

# ZLocation
# Import-Module ZLocation

# Get-ChildItemColor
# Import-Module Get-ChildItemColor
# Pscx
# if (Is-Windows) {
#   Import-Module Pscx
# }

# OS commands.
function b {
  Set-Location ..
}

# git commands.
function g {
  git $args
}
function s {
  jj st
}
function d {
  jj diff $args
}
function jl {
  jj l $args
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
Function gig {
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
        (Join-Path $env:USERPROFILE ".z")
      } else {
        (Join-Path $env:HOME ".z")
      }
    }
    $path | Add-Content -Encoding utf8 $z
    $c = Get-Content -Encoding utf8 $z | Where-Object { ![string]::IsNullOrEmpty($_) } | Where-Object { Test-Path $_ }
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
  Param (
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
  Begin {
    $shell = New-Object -ComObject Shell.Application
    $trash = $shell.NameSpace(10)
  }
  Process {
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
  rhq list | __FILTER | Trim-Cd
}
function ghl {
  ghr list | __FILTER | Trim-Cd
}

# Remove-Alias r
Remove-Item alias:r
function r {
  if (Get-Command trash -ErrorAction SilentlyContinue) {
    trash $(Get-ChildItem -Force | Select-Object -ExpandProperty FullName | __FILTER)
  } else {
    Get-ChildItem -Force | Select-Object -ExpandProperty FullName | __FILTER | RemoveTo-Trash
  }
}

function fe {
  fd | __FILTER | nvim
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

# Alias.
Set-Alias gomi RemoveTo-Trash
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
Set-Alias cd cd-ls
# Set-Alias cd cdls
# filter tool.
if (Get-Command fzf -ErrorAction SilentlyContinue) {
  Set-Alias __FILTER fzf
}
if (Get-Command peco -ErrorAction SilentlyContinue) {
  Set-Alias __FILTER peco
}
if (Get-Command gof -ErrorAction SilentlyContinue) {
  Set-Alias __FILTER gof
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

Set-PSReadLineOption -PredictionSource HistoryAndPlugin
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
  z | Sort-Object -Descending Weight | Select-Object -ExpandProperty Path | __FILTER | Trim-Cd
}

function _j2 {
  $z = & {
    if (Is-Windows) {
      (Join-Path $env:USERPROFILE ".z")
    } else {
      (Join-Path $env:HOME ".z")
    }
  }
  $c = Get-Content $z
  [array]::Reverse($c)
  $c | __FILTER | Trim-Cd
  # Get-Content $z | __FILTER | Trim-Cd
  Get-Job | Stop-Job -PassThru | Remove-Job -Force
}

function j {
  _j2
}

# zoxide.
# Invoke-Expression (& {
#     $hook = if ($PSVersionTable.PSVersion.Major -lt 6) { 'prompt' } else { 'pwd' }
#     (zoxide init --hook $hook powershell) -join "`n"
#   })

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

# pnpm
if (Get-Command pnpm -ErrorAction SilentlyContinue) {
  $env:PNPM_HOME = [System.IO.Path]::Combine($env:USERPROFILE, 'AppData\Local\pnpm\store')
  [System.Environment]::SetEnvironmentVariable("PNPM_HOME", $env:PNPM_HOME, [System.EnvironmentVariableTarget]::User)
}

