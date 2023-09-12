# =============================================================================
# File        : func.zsh
# Author      : yukimemi
# Last Change : 2023/09/13 00:32:37.
# =============================================================================

# Filter function.
function __filter_execute() {
  $__FILTER_TOOL | while read line
do
  echo "Exec: [$@ $line]"
  $@ $line
done
}

function __filter_select() {
  $__FILTER_TOOL | while read line
do
  print -z $line
done
}

# cd and ls.
alias ls='lsd'
function chpwd() { lsd -F }

# tmux filter.
function __tmux_session_list() {
  tmux list-sessions | $__FILTER_TOOL | while read line
do
  ses=${line[(ws,:,)1]}
  if [[ -z $TMUX ]]; then
    echo "Attach ${ses}"
    tmux attach -t $ses
    return
  else
    echo "Switch ${ses}"
    tmux switch -t $ses
    return
  fi
done
}

function __tmux_tmuxinator_list() {
  tmuxinator list -n | $__FILTER_TOOL | while read line
do
  echo "Change tmuxinator ${line}"
  tmuxinator $line
  return
done
}

# show option for zsh.
# http://qiita.com/mollifier/items/26c67347734f9fcda274
function showoptions() {
  set -o | sed -e 's/^no\(.*\)on$/\1  off/' -e 's/^no\(.*\)off$/\1  on/'
}

# reboot wifi.
function rebootwifi() {
  networksetup -setairportpower en0 off
  sleep 5
  networksetup -setairportpower en0 on
  networksetup -setdhcp Wi-Fi
}

