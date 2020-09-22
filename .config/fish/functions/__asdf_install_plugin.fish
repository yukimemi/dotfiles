function __asdf_install_plugin -a pl -a cli
  if test (count $argv) -eq 1
    set cli $pl
  end
  # if not type -q $cli
    asdf plugin add $pl
    asdf install $pl latest
    asdf global $pl (string trim (asdf list $pl latest))
  # end
end

