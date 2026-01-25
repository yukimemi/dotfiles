function __filter_command_gsr
  gsr | __filter_command | read -l line
  and __echo "Change directory" $line
  and cd $line
end

