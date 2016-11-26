function __filter_command_execute
  __filter_command | read -l line
  and echo "
  ------
  Running command: $line
  ------"
  and eval $line
  commandline -f repaint
end

