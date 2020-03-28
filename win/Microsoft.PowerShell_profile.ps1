# module
# Install-Module -Scope CurrentUser -AllowClobber z
# Install-Module ZLocation -Scope CurrentUser

# starship
Invoke-Expression (&starship init powershell)

# ZLocation
Import-Module ZLocation

# functions.
# OS commands.
function b {
  cd ..
}
function ls {
  if (Get-Command lsd -ErrorAction SilentlyContinue) {
    lsd $args
  } else {
    Get-ChildItem $args
  }
}
function l {
  if (Get-Command lsd -ErrorAction SilentlyContinue) {
    lsd -l $args
  } else {
    Get-ChildItem $args
  }
}
function la {
  if (Get-Command lsd -ErrorAction SilentlyContinue) {
    ls -la $args
  } else {
    ls -Force $args
  }
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
