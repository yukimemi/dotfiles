function volt_rm
  __volt_list | read -l line
  and __echo "rm" $line
  and volt rm $line
  commandline -f repaint
end

