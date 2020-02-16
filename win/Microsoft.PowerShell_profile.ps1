Invoke-Expression (&starship init powershell)

# functions. {{{1
# OS commands.
function b {
  cd ..
}
function l {
  Get-ChildItem $args
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

# editor.
function e {
  if ($args.length -eq 0) {
    gvim
  } else {
    gvim --remote-silent $args
  }
}

# rhq.
function rhl {
  rhq list | gof | cd
}

# Alias. {{{1
Set-Alias o Start-Process


# Readline setting. {{{1
Set-PSReadLineOption -EditMode Vi

Set-PSReadlineKeyHandler -Key 'Ctrl+u' -Function BackwardDeleteLine
Set-PSReadlineKeyHandler -Key 'Ctrl+b' -Function BackwardChar
Set-PSReadlineKeyHandler -Key 'Ctrl+f' -Function ForwardChar
Set-PSReadlineKeyHandler -Key 'Ctrl+d' -Function DeleteChar
Set-PSReadlineKeyHandler -Key 'Ctrl+h' -Function BackwardDeleteChar
Set-PSReadlineKeyHandler -Key 'Ctrl+p' -Function HistorySearchBackward
Set-PSReadlineKeyHandler -Key 'Ctrl+n' -Function HistorySearchForward
Set-PSReadlineKeyHandler -Key 'Ctrl+a' -Function BeginningOfLine
Set-PSReadlineKeyHandler -Key 'Ctrl+e' -Function EndOfLine