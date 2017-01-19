### Load my_functions. {{{1
for func in ~/.config/fish/my_functions/*.fish
  source $func
end

### Environment. {{{1
# Basic. {{{2
set -x SHELL fish
set -x EDITOR nvim
set -x VISUAL nvim
set -x PAGER less

# GOPATH. {{{2
set -x GOPATH ~/.ghq

# PATH. {{{2
set -U fish_user_paths ~/bin
set -U fish_user_paths ~/bin/scripts $fish_user_paths
set -U fish_user_paths $GOPATH/bin $fish_user_paths
set -U fish_user_paths /usr/local/opt/coreutils/libexec/gnubin $fish_user_paths
set -U fish_user_paths (yarn global bin) $fish_user_paths

### Util functions. {{{1
# cd and ls. {{{2
function cd
  builtin cd $argv
  ls -a
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
  if which brew > /dev/null
    brew $argv
  else if which apt-get > /dev/null
    apt-get $argv
  else if which yum > /dev/null
    yum $argv
  end
end


### prompt. {{{1
# right_prompt for pwd and git.
function fish_right_prompt
  prompt_pwd
  __terlar_git_prompt
end

### Alias. {{{1
alias cp "cp -v"
alias mv "mv -v"
alias rm "gomi"

### Abbr. {{{1
abbr -a v __filter_command_nvim
abbr -a fmvim __filter_command_mvim
abbr -a ghl __filter_command_ghq
abbr -a j __filter_command_z
abbr -a r __filter_command_rm
abbr -a co __filter_command_git_select_branch
abbr -a gb 'git branch'
abbr -a gp 'git pull --rebase'
abbr -a gs 'git status'
abbr -a gh 'git show'
abbr -a gd 'git diff'
abbr -a gk 'git log --graph --pretty'
abbr -a dup 'nvim -c "silent! call dein#update() | q"'
abbr -a vdup 'vim -c "silent! call dein#update() | q"'

### Options. {{{1
# Use fish_vi_key_bindings.
set -g fish_key_bindings fish_vi_key_bindings

### Install. {{{1
# Check go


