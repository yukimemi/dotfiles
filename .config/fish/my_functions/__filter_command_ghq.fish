function __filter_command_ghq
  ghq list -p | __filter_command | read -l line
  and __echo "Change directory" $line
  and cd $line
end

