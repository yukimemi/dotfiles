#!/bin/bash

# Set DOTPATH as default variable
if [ -z "${DOTPATH:-}" ]; then
  DOTPATH=~/.ghq/src/github.com/yukimemi/dotfiles; export DOTPATH
fi

. ${DOTPATH}/etc/install

if ! has rustup; then
  curl https://sh.rustup.rs -sSf | sh
  export PATH=${HOME}/.cargo/bin:${PATH}
fi

rustup install nightly
rustup component add rustfmt-preview --toolchain=nightly

