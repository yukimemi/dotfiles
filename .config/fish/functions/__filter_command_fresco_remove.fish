function __filter_command_fresco_remove
  fresco list | __filter_command | read -l line
  and __echo "Remove" $line
  and fresco remove $line
end
