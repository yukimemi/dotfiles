#!/bin/bash

sudo add-apt-repository ppa:neovim-ppa/stable
sudo apt update
sudo apt install -y python3 python3-pip
sudo apt install -y neovim
pip3 install --upgrade pip
pip3 install neovim

