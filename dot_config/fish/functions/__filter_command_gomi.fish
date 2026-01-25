function __filter_command_gomi
  ls -a | __filter_command | read -l line
  and __echo "Remove" $line
  and gomi $line
  commandline -f repaint
end

