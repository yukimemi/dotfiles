function __filter_command_z
  cat ~/.z | while read -l line
    echo $line
  end | __filter_command | read -l dir
  and __echo "Change directory" $dir
  and cd $dir
end

