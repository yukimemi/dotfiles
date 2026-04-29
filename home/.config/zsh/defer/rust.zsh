# =============================================================================
# File        : rust.zsh
# Author      : yukimemi
# Last Change : 2023/09/16 21:33:32.
# =============================================================================

[[ -f "$HOME/.cargo/bin/rustup" ]] || curl https://sh.rustup.rs -sSf | sh -s -- --no-modify-path -y
source "$HOME/.cargo/env"
rustup default stable

