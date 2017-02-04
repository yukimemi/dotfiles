function __filter_command_kill
  ps -ef | __filter_command | read -l line
  and __echo "KILL" $line
  and kill -9 (echo $line | awk '{ print $2 }')
  commandline -f repaint
end

