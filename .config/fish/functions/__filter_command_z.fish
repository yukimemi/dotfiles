function __filter_command_z
  z -lt | awk '{ print $2 }' | __filter_command | read -l line
  and __echo "Change directory" $line
  and cd $line
end

