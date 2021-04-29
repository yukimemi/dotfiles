function __filter_command_tmux
  tmux list-sessions | __filter_command | read -l line
  and set -l ses (string split ":" $line)[1]
  and __echo "Change tmux sessions" $ses
  and tmux switch -t $ses
end

