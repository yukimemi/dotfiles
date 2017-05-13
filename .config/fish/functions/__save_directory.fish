function __save_directory -a dir
  command mv ~/.z ~/.z_tmp
  cat ~/.z_tmp | while read -l line
    if test $dir != $line
      echo $line >> ~/.z
    end
  end
  echo $dir >> ~/.z
  command rm ~/.z_tmp
end

