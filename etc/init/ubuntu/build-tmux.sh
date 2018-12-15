#!/bin/bash
sudo apt update
sudo apt install -y build-essential automake libevent-dev ncurses-dev
ghq get https://github.com/tmux/tmux.git
cd ~/.ghq/src/github.com/tmux/tmux && git checkout $(git tag | sort -V | tail -n 1) && sh autogen.sh && ./configure && make
sudo make install

