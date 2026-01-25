function __pyenv_version
  if type -q pyenv
    echo (set_color yellow)" P: ["(pyenv version-name)"]"(set_color normal)
  end
end
