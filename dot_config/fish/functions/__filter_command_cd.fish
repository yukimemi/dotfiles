function __filter_command_cd
  fd -t d | __filter_command | read -l line
  and __echo "Change directory" $line
  and cd $line
end

