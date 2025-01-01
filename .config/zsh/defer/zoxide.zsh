# =============================================================================
# File        : zoxide.zsh
# Author      : yukimemi
# Last Change : 2025/01/01 13:42:52.
# =============================================================================

(( $+commands[zoxide] )) || curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh
eval "$(zoxide init zsh)"

