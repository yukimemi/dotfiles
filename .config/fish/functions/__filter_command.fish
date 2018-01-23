function __filter_command
  if type -q sk
    sk
  else if type -q fzf-tmux
    fzf-tmux
  else if type -q fzf
    fzf
  else if type -q fzy
    fzy -l 200
  else if type -q peco
    peco
  else
    echo "Filter command not found ! Please install sk/fzf/fzy/peco."
    return 1
  end
end

