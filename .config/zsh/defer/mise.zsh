# =============================================================================
# File        : mise.zsh
# Author      : yukimemi
# Last Change : 2024/01/03 22:42:39.
# =============================================================================

(( $+commands[mise] )) || curl https://mise.jdx.dev/install.sh | sh
eval "$(~/.local/share/mise/bin/mise activate zsh)"

