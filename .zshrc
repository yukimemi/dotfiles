# =============================================================================
# File        : zshrc
# Author      : yukimemi
# Last Change : 2023/09/03 22:41:18.
# =============================================================================

#
# tea/cli
#
if ! type tea > /dev/null 2>&1; then
  sh <(curl tea.xyz)
fi
source <(tea --magic=zsh)

#
# tmux
#
[ -z "${TMUX}" ] && { tmux attach || tmux -u; } >/dev/null 2>&1

## deno
(( $+commands[deno] )) || curl -fsSL https://deno.land/x/install/install.sh | sh

#
# sheldon
#
(( $+commands[sheldon] )) || cargo install sheldon
eval "$(sheldon source)"

#
# rhq
#
(( $+commands[rhq] )) || cargo install --git https://github.com/ubnt-intrepid/rhq.git

#
# direnv.
#
eval "$(direnv hook zsh)"

#
# zoxide.
#
eval "$(zoxide init zsh)"

#
# atuin.
#
(( $+commands[atuin] )) || cargo install atuin --locked
eval "$(atuin init zsh)"


# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

#
# functions.
#

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
function chpwd() { ls -F }

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
  bindkey -M viins '^r' _atuin_search_widget
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
# compile zshrc.
#
if [ ! -f ~/.zshrc.zwc -o ~/.zshrc -nt ~/.zshrc.zwc ]; then
  zcompile ~/.zshrc
fi

if (which zprof > /dev/null) ;then
  zprof
fi

# eval "$(zellij setup --generate-auto-start zsh)"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
