function alacritty-toggle-alacritty-theme
  if not test -d ~/.eendroroy-alacritty-theme
    git clone https://github.com/eendroroy/alacritty-theme.git ~/.eendroroy-alacritty-theme
  end
  if not type -q alacritty-colorscheme
    pip install git+https://github.com/toggle-corp/alacritty-colorscheme.git
  end
  alacritty-colorscheme -C ~/.eendroroy-alacritty-theme/themes -l | __filter_command | read -l line
  and __echo "Change colorscheme" $line
  and alacritty-colorscheme -C ~/.eendroroy-alacritty-theme/themes -a $line
end
