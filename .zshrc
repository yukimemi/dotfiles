# =============================================================================
# File        : zshrc
# Author      : yukimemi
# Last Change : 2023/08/02 23:47:15.
# =============================================================================

# if tmux is executable and not inside a tmux session, then try to attach.
# if attachment fails, start a new session
[ -x "$(command -v tmux)" ] \
  && [ -z "${TMUX}" ] \
  && { tmux attach || tmux -u; } >/dev/null 2>&1

is_mac=false
is_linux=false
case "$(uname -s)" in
  Darwin*)
    is_mac=true
    ;;
  Linux*)
    is_linux=true
    ;;
esac

#
# sheldon
#
if ! type sheldon > /dev/null 2>&1; then
  cargo install sheldon
fi
eval "$(sheldon source)"

#
# deno
#
if ! type deno > /dev/null 2>&1; then
  curl -fsSL https://deno.land/x/install/install.sh | sh
fi

#
# go
#
if ! type go > /dev/null 2>&1; then
  if $is_mac; then
    brew install go
  elif $is_linux; then
    sudo apt install -y golang
  fi
fi

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

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
# function __filter_history() {
#   BUFFER=$(history -n 1 | $__FILTER_TOOL)
#   zle clear-screen
# }
# zle -N __filter_history

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

# ghq list and change dir.
function ghq-list-cd() {
local selected_dir=$(ghq list --full-path | $__FILTER_TOOL)
if [[ -n "$selected_dir" ]]; then
  BUFFER="cd ${selected_dir}"
  zle accept-line
fi
zle clear-screen
}
zle -N ghq-list-cd

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
if [[ -d ~/Syncthing ]]; then
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
  bindkey -M viins '^q' show-buffer-stack
  # bindkey -M viins '^s' pet-select

  # bindkey -M viins '^r' __filter_history
  # bindkey -M viins '^k' __filter_kill

  # histry-substring-search.
  bindkey -M viins '^p' history-substring-search-up
  bindkey -M viins '^n' history-substring-search-down

  # autosuggestions.
  bindkey -M viins '^e' autosuggest-accept
  bindkey -M viins '^f' vi-forward-word

  bindkey -M vicmd 'gh' beginning-of-line
  bindkey -M vicmd 'gl' end-of-line

  # zeno
  if [[ -n $ZENO_LOADED ]]; then
    bindkey -M viins ' ' zeno-auto-snippet
    bindkey -M viins '^m' zeno-auto-snippet-and-accept-line
    bindkey -M viins '^i' zeno-completion
    bindkey -M viins '^s' zeno-insert-snippet
  fi

  # atuin
  if type atuin > /dev/null 2>&1; then
    bindkey -M viins '^r' _atuin_search_widget
  fi

}
zvm_after_init_commands+=(my_lazy_keybindings)

#
# setopt.
#
setopt magicequalsubst
setopt printeightbit
setopt completeinword

#
# zstyle.
#
autoload -U compinit && compinit
zstyle ':completion:*:default' menu select=2
zstyle ':completion:*' use-cache yes
zstyle ':completion:*' cache-path ~/.cache/zsh
zstyle ':completion:*' verbose yes
zstyle ':completion:*' group-name ''
zstyle ':completion:*' matcher-list '' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}'
zstyle ':autocomplete:*' widget-style menu-select
zstyle ':autocomplete:*' min-input 1

# move at hjkl on menu select.
zmodload zsh/complist
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char


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
# yuki-yano/zeno.zsh
#
# Experimental: Use UNIX Domain Socket
export ZENO_ENABLE_SOCK=1
# if enable fzf-tmux
export ZENO_ENABLE_FZF_TMUX=1
# if setting fzf-tmux options
# export ZENO_FZF_TMUX_OPTIONS="-p"
# git file preview with color
export ZENO_GIT_CAT="bat --color=always"
# git folder preview with color
export ZENO_GIT_TREE="exa --tree"

#
# yukiycino-dotfiles/zsh-show-buffer-stack
#
setopt noflowcontrol
autoload -Uz add-zsh-hook
add-zsh-hook precmd check-buffer-stack
RPROMPT='${COMMAND_BUFFER_STACK}'

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
if type direnv > /dev/null 2>&1; then
  eval "$(direnv hook zsh)"
fi

#
# zoxide.
#
if ! type zoxide > /dev/null 2>&1; then
  curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash
fi
eval "$(zoxide init zsh)"

#
# atuin.
#
if type atuin > /dev/null 2>&1; then
  eval "$(atuin init zsh)"
fi

#
# rtx
#
if type rtx > /dev/null 2>&1; then
  eval "$(rtx activate zsh)"
fi


#
# Google cloud sdk
#
if [[ -f /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc ]]; then
  source /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc
fi

#
# starship.
#
# if (which starship > /dev/null) ;then
#   eval "$(starship init zsh)"
# fi

#
# broot.
#
if [[ -f ~/.config/broot/launcher/bash/br ]]; then
  source ~/.config/broot/launcher/bash/br
fi

#
# tea
#
if ! type tea > /dev/null 2>&1; then
  sh <(curl https://tea.xyz)
fi
source <(tea --magic=zsh)

#
# pnpm
#
export PNPM_HOME="${HOME}/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

#
# fzf
#
if ! type fzf > /dev/null 2>&1; then
  go install github.com/junegunn/fzf@latest
fi
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

#
# p10k
#
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

#
# compile zshrc.
#
if [ ! -f ~/.zshrc.zwc -o ~/.zshrc -nt ~/.zshrc.zwc ]; then
  zcompile ~/.zshrc
fi

if (which zprof > /dev/null) ;then
  zprof
fi

