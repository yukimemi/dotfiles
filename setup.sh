#!/bin/bash
git submodule init
git submodule update


# check ostype
ostype() { echo $OSTYPE | tr '[A-Z]' '[a-z]'; }
SHELL_PLATFORM='unknown'
case "$(ostype)" in
    *'linux'*   ) SHELL_PLATFORM='linux';;
    *'cygwin'*  ) SHELL_PLATFORM='cygwin';;
    *'darwin'*  ) SHELL_PLATFORM='osx';;
    *'bsd'*     ) SHELL_PLATFORM='bsd';;
esac

shell_is_linux() { [[ $SHELL_PLATFORM == 'linux' || $SHELL_PLATFORM == 'bsd' ]]; }
shell_is_osx()   { [[ $SHELL_PLATFORM == 'osx' ]]; }
shell_is_bsd()   { [[ $SHELL_PLATFORM == 'bsd' || $SHELL_PLATFORM == 'osx' ]]; }
shell_is_cygwin() { [[ $SHELL_PLATFORM == 'cygwin' ]]; }

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

[ ! -d "${HOME}/.oh-my-zsh" ] && git clone git@github.com:yukimemi/oh-my-zsh.git ${HOME}/.oh-my-zsh
rm ${HOME}/.zshrc
ln -s ${HOME}/.oh-my-zsh/templates/zshrc.zsh-template ${HOME}/.zshrc

# vim
cd vim
VIM_FILE=( .vimrc .gvimrc .vim )
for file in ${VIM_FILE[@]}
do
    rm ${HOME}/${file}
    ln -s ${PWD}/${file} ${HOME}/${file}
done
cd ../

# vimperator
if shell_is_cygwin ; then
    VIMPERATOR_DIR="vimperator"
    VIMPERATOR_FILE="_vimperatorrc"
else
    VIMPERATOR_DIR=".vimperator"
    VIMPERATOR_FILE=".vimperatorrc"
fi
cd vimperator
[ ! -d ${HOME}/${VIMPERATOR_DIR}/plugin ] && mkdir -p ${HOME}/${VIMPERATOR_DIR}/plugin
git clone git://github.com/caisui/vimperator.git ${HOME}/${VIMPERATOR_DIR}/caisui
git clone git://gist.github.com/377348.git ${HOME}/${VIMPERATOR_DIR}/377348
git clone git://github.com/vimpr/vimperator-plugins.git ${HOME}/${VIMPERATOR_DIR}/vimperator-plugins
git clone git://github.com/vimpr/vimperator-rc.git ${HOME}/${VIMPERATOR_DIR}/vimperator-rc

rm ${HOME}/${VIMPERATOR_FILE}
ln -s ${PWD}/.vimperatorrc ${HOME}/${VIMPERATOR_FILE}

rm ${HOME}/${VIMPERATOR_DIR}/plugin/plugin_loader.js
ln -s ${HOME}/${VIMPERATOR_DIR}/vimperator-plugins/plugin_loader.js ${HOME}/${VIMPERATOR_DIR}/plugin/
rm ${HOME}/${VIMPERATOR_DIR}/colors
ln -s ${HOME}/${VIMPERATOR_DIR}/vimperator-rc/anekos/colors ${HOME}/${VIMPERATOR_DIR}/
cd ../

# dotfiles
DOT_FILES=( .vrapperrc .gemrc .bashrc .inputrc .tmuxinator)
for file in ${DOT_FILES[@]}
do
    rm ${HOME}/${file}
    ln -s ${PWD}/${file} ${HOME}/${file}
done

# global gitignore
rm ${HOME}/.gitignore
ln -s ${PWD}/global-gitignore ${HOME}/.gitignore
git config --global core.excludesfile ${HOME}/.gitignore
# global gitattributes
rm ${HOME}/.gitattributes
ln -s ${PWD}/global-gitattributes ${HOME}/.gitattributes
git config --global core.attributesfile ${HOME}/.gitattributes

# git
git config --global user.name 'yukimemi'
git config --global user.email 'yukimemi@gmail.com'
git config --global github.user 'yukimemi'
if ! shell_is_cygwin ; then
    git config --global push.default simple
fi
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
git config --global core.editor vim
# mergetool
git config --global merge.tool mvimdiff

# scripts git clone
[ ! -d ${HOME}/bin ] && mkdir ${HOME}/bin
cd ${HOME}/bin
git clone git@bitbucket.org:yukimemi/scripts.git
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
    brew install macvim --with-cscope --with-lua --HEAD --override-system-vim
    brew install go --cross-compile-common
    brew linkapps

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
    git clone https://github.com/altercation/solarized.git ${HOME}/.iterm2-colorscheme/solarized
    git clone https://github.com/larssmit/iterm2-getafe.git ${HOME}/.iterm2-colorscheme/getafe
    git clone https://github.com/baskerville/iTerm-2-Color-Themes.git ${HOME}/.iterm2-colorscheme/iTerm-2-Color-Themes

    # KeyRemap4MacBook
    cd mac
    rm ${HOME}/Library/Application\ Support/KeyRemap4MacBook/private.xml
    mkdir -p ${HOME}/Library/Application\ Support/KeyRemap4MacBook
    ln -s ${PWD}/private.xml ${HOME}/Library/Application\ Support/KeyRemap4MacBook/private.xml
    cd ../
fi
#######################################################################

