function __fnm_version
  if type -q fnm
      echo (set_color green)" N: ["(fnm ls | grep '•' | sed 's/ • //')"]"(set_color normal)
  end
end
