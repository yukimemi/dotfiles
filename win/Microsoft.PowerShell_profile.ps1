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

# starship
Invoke-Expression (&starship init powershell)

# ZLocation
Import-Module ZLocation
# Get-ChildItemColor
Import-Module Get-ChildItemColor

# functions.
function Is-Windows {
  $PSVersionTable.Platform -eq "Win32NT"
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
Function gig {
  param(
    [Parameter(Mandatory=$true)]
    [string[]]$list
  )
  $params = ($list | ForEach-Object { [uri]::EscapeDataString($_) }) -join ","
  Invoke-WebRequest -Uri "https://www.gitignore.io/api/$params" | select -ExpandProperty content | Out-File -FilePath $(Join-Path -path $pwd -ChildPath ".gitignore") -Encoding ascii
}

# rhq.
function rhl {
  rhq list | __FILTER | cd
}

# Alias.
Set-Alias o Start-Process
Set-Alias e nvim
Set-Alias which Get-Command
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

Set-PSReadlineKeyHandler -Key 'Ctrl+a' -Function BeginningOfLine
Set-PSReadlineKeyHandler -Key 'Ctrl+b' -Function BackwardChar
Set-PSReadlineKeyHandler -Key 'Ctrl+d' -Function DeleteChar
Set-PSReadlineKeyHandler -Key 'Ctrl+e' -Function EndOfLine
Set-PSReadlineKeyHandler -Key 'Ctrl+f' -Function ForwardChar
Set-PSReadlineKeyHandler -Key 'Ctrl+h' -Function BackwardDeleteChar
Set-PSReadlineKeyHandler -Key 'Ctrl+l' -Function ClearScreen
Set-PSReadlineKeyHandler -Key 'Ctrl+n' -Function HistorySearchForward
Set-PSReadlineKeyHandler -Key 'Ctrl+p' -Function HistorySearchBackward
Set-PSReadlineKeyHandler -Key 'Ctrl+u' -Function BackwardDeleteLine

Write-Host -Foreground Green "`n[ZLocation] knows about $((Get-ZLocation).Keys.Count) locations.`n"

# z.
function j {
  z | Sort-Object -Descending Weight | Select-Object -ExpandProperty Path | __FILTER | cd
}
