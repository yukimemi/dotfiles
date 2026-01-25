# =============================================================================
# File        : television.zsh
# Author      : yukimemi
# Last Change : 2025/01/01 13:47:05.
# =============================================================================

(( $+commands[tv] )) || cargo install television
eval "$(tv init zsh)"

