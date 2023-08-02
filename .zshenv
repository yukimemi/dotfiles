# =============================================================================
# File        : zshenv
# Author      : yukimemi
# Last Change : 2023/08/03 00:09:01.
# =============================================================================

# For time.
# zmodload zsh/zprof

# Useful functions.
is_linux() { [[ $SHELL_PLATFORM == 'linux' || $SHELL_PLATFORM == 'bsd' ]]; }
is_osx() { [[ $SHELL_PLATFORM == 'osx' ]]; }
is_bsd() { [[ $SHELL_PLATFORM == 'bsd' || $SHELL_PLATFORM == 'osx' ]]; }
is_cygwin() { [[ $SHELL_PLATFORM == 'cygwin' ]]; }


# Env setting

# Basic envs.
export LANG=ja_JP.UTF-8
export LC_CTYPE="ja_JP.UTF-8"
export SHELL=zsh
[[ -n $EDITOR ]] || export EDITOR=nvim
export VISUAL=nvim
export PAGER=bat

# Unique path.
typeset -gU cdpath fpath mailpath path

# Path.
path=(
  # Home.
  $HOME/bin(N-/)
  $HOME/.local/bin(N-/)
  $HOME/.local/bin/scripts(N-/)
  $HOME/bin/scripts(N-/)
  $HOME/local/bin(N-/)
  # bob-nvim
  $HOME/.local/share/neovim/bin(N-/)
  # cargo
  $HOME/.cargo/bin(N-/)
  # coreutils.
  /usr/local/opt/coreutils/libexec/gnubin(N-/)
  /opt/homebrew/opt/coreutils/libexec/gnubin(N-/)
  # gnu-sed.
  /usr/local/opt/gnu-sed/libexec/gnubin(N-/)
  # homebrew.
  /usr/local/bin(N-/)
  /opt/homebrew/bin(N-/)
  # Rancher desktop.
  $HOME/.rd/bin(N-/)
  # cabal.
  $HOME/.cabal/bin(N-/)
  # yarn.
  $HOME/.yarn/bin(N-/)
  # Poetry.
  $HOME/.poetry/bin(N-/)
  # tpm.
  $HOME/.tmux/plugins/tpm(N-/)
  # normal.
  /usr/bin(N-/)
  /usr/sbin(N-/)
  /bin(N-/)
  /sbin(N-/)

  $path
)

# go.
export GOPATH=$HOME/.go

# rust.
# export RUST_SRC_PATH="$(rustc --print sysroot)/lib/rustlib/src/rust/src" > /dev/null 2>&1

# deno.
export DENO_INSTALL=$HOME/.deno

path=(
  $GOPATH/bin(N-/)
  $DENO_INSTALL/bin(N-/)

  $path
)


# Manpath.
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

# Fpath.
fpath=(
  /usr/local/share/zsh-completions(N-/)
  ${ASDF_DIR}/completions(N-/)
  ${HOME}/.config/zsh/completions(N-/)

  $fpath
)

# sudo path.
typeset -xT SUDO_PATH sudo_path
typeset -gU sudo_path
sudo_path=(
  {,/usr/pkg,/usr/local,/usr}/sbin(N-/)
    )

# Other.
export XDG_CONFIG_HOME="${HOME}/.config"

export GSR_SHOW_AHEAD=1
export GSR_SHOW_BEHIND=1

export VIM_CONFIG_PATH="${HOME}/.config/pack"

export __FILTER_TOOL=fzf

export RRC_CONFIG="${HOME}/.config/rrc/config.toml"

export NEXTWORD_DATA_PATH="${HOME}/.config/nextword/nextword-data-large"

export MOCWORD_DATA="${HOME}/.config/mocword/mocword.sqlite"

# neovide.
export NEOVIDE_MULTIGRID=1

# fzf.
if which fd > /dev/null 2>&1; then
  export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
elif which rg > /dev/null 2>&1; then
  export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --glob "!.git/*"'
fi

# local conf
if [ -e ~/.zshrc_private ]; then
  source ~/.zshrc_private
fi

if [ -e ~/.zshrc_local ]; then
  source ~/.zshrc_local
fi


# Compile zshenv.
if [ ! -f ~/.zshenv.zwc -o ~/.zshenv -nt ~/.zshenv.zwc ]; then
  zcompile ~/.zshenv
fi


