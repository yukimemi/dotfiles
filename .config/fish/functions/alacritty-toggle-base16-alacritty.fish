function alacritty-toggle-base16-alacritty
  if not test -d ~/.aaron-williamson-alacritty-theme
    git clone https://github.com/aaron-williamson/base16-alacritty.git ~/.aaron-williamson-alacritty-theme
  end
  if not type -q alacritty-colorscheme
    pip install git+https://github.com/toggle-corp/alacritty-colorscheme.git
  end
  alacritty-colorscheme -C ~/.aaron-williamson-alacritty-theme/colors -l | __filter_command | read -l line
  and __echo "Change colorscheme" $line
  and alacritty-colorscheme -C ~/.aaron-williamson-alacritty-theme/colors -a $line
end
