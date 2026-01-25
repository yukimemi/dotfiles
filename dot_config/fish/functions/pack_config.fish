function pack_config
  __pack_list | read -l line
  and __echo "Edit" $line
  and pack config $line
  commandline -f repaint
end

