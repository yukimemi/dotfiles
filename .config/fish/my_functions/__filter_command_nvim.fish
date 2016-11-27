function __filter_command_nvim
  find . -type f | __filter_command | read -l file
  and echo "
  ------
  Edit file: $file
  ------"
  and nvim $file
  commandline -f repaint
end
