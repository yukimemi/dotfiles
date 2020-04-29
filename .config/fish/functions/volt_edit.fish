function volt_edit
  __volt_list | read -l line
  and __echo "Edit" $line
  and volt edit $line
  commandline -f repaint
end

