function __filter_command_tmuxinator
  tmuxinator list -n | __filter_command | read -l line
  and __echo "Change tmuxinator" $line
  and tmuxinator $line
end

