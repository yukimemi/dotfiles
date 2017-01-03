function __filter_command_z
  z -lr | awk '{ print $2 }' | __filter_command | read -l line
  and echo "
  ------
  Change directory: $line
  ------"
  and cd $line
end

