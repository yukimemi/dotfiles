function __filter_command_nvim
  fd -t f | __filter_command | read -l line
  and __echo "Edit" $line
  and nvim $line
  commandline -f repaint
end
