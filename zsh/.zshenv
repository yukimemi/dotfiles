#######################################################################################################
#{{{ env setting
# if not running interactively, don't do anything
[ -z "$PS1" ] && return

# SHELL
export SHELL=zsh

# path setting
typeset -U path
path=(
    # homebrew
    /usr/local/bin(N-/)
    /opt/boxen/homebrew(N-/)
    # coreutils
    /usr/local/opt/coreutils/libexec/gnubin(N-/)
    /opt/boxen/homebrew/opt/coreutils/libexec/gnubin(N-/)
    # system
    /bin(N-/)
    /sbin(N-/)
    /usr/sbin(N-/)
    # ~/bin/
    $HOME/bin(N-/)
    $HOME/bin/scripts(N-/)
    /cygdrive/c/Program\ Files/nodejs(N-/) # for Cygwin
    $HOME/local/bin(N-/)
    $HOME/.gem/ruby/*/bin(N-/)
    # Debian GNU/Linux
    /var/lib/gems/*/bin(N-/)
    # MacPorts
    /opt/local/bin(N-/)
    # Solaris
    /opt/csw/bin(N-/)
    /usr/sfw/bin(N-/)
    /usr/ccs/bin(N-/)
    # Cygwin
    /cygdrive/c/meadow/bin(N-/)
    /usr/bin(N-/)
    /usr/games(N-/)
    # pip
    /usr/local/share/python(N-/)
    # cabal
    $HOME/.cabal/bin(N-/)
    # go
    $GOROOT/bin(N-/)
    $GOPATH/bin(N-/)
    # java for cygwin
    /cygdrive/c/Program\ Files/Java/jdk1.7.0_21/bin(N-/)
)
# for Cygwin
if which cygpath > /dev/null; then
    export PATH=$PATH:$(/bin/cygpath $APPDATA)/npm/
fi
typeset -xT SUDO_PATH sudo_path
typeset -U sudo_path
sudo_path=({,/usr/pkg,/usr/local,/usr}/sbin(N-/))

# man
typeset -U manpath
manpath=(
    # user
    $HOME/local/share/man(N-/)
    # MacPorts
    /opt/local/share/man(N-/)
    # Homebrewy
    /usr/local/opt/coreutils/libexec/gnuman(N-/)
    /opt/boxen/homebrew/opt/coreutils/libexec/gnuman(N-/)
    # Solaris
    /opt/csw/share/man(N-/)
    /usr/sfw/share/man(N-/)
    # system
    /usr/local/share/man(N-/)
    /usr/share/man(N-/)
)

# PAGER
if type lv > /dev/null 2>&1; then
    ## use lv if exist
    export PAGER="lv"
else
    export PAGER="less"
fi

# lv setting
export LV="-c -l"

if [ "$PAGER" != "lv" ]; then
    alias lv="$PAGER"
fi

# less setting
export LESS="-R"

# EDITOR
if [ -f "/Applications/MacVim.app/Contents/MacOS/Vim" ]; then
    export EDITOR="/Applications/MacVim.app/Contents/MacOS/Vim"
else
    export EDITOR=vim
fi

# bashmarks.sh
[ -e "$HOME/.local/bin/bashmarks.sh" ] && source ~/.local/bin/bashmarks.sh

# This loads RVM into a shell session.
[ -s "${HOME}/.rvm/scripts/rvm" ] && source "${HOME}/.rvm/scripts/rvm"

# Haxe
if which brew > /dev/null; then
    [ -d "$(brew --prefix)/share/haxe/std" ] && export HAXE_LIBRARY_PATH="$(brew --prefix)/share/haxe/std"
fi

# anyenv
[ ! -d $HOME/.anyenv ] && git clone https://github.com/riywo/anyenv ~/.anyenv
export PATH=$HOME/.anyenv/bin:$PATH
eval "$(anyenv init -)"
[ ! -d $HOME/.anyenv/plugins ] && mkdir -p $HOME/.anyenv/plugins
[ ! -d $HOME/.anyenv/plugins/anyenv-update ] && git clone https://github.com/znz/anyenv-update.git ~/.anyenv/plugins/anyenv-update
# pyenv plugins
[ -d $HOME/.anyenv/envs/pyenv ] && [ ! -d $HOME/.anyenv/envs/pyenv/plugins/pyenv-virtualenv ] && git clone https://github.com/yyuu/pyenv-virtualenv.git ~/.anyenv/envs/pyenv/plugins/pyenv-virtualenv
# rbenv plugins
[ -d $HOME/.anyenv/envs/rbenv ] && [ ! -d $HOME/.anyenv/envs/rbenv/plugins/rbenv-binstubs ] && git clone git://github.com/ianheggie/rbenv-binstubs.git ~/.anyenv/envs/rbenv/plugins/rbenv-binstubs

# lein
[ ! -s $HOME/bin/lein ] && curl https://raw.github.com/technomancy/leiningen/stable/bin/lein -o ~/bin/lein && chmod +x ~/bin/lein
export LEIN_JVM_OPTS="-Djline.terminal=jline.UnixTerminal"

# screeninator
#[ -s "$HOME/.rbenv/shims/screeninator" ] && source "$HOME/.rbenv/shims/screeninator"

# tmuxinator
[ -s $HOME/.tmuxinator/scripts/tmuxinator ] && source $HOME/.tmuxinator/scripts/tmuxinator

# hub
if which hub > /dev/null; then
    eval "$(hub alias -s)"
fi

# CLASSPATH
typeset -U CLASSPATH
# mac
if [ `uname` = "Darwin" ]; then
    # JAVA_HOME
    export JAVA_HOME=$(/usr/libexec/java_home)
    # CATALINA_HOME
    export CATALINA_HOME="/usr/local/Cellar/tomcat/7.0.14/libexec"
    # Java
    #export CLASSPATH="$CLASSPATH:$JAVA_HOME:$JAVA_HOME/lib:$JAVA_HOME/lib/ext"
fi

# Java encoding
export JAVA_OPTS='-Dfile.encoding=UTF-8'

# fpath
typeset -U fpath
fpath=(/usr/local/share/zsh-completions(N-/) $fpath)

# boxen
[ -f /opt/boxen/env.sh ] && source /opt/boxen/env.sh

# go
export GOPATH=$HOME/.go
[ ! -d $HOME/.go ] && mkdir $HOME/.go
if which go > /dev/null; then
    export GOROOT=$(go env | grep GOROOT | cut -d = -f 2 | sed 's/"//g')
    [ ! -d $GOPATH/src/github.com/nsf ] && go get github.com/nsf/gocode
    [ ! -d $GOPATH/src/github.com/golang ] && go get github.com/golang/lint
fi
#}}}
#######################################################################################################
