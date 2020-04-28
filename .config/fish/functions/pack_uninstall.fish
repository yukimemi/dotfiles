function pack_uninstall
  __pack_list | read -l line
  and __echo "Uninstall" $line
  and pack uninstall $line
  commandline -f repaint
end

