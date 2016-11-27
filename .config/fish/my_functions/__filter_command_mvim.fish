function __filter_command_mvim
  find . -type f | __filter_command | read -l file
  and echo "
  ------
  Edit file: $file
  ------"
  and mvim $file
  commandline -f repaint
end
