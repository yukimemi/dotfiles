# =============================================================================
# File        : volta.zsh
# Author      : yukimemi
# Last Change : 2024/01/03 20:37:09.
# =============================================================================

(( $+commands[volta] )) || curl https://get.volta.sh | bash
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"

