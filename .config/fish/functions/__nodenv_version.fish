function __nodenv_version
  if type -q nodenv
    echo (set_color green)" N: ["(nodenv version-name)"]"(set_color normal)
  end
end
