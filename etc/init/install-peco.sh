#!/bin/bash

# Set DOTPATH as default variable
if [ -z "${DOTPATH:-}" ]; then
  DOTPATH=~/.ghq/src/github.com/yukimemi/dotfiles; export DOTPATH
fi

. ${DOTPATH}/etc/install

if is_linux; then
  # sudo add-apt-repository ppa:gophers/archive
  # sudo apt update
  # sudo apt install -y golang-1.9-go
  # export PATH=/usr/lib/go-1.9/bin:$PATH
  sudo snap install --classic go
fi

# Install glide.
curl https://glide.sh/get | sh

# clone peco.
git clone https://github.com/peco/peco ~/.ghq/src/github.com/peco/peco

cd ~/.ghq/src/github.com/peco/peco
glide install

go build cmd/peco/peco.go
cp -vf peco ~/.ghq/bin/

