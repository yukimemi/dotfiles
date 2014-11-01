#!/bin/bash
brew update

brew tap homebrew/dupes || true
brew tap phinze/homebrew-cask || true
brew tap sanemat/font || true

brew install reattach-to-user-namespace
brew install --disable-etcdir zsh
brew install lv
brew install git
brew install git-now
brew install tmux
brew install ssh-copy-id
brew install coreutils
brew install rmtrash
brew install zsh-completions
brew install mosh
brew install nkf
brew install the_silver_searcher
brew install go --cross-compile-common
brew install ghc
brew install cabal-install
brew install --powerline ricty

# for tmux-powerline
brew install homebrew/dupes/grep

# macvim
brew install macvim --with-cscope --with-lua --override-system-vim --HEAD

# macvim-kaoriya
# tap supermomonga/homebrew-splhack
# install cscope
# install lua
# install --HEAD cmigemo-mk
# install --HEAD ctags-objc-ja
# install macvim-kaoriya --HEAD --with-lua --with-cscope

brew install brew-cask
brew cask install google-chrome
brew cask install firefox
brew cask install karabiner
brew cask install caffeine
brew cask install nosleep
brew cask install bettertouchtool
brew cask install iterm2
brew cask install quicksilver
brew cask install dropbox
brew cask install flux
brew cask install flash
brew cask install google-japanese-ime

brew linkapps

