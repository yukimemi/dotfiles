function de
  docker run --rm -it -v $PWD:$PWD -v $HOME/.cache/ctrlp:$HOME/.cache/ctrlp -v $HOME/.cache/neosnippet:$HOME/.cache/neosnippet -v $HOME/.cache/nvim/back:$HOME/.cache/nvim/back -v $HOME/.local/share/nvim:$HOME/.local/share/nvim -w $PWD yukimemi/neovim $argv
end
