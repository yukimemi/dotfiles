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

