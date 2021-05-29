# =============================================================================
# File        : zshrc
# Author      : yukimemi
# Last Change : 2021/05/29 21:50:40.
# =============================================================================

# if tmux is executable and not inside a tmux session, then try to attach.
# if attachment fails, start a new session
[ -x "$(command -v tmux)" ] \
  && [ -z "${TMUX}" ] \
  && { tmux attach || tmux; } >/dev/null 2>&1

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
# plugin list.
#
zinit wait lucid light-mode for \
  atinit"zicompinit; zicdreplay" atload"zpcompinit" \
  zdharma/fast-syntax-highlighting \
  blockf atpull'zinit creinstall -q .' \
  zsh-users/zsh-completions \
  supercrabtree/k \
  @asdf-vm/asdf

zinit light-mode for \
  atload"_zsh_autosuggest_start" \
  zsh-users/zsh-autosuggestions \
  zsh-users/zsh-history-substring-search \
  jeffreytse/zsh-vi-mode \
  yuki-yano/zeno.zsh

zinit wait lucid from"gh-r" as"program" pick"bit" for \
  chriswalz/bit

#
# for git.
#
zinit wait lucid as"program" pick"$ZPFX/bin/git-*" make"PREFIX=$ZPFX" light-mode for \
  tj/git-extras


#
# zinit packages
#
# zinit pack for ls_colors
zinit wait pack for \
  dircolors-material

#
# functions.
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

# Filter history.
function __filter_history() {
  BUFFER=$(history -n 1 | $__FILTER_TOOL)
  zle clear-screen
}
zle -N __filter_history

# cd and ls.
if which lsd > /dev/null 2>&1; then
  alias ls='lsd'
elif which exa > /dev/null 2>&1; then
  alias ls='exa'
else
  alias ls='ls --color=auto'
fi
function chpwd() { ls -F }

# z and filter cd.
function __filter_z_cd() {
  zshz -t $1 | awk '{ $1=""; print }' | __filter_execute cd
  # z -t $1 | tac | awk '{ $1=""; print }' | __filter_execute cd
}

# kill.
function __filter_kill() {
  line=$(ps -ef | $__FILTER_TOOL)
  echo "Kill: [$line]"
  kill -9 $(echo $line | awk '{ print $2 }')
}
zle -N __filter_kill

# tmux filter.
function __tmux_session_list() {
  tmux list-sessions | $__FILTER_TOOL | while read line
  do
    ses=${line[(ws,:,)1]}
    if [ -z $TMUX ]; then
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

# ghq list and change dir.
function ghq-list-cd() {
  local selected_dir=$(ghq list --full-path | $__FILTER_TOOL)
  if [ -n "$selected_dir" ]; then
    BUFFER="cd ${selected_dir}"
    zle accept-line
  fi
  zle clear-screen
}
zle -N ghq-list-cd

# zsh vi key command line stack - Qiita
# http://qiita.com/items/1f2c7793944b1f6cc346
function show-buffer-stack() {
  POSTDISPLAY="
  stack: $BUFFER"
  zle push-line-or-edit
}
zle -N show-buffer-stack
setopt noflowcontrol

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

# Build neovim.
function buildneovim() {
  rhq clone https://github.com/neovim/neovim
  cd ~/src/github.com/neovim/neovim
  git pull
  make CMAKE_BUILD_TYPE=RelWithDebInfo
  sudo make install
}

#
# history.
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
# key bindings.
#
bindkey -v

function my_lazy_keybindings() {
  bindkey -M viins '^Q' show-buffer-stack
  bindkey -M viins '^s' pet-select

  bindkey -M viins '^R' __filter_history
  bindkey -M viins '^K' __filter_kill

  # histry-substring-search.
  bindkey -M viins '^P' history-substring-search-up
  bindkey -M viins '^N' history-substring-search-down

  # autosuggestions.
  bindkey -M viins '^E' autosuggest-accept
  bindkey -M viins '^F' vi-forward-word

  bindkey -M vicmd 'gh' beginning-of-line
  bindkey -M vicmd 'gl' end-of-line

  # zeno
  bindkey -M viins ' ' zeno-auto-snippet
  bindkey -M viins '^m' zeno-auto-snippet-and-accept-line
  bindkey -M viins '^i' zeno-completion
}
zvm_after_init_commands+=(my_lazy_keybindings)

# move at hjkl on menu select.
zmodload zsh/complist
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char

#
# setopt.
#
setopt magicequalsubst
setopt printeightbit
setopt completeinword

#
# zstyle.
#
zstyle ':completion:*:default' menu select=2
zstyle ':completion:*' use-cache yes
zstyle ':completion:*' cache-path ~/.cache/zsh
zstyle ':completion:*' verbose yes
zstyle ':completion:*' group-name ''
zstyle ':completion:*' matcher-list '' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}'

#
# completions.
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
# shelp.
#
if type shelp > /dev/null 2>&1; then
  eval "$(shelp init -)"
fi

#
# pmy.
#
if type pmy > /dev/null 2>&1; then
  # eval "$(pmy init)"
fi

#
# direnv.
#
if type pmy > /dev/null 2>&1; then
  eval "$(direnv hook zsh)"
fi

#
# zoxide.
#
if type zoxide > /dev/null 2>&1; then
  eval "$(zoxide init zsh)"
fi

#
# Google cloud sdk
#
if [ -f /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc ]; then
  source /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc
fi

#
# starship.
#
if (which starship > /dev/null) ;then
  eval "$(starship init zsh)"
fi

#
# compile zshrc.
#
if [ ! -f ~/.zshrc.zwc -o ~/.zshrc -nt ~/.zshrc.zwc ]; then
  zcompile ~/.zshrc
fi

if (which zprof > /dev/null) ;then
  zprof
fi


