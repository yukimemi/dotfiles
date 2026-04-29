function __rbenv_version
  if type -q rbenv
    echo (set_color magenta)" R: ["(rbenv version-name)"]"(set_color normal)
  end
end
