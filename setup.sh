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
    ln -sf ${PWD}/${tmux} ${HOME}/.tmux.conf
else
    # screen
    ln -sf ${PWD}/${screen} ${HOME}/.screenrc
fi

#[ ! -d "${HOME}/.oh-my-zsh" ] && git clone git@github.com:yukimemi/oh-my-zsh.git ${HOME}/.oh-my-zsh
#ln -sf ${HOME}/.oh-my-zsh/templates/zshrc.zsh-template ${HOME}/.zshrc
# prezto
[ ! -d "${HOME}/.zprezto" ] && git clone --recursive git@github.com:yukimemi/prezto.git ${HOME}/.zprezto
pushd ${HOME}/.zprezto/runcoms
PREZTO_FILES=( zlogin zlogout zpreztorc zprofile zshenv zshrc )
for file in ${PREZTO_FILES[@]}
do
    ln -sf "${PWD}/${file}" "${ZDOTDIR:-$HOME}/.${file}"
done
popd

# vim
cd vim
VIM_FILE=( .vimrc .gvimrc .vim )
for file in ${VIM_FILE[@]}
do
    ln -sf ${PWD}/${file} ${HOME}/${file}
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

ln -sf ${PWD}/.vimperatorrc ${HOME}/${VIMPERATOR_FILE}

# dotfiles
DOT_FILES=(.vrapperrc .gemrc .bashrc .inputrc .tmuxinator .peco-snippets)
for file in ${DOT_FILES[@]}
do
    ln -sf ${PWD}/${file} ${HOME}/${file}
done

# global gitignore
ln -sf ${PWD}/global-gitignore ${HOME}/.gitignore
git config --global core.excludesfile ${HOME}/.gitignore
# global gitattributes
ln -sf ${PWD}/global-gitattributes ${HOME}/.gitattributes
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

    # iterm2 solalized colorscheme
    [ ! -d ${HOME}/.iterm2-colorscheme ] && mkdir -p ${HOME}/.iterm2-colorscheme
    git clone https://github.com/altercation/solarized.git ${HOME}/.iterm2-colorscheme/solarized
    git clone https://github.com/larssmit/iterm2-getafe.git ${HOME}/.iterm2-colorscheme/getafe
    git clone https://github.com/baskerville/iTerm-2-Color-Themes.git ${HOME}/.iterm2-colorscheme/iTerm-2-Color-Themes

    # KeyRemap4MacBook
    cd mac
    mkdir -p ${HOME}/Library/Application\ Support/KeyRemap4MacBook
    ln -sf ${PWD}/private.xml ${HOME}/Library/Application\ Support/KeyRemap4MacBook/private.xml
    cd ../
fi
#######################################################################

