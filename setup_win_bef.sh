#!/bin/bash
git submodule init
git submodule update

# oh-my-zsh
[ ! -d "${HOME}/.oh-my-zsh" ] && git clone git@github.com:yukimemi/oh-my-zsh.git ${HOME}/.oh-my-zsh

# vimperator
VIMPERATOR_DIR="vimperator"
VIMPERATOR_FILE="_vimperatorrc"
cd vimperator
[ ! -d ${HOME}/${VIMPERATOR_DIR}/plugin ] && mkdir -p ${HOME}/${VIMPERATOR_DIR}/plugin
git clone git://github.com/caisui/vimperator.git ${HOME}/${VIMPERATOR_DIR}/caisui
git clone git://gist.github.com/377348.git ${HOME}/${VIMPERATOR_DIR}/377348
git clone git://github.com/vimpr/vimperator-plugins.git ${HOME}/${VIMPERATOR_DIR}/vimperator-plugins
git clone git://github.com/vimpr/vimperator-rc.git ${HOME}/${VIMPERATOR_DIR}/vimperator-rc

# scripts git clone
[ ! -d ${HOME}/bin ] && mkdir ${HOME}/bin
cd ${HOME}/bin
git clone git@bitbucket.org:yukimemi/scripts.git

