function __filter_command_tmux

  set lines
  tmux list-sessions | while read -l line
    set lines line
  end

  if not string length -q -- $lines
    tmux -u a || tmux -u
    return
  end

  tmux list-sessions | __filter_command | read -l line
  and set -l ses (string split ":" $line)[1]
  and __echo "Change tmux sessions" $ses
  and if not string length -q -- $TMUX
    tmux attach -t $ses
  else
    tmux switch -t $ses
  end
end

