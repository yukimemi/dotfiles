function __save_directory -a dir
  echo $dir >> ~/.z
  tac ~/.z | uq >> ~/.z.tmp
  command mv -f ~/.z.tmp ~/.z

  # cat ~/.z | while read -l line
  #   if test $dir = $line
  #     return
  #   end
  # end
  # echo $dir >> ~/.z
end


