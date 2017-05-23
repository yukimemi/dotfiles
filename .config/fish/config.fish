### Environment. {{{1
# Basic. {{{2
set -x SHELL fish
set -x EDITOR nvim
set -x VISUAL nvim
set -x PAGER less

# GOPATH. {{{2
set -x GOPATH ~/.ghq

# PATH. {{{2
function __add_fish_user_paths -a addpath
  if test -d $addpath
    set -U fish_user_paths $addpath $fish_user_paths
  end
end

set -U fish_user_paths
__add_fish_user_paths /usr/local/opt/coreutils/libexec/gnubin
__add_fish_user_paths ~/bin/scripts
__add_fish_user_paths $GOPATH/bin
__add_fish_user_paths ~/.cargo/bin
if type -q node; and type -q yarn
  __add_fish_user_paths (yarn global bin)
end

if not test -d ~/.local/bin
  mkdir -p ~/.local/bin
end
__add_fish_user_paths ~/.local/bin

### Util functions. {{{1
# cd and ls. {{{2
function cd
  builtin cd $argv
  ls -a
  __save_directory $PWD &
end

# Judge OS. {{{2
function isMac
  return (test (uname) = "Darwin")
end

function isLinux
  return (test (uname) != "Darwin")
end

# Install func. {{{2
function in
  if type -q brew
    brew $argv
  else if type -q apt-get
    apt-get $argv
  else if type -q yum
    yum $argv
  end
end

function cli_install -a cmd repo
  if not test -d ~/.local/bin
    mkdir -p ~/.local/bin
  end
  if not type -q $cmd
    curl -L git.io/cli | env L=$repo sh
  end
end

# stack new. {{{2
function stacknew -a name
  if test (count $argv) -ne 1
    echo "Set create project name."
  else
    stack new $name -p "author-email:yukimemi@gmail.com" -p "author-name:yukimemi" -p "category:Development" -p "copyright:(c) 2017, yukimemi" -p "github-username:yukimemi"
  end
end


# Enter hook.
function done_enter --on-event fish_postexec
  if test -z "$argv"
    if git rev-parse --is-inside-work-tree > /dev/null ^&1
      echo (set_color yellow)"--- git status ---"(set_color normal)
      git status -sb
    end
  end
end

### prompt. {{{1
# right_prompt for pwd and git.
# function fish_right_prompt
#   prompt_pwd
#   __terlar_git_prompt
# end

### Alias. {{{1
alias cp "cp -v"
alias mv "mv -v"
alias l "ll"
alias rm "gomi"
alias ghc "stack ghc --"
alias ghci "stack ghci"
alias stackexec "stack exec"
alias runghc "stack runghc --"
alias runhaskell "stack runghc --"

### Abbr. {{{1
abbr -a fv __filter_command_nvim
abbr -a fmvim __filter_command_mvim
abbr -a ghl __filter_command_ghq
abbr -a j __filter_command_z
abbr -a r __filter_command_rm
abbr -a rr __filter_command_rm_recurse
abbr -a c __filter_command_cd
abbr -a b bd
abbr -a e nvim
abbr -a v vim
abbr -a o open

# Git. {{{2
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
abbr -a gba 'git branch -a'
abbr -a gbd 'git branch -d'
# pull
abbr -a gp 'git pull --rebase'
# push
abbr -a gpu 'git push'
# status
abbr -a s 'git status'
# show
abbr -a gh 'git show'
# diff
abbr -a d 'git diff'
# rebase
abbr -a gr 'git rebase'
abbr -a gri 'git rebase -i'
# log
abbr -a gl 'git log'
abbr -a glo 'git log --oneline'
abbr -a gk 'git log --graph --pretty'

# vim {{{2
abbr -a dup 'nvim -c "silent! call dein#update() | q"'
abbr -a vdup 'vim -c "silent! call dein#update() | q"'

### Options. {{{1
# Use fish_vi_key_bindings.
set -g fish_key_bindings fish_vi_key_bindings

### Install. {{{1
cli_install ghq motemen/ghq
cli_install gomi b4b4r07/gomi
cli_install jvgrep mattn/jvgrep

### Install plugin manager. {{{1
# fresco.
if not test -f /tmp/__fresco_install.fish
  curl -sfL https://raw.githubusercontent.com/masa0x80/fresco/master/install -o /tmp/__fresco_install.fish
  cat /tmp/__fresco_install.fish | fish
end

# fisherman.
if not type -q fisher
  # curl -Lo ~/.config/fish/functions/fisher.fish --create-dirs git.io/fisher
end

### Plugin settings. {{{1
# pure {{{2
set pure_symbol_prompt "-»"
set pure_color_green (set_color "white")

