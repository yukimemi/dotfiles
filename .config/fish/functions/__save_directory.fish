function __save_directory -a dir
  cat ~/.z | while read -l line
    if test $dir = $line
      return
    end
  end
  echo $dir >> ~/.z
end


