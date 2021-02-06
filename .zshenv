# =============================================================================
# File        : zshenv
# Author      : yukimemi
# Last Change : 2021/02/06 14:07:22.
# =============================================================================

# For time. {{{1
# zmodload zsh/zprof

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
export PAGER=bat

# Unique path.
typeset -gU cdpath fpath mailpath path

# Path. {{{2
path=(
  # Home.
  $HOME/bin(N-/)
  $HOME/.local/bin(N-/)
  $HOME/.local/bin/scripts(N-/)
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
  # yarn
  $HOME/.yarn/bin(N-/)

  $path
)

# go. {{{2
export GOPATH=$HOME/.go

# rust. {{{2
# export RUST_SRC_PATH="$(rustc --print sysroot)/lib/rustlib/src/rust/src" > /dev/null 2>&1

path=(
  $GOPATH/bin(N-/)

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
  ${ASDF_DIR}/completions(N-/)
  ${HOME}/.config/zsh/completions(N-/)

  $fpath
)

# sudo path. {{{2
typeset -xT SUDO_PATH sudo_path
typeset -gU sudo_path
sudo_path=(
  {,/usr/pkg,/usr/local,/usr}/sbin(N-/)
    )

# Other. {{{2
export XDG_CONFIG_HOME="${HOME}/.config"

export GSR_SHOW_AHEAD=1
export GSR_SHOW_BEHIND=1

export VIM_CONFIG_PATH="${HOME}/.config/pack"

export __FILTER_TOOL=sk

export RRC_CONFIG="${HOME}/.config/rrc/config.toml"

export NEXTWORD_DATA_PATH="${HOME}/.config/nextword/nextword-data-large"

# fzf. {{{2
if which fd > /dev/null 2>&1; then
  export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
elif which rg > /dev/null 2>&1; then
  export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --glob "!.git/*"'
fi


# local conf {{{2
if [ -e ~/.zshrc_private ]; then
  source ~/.zshrc_private
fi

if [ -e ~/.zshrc_local ]; then
  source ~/.zshrc_local
fi


# Compile zshenv. {{{1
# if [ ! -f ~/.zshenv.zwc -o ~/.zshenv -nt ~/.zshenv.zwc ]; then
#   zcompile ~/.zshenv
# fi

# vim:fdm=marker expandtab fdc=3 ft=zsh:

