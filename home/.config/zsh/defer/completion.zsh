# =============================================================================
# File        : completion.zsh
# Author      : yukimemi
# Last Change : 2023/09/22 21:57:01.
# =============================================================================

zstyle ':completion:*:default' menu select=2
zstyle ':completion:*' use-cache yes
zstyle ':completion:*' cache-path ~/.cache/zsh
zstyle ':completion:*' verbose yes
zstyle ':completion:*' group-name ''
zstyle ':completion:*' matcher-list '' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}'
zstyle ':autocomplete:*' widget-style menu-select
zstyle ':autocomplete:*' min-input 1

