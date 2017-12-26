#!/bin/bash

# Set DOTPATH as default variable
if [ -z "${DOTPATH:-}" ]; then
  DOTPATH=~/.ghq/src/github.com/yukimemi/dotfiles; export DOTPATH
fi

. ${DOTPATH}/etc/install

init() {
  if is_osx; then
    if ! has "brew"; then
      e_header "Install Homebrew"
      /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    fi
  fi

  if is_linux; then
    if has "apt"; then
      e_header "Upgrade apt"
      apt update && apt upgrade
    elif has "yum"; then
      e_header "Update yum"
      yum update
    fi
  fi
}


install() {
  if has "brew"; then
    e_arrow "brew install $*"
    brew install $*
  elif has "apt"; then
    e_arrow "apt install $*"
    apt install -y $*
  elif has "yum"; then
    e_arrow "yum install $*"
    yum install -y $*
  fi
}

e_newline
e_header "Install necessary packages..."

init

install zsh
install tmux
install gawk

