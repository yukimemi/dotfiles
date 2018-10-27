function de
  docker run --rm -it -v $PWD:/root/(basename $PWD) -w /root/(basename $PWD) yukimemi/neovim $argv
end
