function __filter_command
  if which fzf > /dev/null
    fzf
  else if which fzy > /dev/null
    fzy -l 200
  else if which peco > /dev/null
    peco
  else
    echo "Filter command not found ! Please install fzf/fzy/peco."
    return 1
  end
end

