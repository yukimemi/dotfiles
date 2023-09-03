# =============================================================================
# File        : zshrc
# Author      : yukimemi
# Last Change : 2023/09/03 23:56:31.
# =============================================================================

#
# tea/cli
#
if ! type tea > /dev/null 2>&1; then
  sh <(curl tea.xyz)
fi
source <(tea --magic=zsh)

#
# sheldon
#
(( $+commands[sheldon] )) || cargo install sheldon
eval "$(sheldon source)"

#
# tmux
#
[ -z "${TMUX}" ] && { tmux attach || tmux -u; } >/dev/null 2>&1

#
# compile zshrc.
#
if [ ! -f ~/.zshrc.zwc -o ~/.zshrc -nt ~/.zshrc.zwc ]; then
  zcompile ~/.zshrc
fi

