# =============================================================================
# File        : rust.zsh
# Author      : yukimemi
# Last Change : 2023/09/16 01:32:25.
# =============================================================================

(( $+commands[rustup] )) || curl https://sh.rustup.rs -sSf | sh -s -- --no-modify-path
source "$HOME/.cargo/env"
rustup default stable

