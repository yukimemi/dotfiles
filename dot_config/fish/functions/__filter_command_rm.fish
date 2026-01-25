function __filter_command_rm
  ls -a | __filter_command | read -l line
  and __echo "Remove" $line
  and rm -rf $line
  commandline -f repaint
end

