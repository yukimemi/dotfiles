function __filter_command_trash
  ls -a | __filter_command | read -l line
  and __echo "Remove" $line
  and trash $line
  commandline -f repaint
end

