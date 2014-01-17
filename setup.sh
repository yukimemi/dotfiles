#!/bin/bash
git submodule init
git submodule update


# check ostype
ostype() { echo $OSTYPE | tr '[A-Z]' '[a-z]'; }
SHELL_PLATFORM='unknown'
case "$(ostype)" in
    *'linux'*   ) SHELL_PLATFORM='linux';;
    *'darwin'*  ) SHELL_PLATFORM='osx';;
    *'bsd'*     ) SHELL_PLATFORM='bsd';;
esac

shell_is_linux() { [[ $SHELL_PLATFORM == 'linux' || $SHELL_PLATFORM == 'bsd' ]]; }
shell_is_osx()   { [[ $SHELL_PLATFORM == 'osx' ]]; }
shell_is_bsd()   { [[ $SHELL_PLATFORM == 'bsd' || $SHELL_PLATFORM == 'osx' ]]; }

############################## for Linux ##############################
if shell_is_linux ; then
    if which yum > /dev/null 2>&1 ; then
        apget=yum
    else
        apget=apt-get
    fi

    eval sudo $apget install git
    eval sudo $apget install zsh
    eval sudo $apget install tmux
fi
#######################################################################


# tmux or screen
echo "local? , server? , linux?, or windows?"
echo "l, s, x, or w"
read lsxw
while :
do
    if [ "${lsxw}" = "l" ]; then
        tmux=".tmux.conf"
        break
    elif [ "${lsxw}" = "s" ]; then
        tmux=".tmux.conf_server"
        break
    elif [ "${lsxw}" = "x" ]; then
        tmux=".tmux.conf_linux"
        break
    elif [ "${lsxw}" = "w" ]; then
        screen=".screenrc_win"
        break
    else
        echo "Press l ,s ,x or w"
        read lsxw
    fi
done
# tmux
if [ ${tmux} != "" ]; then
    rm ${HOME}/.tmux.conf
    ln -s ${PWD}/${tmux} ${HOME}/.tmux.conf
else
    # screen
    rm ${HOME}/.screenrc
    ln -s ${PWD}/${screen} ${HOME}/.screenrc
fi

# zsh
cd zsh
ZSH_FILE=( .zshenv )
for file in ${ZSH_FILE[@]}
do
    rm ${HOME}/${file}
    ln -s ${PWD}/${file} ${HOME}/${file}
done
cd ../

[ ! -d "${HOME}/.oh-my-zsh" ] && git clone git@github.com:yuyunko/oh-my-zsh.git ~/.oh-my-zsh
rm ${HOME}/.zshrc
ln -s ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc

# vim
cd vim
VIM_FILE=( .vimrc .gvimrc .vim )
for file in ${VIM_FILE[@]}
do
    rm ${HOME}/${file}
    ln -s ${PWD}/${file} ${HOME}/${file}
done
cd ../

if [ ! -d vim/.vim/back ]; then
    mkdir -p vim/.vim/back
fi

# vimperator
cd vimperator
[ ! -d ${HOME}/.vimperator/plugin ] && mkdir -p ${HOME}/.vimperator/plugin
git clone git://github.com/caisui/vimperator.git ${HOME}/.vimperator/caisui
git clone git://gist.github.com/377348.git ${HOME}/.vimperator/377348
git clone git://github.com/vimpr/vimperator-plugins.git ${HOME}/.vimperator/vimperator-plugins
git clone git://github.com/vimpr/vimperator-rc.git ${HOME}/.vimperator/vimperator-rc

rm ${HOME}/.vimperatorrc
ln -s ${PWD}/.vimperatorrc ${HOME}/

rm ${HOME}/.vimperator/plugin/plugin_loader.js
ln -s ${HOME}/.vimperator/vimperator-plugins/plugin_loader.js ${HOME}/.vimperator/plugin/
rm ${HOME}/.vimperator/colors
ln -s ${HOME}/.vimperator/vimperator-rc/anekos/colors ${HOME}/.vimperator/
cd ../

# dotfiles
DOT_FILES=( .vrapperrc .gemrc)
for file in ${DOT_FILES[@]}
do
    rm ${HOME}/${file}
    ln -s ${PWD}/${file} ${HOME}/${file}
done

# global gitignore
rm ${HOME}/.gitignore
ln -s ${PWD}/global-gitignore ${HOME}/.gitignore
git config --global core.excludesfile ~/.gitignore

# git
git config --global user.name 'yuyunko'
git config --global user.email 'i.xxxxxxxxxxxxx.13@gmail.com'
git config --global github.user 'yuyunko'
git config --global push.default simple
git config --global color.diff auto
# alias
git config --global alias.ci commit
git config --global alias.co checkout
git config --global alias.st status
git config --global alias.a add
git config --global alias.br branch
git config --global alias.di diff
git config --global alias.k 'log --graph --pretty'
# editor
if shell_is_osx ; then
    git config --global core.editor /Applications/MacVim.app/Contents/MacOS/Vim
else
    git config --global core.editor vim
fi

# scripts git clone
[ ! -d ${HOME}/bin ] && mkdir ${HOME}/bin
cd ${HOME}/bin
git clone git@bitbucket.org:yuyunko/scripts.git
cd -

############################## for OS X ##############################
if shell_is_osx ; then
    # install homebrew
    ruby -e "$(curl -fsSL https://raw.github.com/mxcl/homebrew/go/install)"
    brew install reattach-to-user-namespace
    brew install --disable-etcdir zsh
    brew install lv
    brew install git
    brew install git-now
    brew install tmux
    brew install readline
    brew install openssl
    brew install coreutils
    brew install rmtrash
    brew install cmatrix
    brew install zsh-completions
    brew install mosh
    brew install nkf
    brew install the_silver_searcher
    #brew install rbenv ruby-build rbenv-gemset rbenv-binstubs
    brew install macvim --with-cscope --with-lua --HEAD
    brew install go --cross-compile-common
    ln -s /usr/local/Cellar/macvim/HEAD/MacVim.app /Applications

    brew tap homebrew/dupes
    brew install grep    # GNU grep necessary for tmux-powerline

    brew tap phinze/homebrew-cask
    brew install brew-cask
    brew cask install google-chrome
    brew cask install firefox
    brew cask install right-zoom
    brew cask install appcleaner
    brew cask install keyremap4macbook
    brew cask install caffeine
    brew cask install bettertouchtool
    brew cask install xld
    brew cask install iterm2
    brew cask install quicksilver
    brew cask install dropbox
    brew cask install mplayerx
    brew cask install f-lux

    # iterm2 solalized colorscheme
    [ ! -d ${HOME}/.iterm2-colorscheme ] && mkdir -p ${HOME}/.iterm2-colorscheme
    git clone https://github.com/altercation/solarized.git ~/.iterm2-colorscheme/solarized
    git clone https://github.com/larssmit/iterm2-getafe.git ~/.iterm2-colorscheme/getafe
    git clone https://github.com/baskerville/iTerm-2-Color-Themes.git ~/.iterm2-colorscheme/iTerm-2-Color-Themes

    # KeyRemap4MacBook
    cd mac
    rm ${HOME}/Library/Application\ Support/KeyRemap4MacBook/private.xml
    mkdir -p ${HOME}/Library/Application\ Support/KeyRemap4MacBook
    ln -s ${PWD}/private.xml ${HOME}/Library/Application\ Support/KeyRemap4MacBook/private.xml
    cd ../
fi
#######################################################################

