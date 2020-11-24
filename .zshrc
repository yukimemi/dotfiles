# =============================================================================
# File        : zshrc
# Author      : yukimemi
# Last Change : 2020/11/15 23:52:12.
# =============================================================================

### Added by Zinit's installer
if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
  print -P "%F{33}▓▒░ %F{220}Installing %F{33}DHARMA%F{220} Initiative Plugin Manager (%F{33}zdharma/zinit%F{220})…%f"
  command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
  command git clone https://github.com/zdharma/zinit "$HOME/.zinit/bin" && \
    print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
    print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
  zinit-zsh/z-a-rust \
  zinit-zsh/z-a-as-monitor \
  zinit-zsh/z-a-patch-dl \
  zinit-zsh/z-a-bin-gem-node

### End of Zinit's installer chunk


#
# plugin list. {{{2
#
zinit wait lucid light-mode for \
  olets/zsh-abbr \
  atinit"zicompinit; zicdreplay" atload"zpcompinit" \
  zdharma/fast-syntax-highlighting \
  blockf atpull'zinit creinstall -q .' \
  zsh-users/zsh-completions \
  agkozak/zsh-z \
  supercrabtree/k \
  @asdf-vm/asdf

zinit light-mode for \
  atload"_zsh_autosuggest_start" \
  zsh-users/zsh-autosuggestions \
  zsh-users/zsh-history-substring-search

zinit wait lucid from"gh-r" as"program" mv"direnv* -> direnv" \
  atclone'./direnv hook zsh > zhook.zsh' atpull'%atclone' \
  pick"direnv" src="zhook.zsh" for \
  direnv/direnv

zinit wait lucid from"gh-r" as"program" pick"bit" for \
  chriswalz/bit

#
# for git. {{{2
#
zinit wait lucid as"program" pick"$ZPFX/bin/git-*" make"PREFIX=$ZPFX" light-mode for \
  tj/git-extras


#
# zinit packages {{{2
#
# zinit pack for ls_colors
zinit wait pack for \
  dircolors-material \
  system-completions \
  fzf


#
# functions. {{{1
#
function pdfmin() {
  local cnt=0
  for i in $@; do
    gs -sDEVICE=pdfwrite \
      -dCompatibilityLevel=1.4 \
      -dPDFSETTINGS=/screen \
      -dNOPAUSE -dQUIET -dBATCH \
      -sOutputFile=${i%%.*}.min.pdf ${i} &
          (( (cnt += 1) % 4 == 0 )) && wait
  done
  wait && return 0
}

function prev() {
  PREV=$(fc -lrn | head -n 1)
  sh -c "pet new `printf %q "$PREV"`"
}
function pet-select() {
  BUFFER=$(pet search --query "$LBUFFER")
  CURSOR=$#BUFFER
  zle redisplay
}
zle -N pet-select

# Filter function. {{{2
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

# Filter history. {{{2
function __filter_history() {
  BUFFER=$(history -n 1 | $__FILTER_TOOL)
  zle clear-screen
}
zle -N __filter_history

# cd and ls. {{{2
if which lsd > /dev/null 2>&1; then
  alias ls='lsd'
elif which exa > /dev/null 2>&1; then
  alias ls='exa'
else
  alias ls='ls --color=auto'
fi
function chpwd() { ls -F }

# z and filter cd. {{{2
function __filter_z_cd() {
  zshz -t $1 | awk '{ $1=""; print }' | __filter_execute cd
  # z -t $1 | tac | awk '{ $1=""; print }' | __filter_execute cd
}

# kill. {{{2
function __filter_kill() {
  line=$(ps -ef | $__FILTER_TOOL)
  echo "Kill: [$line]"
  kill -9 $(echo $line | awk '{ print $2 }')
}
zle -N __filter_kill

# ghq list and change dir. {{{2
function ghq-list-cd() {
  local selected_dir=$(ghq list --full-path | $__FILTER_TOOL)
  if [ -n "$selected_dir" ]; then
    BUFFER="cd ${selected_dir}"
    zle accept-line
  fi
  zle clear-screen
}
zle -N ghq-list-cd

# zsh vi key command line stack - Qiita {{{2
# http://qiita.com/items/1f2c7793944b1f6cc346
function show-buffer-stack() {
  POSTDISPLAY="
  stack: $BUFFER"
  zle push-line-or-edit
}
zle -N show-buffer-stack
setopt noflowcontrol

# show option for zsh. {{{2
# http://qiita.com/mollifier/items/26c67347734f9fcda274
function showoptions() {
  set -o | sed -e 's/^no\(.*\)on$/\1  off/' -e 's/^no\(.*\)off$/\1  on/'
}

# reboot wifi. {{{2
function rebootwifi() {
  networksetup -setairportpower en0 off
  sleep 5
  networksetup -setairportpower en0 on
  networksetup -setdhcp Wi-Fi
}

#
# history. {{{1
#
if [ -d ~/Syncthing ]; then
  export HISTFILE=~/Syncthing/pc/.zsh_history
else
  export HISTFILE=~/.zsh_history
fi
HISTSIZE=9999999
SAVEHIST=9999999

setopt sharehistory
setopt appendhistory
setopt histignorealldups
setopt histignoredups
setopt histsavenodups
setopt extendedhistory
setopt histignorespace
setopt histverify


#
# key bindings. {{{1
#
bindkey -v

bindkey '^Q' show-buffer-stack
bindkey '^s' pet-select

bindkey '^R' __filter_history
bindkey '^K' __filter_kill

# histry-substring-search. {{{2
bindkey '^P' history-substring-search-up
bindkey '^N' history-substring-search-down

# autosuggestions. {{{2
bindkey '^F' autosuggest-accept
# bindkey '^F' vi-forward-word

# move at hjkl on menu select. {{{2
zmodload zsh/complist
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char

#
# setopt. {{{1
#
setopt magicequalsubst
setopt printeightbit
setopt completeinword

#
# zstyle. {{{1
#
zstyle ':completion:*:default' menu select=2
zstyle ':completion:*' use-cache yes
zstyle ':completion:*' cache-path ~/.cache/zsh
zstyle ':completion:*' verbose yes
zstyle ':completion:*' group-name ''
zstyle ':completion:*' matcher-list '' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}'

#
# completions. {{{1
#
if (which rustup > /dev/null); then
  if [[ ! -f ${HOME}/.config/zsh/completions/_rustup ]]; then
    rustup completions zsh > ~/.config/zsh/completions/_rustup
  fi
  if [[ ! -f ${HOME}/.config/zsh/completions/_cargo ]]; then
    rustup completions zsh cargo > ~/.config/zsh/completions/_cargo
  fi
fi

#
# shelp. {{{1
#
if type shelp > /dev/null 2>&1; then
  eval "$(shelp init -)"
fi

#
# starship. {{{1
#
if (which starship > /dev/null) ;then
  eval "$(starship init zsh)"
fi

#
# compile zshrc. {{{1
#
# if [ ! -f ~/.zshrc.zwc -o ~/.zshrc -nt ~/.zshrc.zwc ]; then
#   zcompile ~/.zshrc
# fi

if (which zprof > /dev/null) ;then
  zprof
fi


# vim:fdm=marker expandtab fdc=3 ft=zsh:

