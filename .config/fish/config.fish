### Environment. {{{1
# Basic. {{{2
set -x SHELL fish
set -x EDITOR nvim
set -x VISUAL nvim
set -x PAGER less

set -x LANG ja_JP.UTF-8
set -x LC_TYPE ja_JP.UTF-8

# less. {{{2
set -x LESS "-iMR"

# GOPATH. {{{2
set -x GOPATH ~/.go

# Rust. {{{2
if type -q rustc
  set -x RUST_SRC_PATH (rustc --print sysroot)/lib/rustlib/src/rust/src >/dev/null 2>&1
end
set -x RUST_LOG info

# GSR. {{{2
set -x GSR_SHOW_AHEAD 1
set -x GSR_SHOW_BEHIND 1
set -x FZF_DEFAULT_OPTS "--no-sort"

# pack
set -x VIM_CONFIG_PATH "$HOME/.config/pack"

# nextword. {{{2
set -x NEXTWORD_DATA_PATH "$HOME/.config/nextword/nextword-data-large"

# volt. {{{2
set -x VOLTPATH ~/.volt

# Deno. {{{2
set -x DENO_INSTALL "$HOME/.deno"

# jethrokuan/fzf. {{{2
set -U FZF_LEGACY_KEYBINDINGS 0
set -U FZF_TMUX 0
set -U FZF_ENABLE_OPEN_PREVIEW 1
set -U FZF_COMPLETE 1

# rrc. {{{2
set -x RRC_CONFIG "$HOME/.config/rrc/config.toml"

# PATH. {{{2
if not test -d ~/.local/bin
  mkdir -p ~/.local/bin
end

__add_fish_user_paths /usr/local/bin
__add_fish_user_paths /usr/local/opt/coreutils/libexec/gnubin
__add_fish_user_paths /usr/local/opt/gnu-sed/libexec/gnubin
__add_fish_user_paths /home/linuxbrew/.linuxbrew/bin
__add_fish_user_paths ~/.cargo/bin
__add_fish_user_paths ~/.yarn/bin
__add_fish_user_paths ~/.linuxbrew/bin
__add_fish_user_paths ~/.yarn/bin
__add_fish_user_paths ~/.config/yarn/global/node_modules/.bin
__add_fish_user_paths ~/.local/bin
__add_fish_user_paths ~/.local/bin/scripts
__add_fish_user_paths ~/.local/google-cloud-sdk/bin
__add_fish_user_paths ~/.ghq/src/bitbucket.org/yukimemi/scripts
__add_fish_user_paths $GOPATH/bin
__add_fish_user_paths ~/.anyenv/bin
__add_fish_user_paths $DENO_INSTALL/bin

# MANPATH. {{{2
set MANPATH /usr/local/opt/coreutils/libexec/gnuman $MANPATH
set MANPATH /usr/local/opt/gnu-sed/libexec/gnuman $MANPATH

### Util functions. {{{1
# function fish_right_prompt
# __nodenv_version
# __goenv_version
# __pyenv_version
# __rbenv_version
# end

### Alias. {{{1
if type -q lsd
  alias ls 'lsd'
else if type -q exa
  alias ls 'exa'
end
if type -q bat
  # alias cat 'bat'
  abbr -a cat bat
end
alias cp "cp -v"
alias mv "mv -v"
alias ll "ls -l"
alias la "ls -la"
alias l "ll"
alias ghc "stack ghc --"
alias ghci "stack ghci"
alias stackexec "stack exec"
alias runghc "stack runghc --"
alias runhaskell "stack runghc --"

# chrome. {{{2
alias twitter "open -na 'Google Chrome' --args '--app=https://mobile.twitter.com'"
alias tweetdeck "open -na 'Google Chrome' --args '--app=https://tweetdeck.com'"
alias hangout "open -na open -na 'Google Chrome' --args '--app=https://hangouts.google.com/'"
alias misskey "open -na 'Google Chrome' --args '--app=https://misskey.io'"

# docker. {{{2
# alias gcloud-auth "docker run -ti --name gcloud-config google/cloud-sdk gcloud auth login"
# alias gcloud "docker run --rm -ti --volumes-from gcloud-config google/cloud-sdk gcloud"

### Abbr. {{{1
abbr -a fv __filter_command_nvim
abbr -a fmvim __filter_command_mvim
abbr -a ghl __filter_command_ghq
abbr -a rhl __filter_command_rhq
abbr -a gsrl __filter_command_gsr
if type -q zoxide
  abbr -a j zi
else
  abbr -a j __filter_command_z
end
if type -q trash
  abbr -a rm trash
  abbr -a r __filter_command_trash
else if type -q gomi
  abbr -a rm gomi
  abbr -a r __filter_command_gomi
else
  abbr -a r __filter_command_rm
end
abbr -a rr __filter_command_rm_recurse
abbr -a c __filter_command_cd
abbr -a fr __filter_command_fresco_remove
abbr -a tl __filter_command_tmux
abbr -a tm __filter_command_tmuxinator
abbr -a b bd
abbr -a t exit
abbr -a e nvim
abbr -a v vim
abbr -a o open
if type -q lsd
  abbr -a tree 'lsd --tree'
else if type -q exa
  abbr -a tree 'exa -T'
end
abbr -a et 'exiftool -api largefilesupport=1'

abbr -a rs 'rsync -av8 --progress'
abbr -a his "history --show-time='%Y-%m-%d %H:%M:%S '"

# Git. {{{2
abbr -a g 'git'
# checkout
abbr -a gco 'git checkout'
abbr -a gcot 'git checkout --theirs'
abbr -a co __filter_command_git_select_branch
# add
abbr -a a 'git add'
# commit
abbr -a gci 'git commit -v'
# branch
abbr -a gb 'git branch'
abbr -a gr 'cd (git rev-parse --show-cdup)'
abbr -a gba 'git branch -a'
abbr -a gbd 'git branch -d'
# pull
abbr -a gp 'git pull --rebase'
# push
abbr -a gpu 'git push'
# status
abbr -a s 'git status'
# show
abbr -a h 'git show'
# diff
abbr -a d 'git diff'
# rebase
# abbr -a gr 'git rebase'
abbr -a gri 'git rebase -i'
# log
abbr -a gl 'git log'
abbr -a glo 'git log --oneline'
abbr -a gk 'git log --graph --pretty'

# vim {{{2
abbr -a mup 'nvim -c "silent! PackClean | PackUpdate | q"'
abbr -a mvup 'vim -c "silent! PackClean | PackUpdate | q"'
abbr -a dup 'nvim -c "silent! call dein#update() | q"'
abbr -a dvup 'vim -c "silent! call dein#update() | q"'


# Chrome {{{2
abbr -a chromeapp "open -na 'Google Chrome' --args '--app=https://"

# youtube-dl {{{2
abbr -a yt "youtube-dl -i"
abbr -a ytd "youtube-dl -i --download-archive ./.downloaded"
abbr -a ytM "youtube-dl -ix --no-post-overwrites --download-archive ./.downloaded --audio-format mp3"
abbr -a ytm "youtube-dl -ix --no-post-overwrites --download-archive ./.downloaded"

# docker {{{2
abbr -a de "docker run --rm -it -v $PWD:/root/(basename $PWD) -w /root/(basename $PWD) yukimemi/neovim"
abbr -a dnu "docker run --rm -it quay.io/nushell/nu:latest"

# exiftool {{{2
abbr -a exiftime 'exiftool -time:all -a -s'


### Options. {{{1
# Use fish_vi_key_bindings.
set -g fish_key_bindings fish_vi_key_bindings

### Install plugin manager. {{{1
# fisherman.
if not functions -q fisher
  set -q XDG_CONFIG_HOME; or set XDG_CONFIG_HOME ~/.config
  curl https://git.io/fisher --create-dirs -sLo $XDG_CONFIG_HOME/fish/functions/fisher.fish
  fish -c fisher
end

# load local config. {{{1
if test -f ~/.config_local.fish
  source ~/.config_local.fish
end

### Plugin settings. {{{1
# spacefish {{{2
set SPACEFISH_CHAR_SYMBOL "→ "

# fish-global-abbreviation. {{{2
# https://qiita.com/ryotako/items/83812c2a703b965a02d9
set -U gabbr_config ~/.config/fish/.gabbr.config

# Load anyenv. {{{1
if type -q anyenv
  status --is-interactive; and source (anyenv init -|psub)
end

# Load asdf. {{{1
if not test -d ~/.asdf
  git clone https://github.com/asdf-vm/asdf.git ~/.asdf
  cd ~/.asdf
  git checkout (git describe --abbrev=0 --tags)
end

source ~/.asdf/asdf.fish

# Load direnv. {{{1
if type -q direnv
  eval (direnv hook fish)
end

# Load starship. {{{1
if type -q starship
  starship init fish | source
end

# Load zoxide. {{{1
if type -q zoxide
  zoxide init fish | source
end

# Google cloud sdk
if test -f /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.fish.inc
  source /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.fish.inc
  abbr -a gc 'gcloud'
end
