# =============================================================================
# File        : atuin.zsh
# Author      : yukimemi
# Last Change : 2023/09/07 23:11:41.
# =============================================================================

(( $+commands[atuin] )) || cargo install atuin --locked
eval "$(atuin init zsh)"
