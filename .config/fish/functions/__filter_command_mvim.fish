function __filter_command_mvim
  fd -t f l | __filter_command | read -l line
  and __echo "Edit" $line
  and mvim $line
  commandline -f repaint
end
