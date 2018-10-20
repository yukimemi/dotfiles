function __goenv_version
  if type -q goenv
    echo (set_color blue)" G: ["(goenv version-name)"]"(set_color normal)
  end
end
