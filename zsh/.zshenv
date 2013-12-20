#######################################################################################################
#{{{ env setting
# if not running interactively, don't do anything
[ -z "$PS1" ] && return

# SHELL
export SHELL=zsh

# path setting
typeset -U path
path=(/usr/local/bin(N-/))
path=(
    # windows python
    /cygdrive/c/Python27(N-/)
    /cygdrive/c/Python27/Scripts(N-/)
    /cygdrive/c/work/winscripts/sh(N-/)
    # homebrew
    /usr/local/bin(N-/)
    /opt/boxen/homebrew(N-/)
    # coreutils
    /usr/local/opt/coreutils/libexec/gnubin(N-/)
    /opt/boxen/homebrew/opt/coreutils/libexec/gnubin(N-/)
    # システム用
    /bin(N-/)
    /sbin(N-/)
    /usr/sbin(N-/)
    # ~/bin/
    $HOME/bin(N-/)
    $HOME/bin/scripts(N-/)
    # nodebrew
    $HOME/.nodebrew/current/bin(N-/)
    /cygdrive/c/Program\ Files/nodejs(N-/) # for Cygwin
    # 自分用（--prefix=$HOME/localでインストールしたもの）
    $HOME/local/bin(N-/)
    # 自分用（gem install --user-installでインストールしたもの）
    ## 2012-01-07
    $HOME/.gem/ruby/*/bin(N-/)
    # Debian GNU/Linux用
    /var/lib/gems/*/bin(N-/)
    # MacPorts用
    /opt/local/bin(N-/)
    # Solaris用
    /opt/csw/bin(N-/)
    /usr/sfw/bin(N-/)
    /usr/ccs/bin(N-/)
    # Cygwin用
    /cygdrive/c/meadow/bin(N-/)
    # システム用
    /usr/local/bin(N-/)
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
# sudo時のパスの設定
## -x: export SUDO_PATHも一緒に行う。
## -T: SUDO_PATHとsudo_pathを連動する。
typeset -xT SUDO_PATH sudo_path
## 重複したパスを登録しない。
typeset -U sudo_path
## (N-/): 存在しないディレクトリは登録しない。
## パス(...): ...という条件にマッチするパスのみ残す。
## N: NULL_GLOBオプションを設定。
## globがマッチしなかったり存在しないパスを無視する。
## -: シンボリックリンク先のパスを評価。
## /: ディレクトリのみ残す。
sudo_path=({,/usr/pkg,/usr/local,/usr}/sbin(N-/))

# man用パスの設定
## 重複したパスを登録しない。
typeset -U manpath
## (N-/) 存在しないディレクトリは登録しない。
## パス(...): ...という条件にマッチするパスのみ残す。
## N: NULL_GLOBオプションを設定。
## globがマッチしなかったり存在しないパスを無視する。
## -: シンボリックリンク先のパスを評価。
## /: ディレクトリのみ残す。
manpath=(
    # 自分用
    $HOME/local/share/man(N-/)
    # MacPorts用
    /opt/local/share/man(N-/)
    # Homebrewy用
    /usr/local/opt/coreutils/libexec/gnuman(N-/)
    /opt/boxen/homebrew/opt/coreutils/libexec/gnuman(N-/)
    # Solaris用
    /opt/csw/share/man(N-/)
    /usr/sfw/share/man(N-/)
    # システム用
    /usr/local/share/man(N-/)
    /usr/share/man(N-/)
)

# ページャの設定
if type lv > /dev/null 2>&1; then
    ## lvを優先する。
    export PAGER="lv"
else
    ## lvがなかったらlessを使う。
    export PAGER="less"
fi

# lvの設定
## -c: ANSIエスケープシーケンスの色付けなどを有効にする。
## -l: 1行が長くと折り返されていても1行として扱う。
## （コピーしたときに余計な改行を入れない。）
export LV="-c -l"

if [ "$PAGER" != "lv" ]; then
    ## lvがなくてもlvでページャーを起動する。
    alias lv="$PAGER"
fi

# lessの設定
## -R: ANSIエスケープシーケンスのみ素通しする。
## 2012-09-04
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

# rvm default use
#rvm use 1.9.2-head > /dev/null

# rbenv
[ ! -d $HOME/.rbenv ] && git clone https://github.com/sstephenson/rbenv.git ~/.rbenv
if [ -d $HOME/.rbenv ]; then
    export RBENV_ROOT="$HOME/.rbenv"
    [ ! -d $RBENV_ROOT/plugins/ruby-build ] && git clone https://github.com/sstephenson/ruby-build.git $RBENV_ROOT/plugins/ruby-build
    [ -d "$RBENV_ROOT/completions" ] && source $RBENV_ROOT/completions/rbenv.zsh
    export PATH=$RBENV_ROOT/bin:$PATH
    eval "$(rbenv init -)"
    alias rgem='rbenv exec gem'
    alias bruby='bundle exec ruby'
    alias brake='bundle exec rake'
fi

# pythonbrew
if [ -s "$HOME/.pythonbrew/etc/bashrc" ]; then
    source "$HOME/.pythonbrew/etc/bashrc"
    # exec command like virtualenvwrapper
    alias mkvirtualenv="pythonbrew venv create"
    alias rmvirtualenv="pythonbrew venv delete"
    alias workon="pythonbrew venv use"
fi
# pythonz
if [ -s $HOME/.pythonz/etc/bashrc ]; then
    source $HOME/.pythonz/etc/bashrc
    # use python 3.3.0
    if [ -d "$HOME/.pythonz/pythons/CPython-3.3.0/bin" ]; then
        export PATH=$HOME/.pythonz/pythons/CPython-3.3.0/bin:$PATH
        export VIRTUALENVWRAPPER_PYTHON=$HOME/.pythonz/pythons/CPython-3.3.0/bin/python
        export VIRTUALENVWRAPPER_VIRTUALENV=$HOME/.pythonz/pythons/CPython-3.3.0/bin/virtualenv
        export WORKON_HOME=$HOME/.virtualenvs
        source $HOME/.pythonz/pythons/CPython-3.3.0/bin/virtualenvwrapper.sh
    fi
fi
#if [ $OSTYPE = cygwin ]; then
#    export VIRTUALENVWRAPPER_PYTHON=/bin/python
#    export VIRTUALENVWRAPPER_VIRTUALENV=/bin/virtualenv
#    export WORKON_HOME=$HOME/.virtualenvs
#    source /bin/virtualenvwrapper.sh
#fi

# pyenv
[ ! -d $HOME/.pyenv ] && git clone git://github.com/yyuu/pyenv.git ~/.pyenv
if [ -d $HOME/.pyenv ]; then
    export PYENV_ROOT="$HOME/.pyenv"
    [ ! -d $PYENV_ROOT/plugins/pyenv-virtualenv ] && git clone git://github.com/yyuu/pyenv-virtualenv.git $PYENV_ROOT/plugins/pyenv-virtualenv
    export PATH=$PYENV_ROOT/bin:$PATH
    eval "$(pyenv init -)"
fi

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

# autojump
# http://blog.glidenote.com/blog/2012/02/29/autojump-zsh/
#[ -s `brew --prefix`/etc/autojump.sh ] && . `brew --prefix`/etc/autojump.sh

# CLASSPATHの中で重複するものを削除
typeset -U CLASSPATH
# mac環境
if [ `uname` = "Darwin" ]; then
    # JAVA_HOME
    export JAVA_HOME=$(/usr/libexec/java_home)
    # CATALINA_HOME
    export CATALINA_HOME="/usr/local/Cellar/tomcat/7.0.14/libexec"
    # Java クラスパス
    #export CLASSPATH="$CLASSPATH:$JAVA_HOME:$JAVA_HOME/lib:$JAVA_HOME/lib/ext"
fi

# Javaの文字化け対策
export JAVA_OPTS='-Dfile.encoding=UTF-8'

# fpathの中で重複するものを削除
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
