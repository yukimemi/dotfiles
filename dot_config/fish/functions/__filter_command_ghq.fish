function __filter_command_ghq
  # gsr --all | __filter_command | read -l line
  ghq list -p | __filter_command | read -l line
  and __echo "Change directory" $line
  and cd $line
end

