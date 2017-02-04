function __filter_command_rm
  ls | __filter_command | read -l line
  and __echo "Remove" $line
  and rm $line
  commandline -f repaint
end

