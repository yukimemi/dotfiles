# =============================================================================
# File        : zsh-show-buffer-stack.zsh
# Author      : yukimemi
# Last Change : 2023/09/07 23:12:46.
# =============================================================================

setopt noflowcontrol
autoload -Uz add-zsh-hook
add-zsh-hook precmd check-buffer-stack
RPROMPT='${COMMAND_BUFFER_STACK}'

