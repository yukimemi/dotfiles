function __save_directory -a dir
  echo $dir >> ~/.z
  if type -q uq
    tac ~/.z | uq | tac >> ~/.z.tmp
  else
    tac ~/.z | awk '!a[$0]++' | tac >> ~/.z.tmp
  end

  command mv -f ~/.z.tmp ~/.z
end


