# GOPATH
set -x GOPATH ~/.ghq

# cd > ls.
function cd
  builtin cd $argv
  ls -a
end

# right_prompt for pwd and git.
function fish_right_prompt
  prompt_pwd
  __terlar_git_prompt
end

# Use fish_vi_key_bindings
fish_vi_key_bindings

