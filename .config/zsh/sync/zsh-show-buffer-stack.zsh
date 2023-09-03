setopt noflowcontrol
autoload -Uz add-zsh-hook
add-zsh-hook precmd check-buffer-stack
RPROMPT='${COMMAND_BUFFER_STACK}'

