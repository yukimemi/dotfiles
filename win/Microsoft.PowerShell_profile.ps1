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

# wsl
# Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux
# Invoke-WebRequest -Uri https://aka.ms/wslubuntu2004 -OutFile ubuntu-2004.appx -UseBasicParsing
# Add-AppxPackage .\ubuntu-2004.appx

# Use utf-8
chcp 65001
$OutputEncoding = [Console]::OutputEncoding

# starship
if (Get-Command starship -ErrorAction SilentlyContinue) {
  Invoke-Expression (&starship init powershell)
}

# Utility functions.
function Is-Windows {
  ($PSVersionTable.PSVersion.Major -eq 5) -or ($PSVersionTable.Platform -eq "Win32NT")
}

# ZLocation
# Import-Module ZLocation
# Get-ChildItemColor
Import-Module Get-ChildItemColor
# Pscx
if (Is-Windows) {
  Import-Module Pscx
}

# OS commands.
function b {
  cd ..
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
# git ignore for PowerShell v3
function gig {
  param(
    [Parameter(Mandatory=$true)]
    [string[]]$list
  )
  $params = ($list | ForEach-Object { [uri]::EscapeDataString($_) }) -join ","
  Invoke-WebRequest -Uri "https://www.gitignore.io/api/$params" | select -ExpandProperty content | Out-File -FilePath $(Join-Path -path $pwd -ChildPath ".gitignore") -Encoding ascii
}
function gr {
  cd $(git rev-parse --show-cdup)
}

# Auto ls on cd.
function cd-ls {
  [CmdletBinding()]
  param(
    [Parameter(ValueFromPipeline=$true)]
    [string]$path
  )
  trap { $_ }
  Set-Location $path -ea Stop
  ls
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
    $c = Get-Content -Encoding utf8 $z | ? { ![string]::IsNullOrEmpty($_) } | ? { Test-Path $_ }
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
    [Parameter(ValueFromPipeline=$true)]
    [string]$path
  )
  trap { $_ }
  Set-Location $path -ea Stop
  ls
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
    if ($PSBoundParameters.ContainsKey('Path')) {
      $Path | ? { ![string]::IsNullOrWhiteSpace($_) } | Set-Variable Path
      $targets = Convert-Path $Path
    } else {
      $targets = Convert-Path -LiteralPath $LiteralPath
    }
    $targets | % {
      if ($PSCmdlet.ShouldProcess($_)) {
        $trash.MoveHere($_)
      }
    }
  }
}

function Get-DriveInfo {
  Get-PSDrive -PSProvider FileSystem | ? { $_.Used } | ? { $_.Name -ne "Temp" } | Sort-Object Name
}

function Get-DriveInfoView {
  Get-DriveInfo | Format-Table -AutoSize
}

# rhq.
function rhl {
  rhq list | __FILTER | cd
}

# Remove-Alias r
Remove-Item alias:r
function r {
  if (Get-Command trash -ErrorAction SilentlyContinue) {
    trash $(Get-ChildItem | Select-Object -ExpandProperty FullName | __FILTER)
  } else {
    Get-ChildItem | Select-Object -ExpandProperty FullName | __FILTER | RemoveTo-Trash
  }
}

function v {
  gvim --remote-silent $args
}
function VimDeinUpdate {
  vim -c "silent! call dein#update() | q"
}

function Install-Pip {
  [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.SecurityProtocolType]::Tls12
  curl -sSL "https://bootstrap.pypa.io/get-pip.py" -o get-pip.py
  .\python .\get-pip.py
  rm .\get-pip.py
}

# Alias.
Set-Alias gomi RemoveTo-Trash
Remove-Item alias:rm
Set-Alias rm RemoveTo-Trash
Set-Alias o Start-Process
Set-Alias e nvim
Set-Alias which Get-Command
Set-Alias df Get-DriveInfoView
# Remove-Item alias:cd
# Remove-Alias cd
Remove-Item alias:cd
# Set-Alias cd cd-ls
Set-Alias cd cdls
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
if (Is-Windows) {
  Set-Alias ls Get-ChildItem
  function l { ls $args }
  function la { ls -Force $args }
} else {
  Set-Alias ls lsd
  function l { ls -l $args }
  function la { ls -a $args }
}

# Readline setting.
Set-PSReadLineOption -EditMode Vi

Set-PSReadLineKeyHandler -Key 'Ctrl+a' -Function BeginningOfLine
Set-PSReadLineKeyHandler -Key 'Ctrl+b' -Function BackwardChar
Set-PSReadLineKeyHandler -Key 'Ctrl+d' -Function DeleteChar
Set-PSReadLineKeyHandler -Key 'Ctrl+e' -Function EndOfLine
# Set-PSReadLineKeyHandler -Key 'Ctrl+f' -Function ForwardChar
Set-PSReadLineKeyHandler -Key 'Ctrl+h' -Function BackwardDeleteChar
Set-PSReadLineKeyHandler -Key 'Ctrl+l' -Function ClearScreen
Set-PSReadLineKeyHandler -Key 'Ctrl+n' -Function HistorySearchForward
Set-PSReadLineKeyHandler -Key 'Ctrl+p' -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Key 'Ctrl+u' -Function BackwardDeleteLine
Set-PSReadLineKeyHandler -Key 'Ctrl+w' -Function BackwardDeleteWord

$readLineVersion = (Get-Module -Name PSReadline).Version
if ($readLineVersion.Major + 0.1 * $readLineVersion.Minor -ge 2.1) {
  Set-PSReadLineOption -PredictionSource History
  Set-PSReadLineKeyHandler -Key "Ctrl+f" -Function ForwardWord
}

# Write-Host -Foreground Green "`n[ZLocation] knows about $((Get-ZLocation).Keys.Count) locations.`n"

# z.
function _j {
  # z | Sort-Object -Descending Weight | Select-Object -ExpandProperty Path | __FILTER | cd
  $z = & {
    if (Is-Windows) {
      (Join-Path $env:USERPROFILE ".z")
    } else {
      (Join-Path $env:HOME ".z")
    }
  }
  # $c = Get-Content $z
  # [array]::Reverse($c)
  # $c | __FILTER | cd
  Get-Content $z | __FILTER | cd
  Get-Job | Stop-Job -PassThru | Remove-Job -Force
}

function j { zi }

# zoxide.
Invoke-Expression (& {
  $hook = if ($PSVersionTable.PSVersion.Major -lt 6) { 'prompt' } else { 'pwd' }
  (zoxide init --hook $hook powershell) -join "`n"
})

# hash.
function Get-FileAndHash {
  gci . | % { [PSCustomObject]@{ path = $_.Name; hash = (Get-FileHash -a md5 $_.FullName).Hash } }
}

# Chocolatey profile
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}

