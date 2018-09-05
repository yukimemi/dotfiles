function __fnm_version
  if type -q fnm
    echo (set_color green)" N: ["(__fnm_version_which)"]"(set_color normal)
  end
end
