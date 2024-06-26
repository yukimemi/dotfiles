# =============================================================================
# File        : zeno.zsh
# Author      : yukimemi
# Last Change : 2023/09/12 23:35:51.
# =============================================================================

# Experimental: Use UNIX Domain Socket
export ZENO_ENABLE_SOCK=1
# if enable fzf-tmux
# export ZENO_ENABLE_FZF_TMUX=1
# if setting fzf-tmux options
# export ZENO_FZF_TMUX_OPTIONS="-p"
# git file preview with color
export ZENO_GIT_CAT="bat --color=always"
# git folder preview with color
export ZENO_GIT_TREE="exa -TFla --icons --git --git-ignore -I .git"

