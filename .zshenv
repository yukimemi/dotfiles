# =============================================================================
# File        : zshenv
# Author      : yukimemi
# Last Change : 2017/10/07 17:55:58.
# =============================================================================

# For time. {{{1
# zmodload zsh/zprof && zprof

# Useful functions. {{{1
is_linux() { [[ $SHELL_PLATFORM == 'linux' || $SHELL_PLATFORM == 'bsd' ]]; }
is_osx() { [[ $SHELL_PLATFORM == 'osx' ]]; }
is_bsd() { [[ $SHELL_PLATFORM == 'bsd' || $SHELL_PLATFORM == 'osx' ]]; }
is_cygwin() { [[ $SHELL_PLATFORM == 'cygwin' ]]; }


# Env setting {{{1

# Basic envs. {{{2
export LANG=ja_JP.UTF-8
export LC_CTYPE="ja_JP.UTF-8"
export SHELL=zsh
export EDITOR=nvim
export VISUAL=nvim
export PAGER="less"

# Unique path.
typeset -gU cdpath fpath mailpath path

# Path. {{{2
path=(
  # Home.
  $HOME/bin(N-/)
  $HOME/.local/bin(N-/)
  $HOME/bin/scripts(N-/)
  $HOME/local/bin(N-/)
  # coreutils.
  /usr/local/opt/coreutils/libexec/gnubin(N-/)
  # gnu-sed.
  /usr/local/opt/gnu-sed/libexec/gnubin(N-/)
  # homebrew.
  /usr/local/bin(N-/)
  # cabal.
  $HOME/.cabal/bin(N-/)
  # cargo
  $HOME/.cargo/bin(N-/)
  # normal.
  /usr/bin(N-/)
  /usr/sbin(N-/)
  /bin(N-/)
  /sbin(N-/)

  $path
)

# go. {{{2
export GOPATH=$HOME/.ghq
export GOROOT=$(go env GOROOT)

# rust. {{{2
export RUST_SRC_PATH=~/.multirust/toolchains/$(rustup toolchain list | grep default | awk '{ print $1 }')/lib/rustlib/src/rust/src > /dev/null 2>&1

# npm
export NPM_BIN_DIR=$(npm bin --global) > /dev/null 2>&1
export YARN_BIN_DIR=$(yarn global bin) > /dev/null 2>&1

path=(
  # anyenv
  $HOME/.anyenv/bin(N-/)
  # go.
  $GOPATH/bin(N-/)
  $GOROOT/bin(N-/)
  # yarn
  ${YARN_BIN_DIR}(N-/)
  # npm
  ${NPM_BIN_DIR}(N-/)

  $path
)


# Manpath. {{{2
manpath=(
  # user.
  $HOME/local/share/man(N-/)
  # Homebrew.
  /usr/local/opt/coreutils/libexec/gnuman(N-/)
  # system.
  /usr/local/share/man(N-/)
  /usr/share/man(N-/)

  $manpath
)

# Fpath. {{{2
fpath=(
  /usr/local/share/zsh-completions(N-/)

  $fpath
)

# sudo path. {{{2
typeset -xT SUDO_PATH sudo_path
typeset -gU sudo_path
sudo_path=(
  {,/usr/pkg,/usr/local,/usr}/sbin(N-/)
)

# Other. {{{2
export XDG_CONFIG_HOME="$HOME/.config"

export GSR_SHOW_AHEAD=1
export GSR_SHOW_BEHIND=1

# less settings. {{{2
# export LESS='-gj10 --no-init --quit-if-one-screen --RAW-CONTROL-CHARS'
# export LESSOPEN='| /usr/local/bin/src-hilite-lesspipe.sh %s'

# local conf {{{2
if [ -e ~/.zshrc_private ]; then
  source ~/.zshrc_private
fi


# Compile zshrc. {{{1
if [ ! -f ~/.zshenv.zwc -o ~/.zshenv -nt ~/.zshenv.zwc ]; then
  zcompile ~/.zshenv
fi

# vim:fdm=marker expandtab fdc=3 ft=zsh:

