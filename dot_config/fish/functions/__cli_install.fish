function cli_install -a cmd repo
  if not type -q $cmd
    curl -L git.io/cli | env L=$repo sh
  end
end

