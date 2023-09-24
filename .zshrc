# =============================================================================
# File        : zshrc
# Author      : yukimemi
# Last Change : 2023/09/24 11:16:34.
# =============================================================================

#
# tea/cli
#
(( $+commands[tea] )) || sh <(curl tea.xyz)
function command_not_found_handler() {
  (( $+commands[$1] )) || tea install $1
  tea -- $*
}

#
# source command override technique
# https://zenn.dev/fuzmare/articles/zsh-plugin-manager-cache
#
function source {
  ensure_zcompiled $1
  builtin source $1
}
function ensure_zcompiled {
  local compiled="$1.zwc"
  if [[ ! -r "$compiled" || "$1" -nt "$compiled" ]]; then
    echo "\033[1;36mCompiling\033[m $1"
    zcompile $1
  fi
}
ensure_zcompiled "$HOME/.zshrc"

#
# sheldon cache technique
#
export SHELDON_CONFIG_DIR="$HOME/.config/sheldon"
sheldon_cache="$SHELDON_CONFIG_DIR/sheldon.zsh"
sheldon_toml="$SHELDON_CONFIG_DIR/plugins.toml"
(( $+commands[sheldon] )) || cargo install sheldon
if [[ ! -r "$sheldon_cache" || "$sheldon_toml" -nt "$sheldon_cache" ]]; then
  sheldon source > $sheldon_cache
fi
source "$sheldon_cache"
unset sheldon_cache sheldon_toml

#
# tmux
#
[ -z "${TMUX}" ] && { tmux attach || tmux -u; }

# Release source
zsh-defer unfunction source

