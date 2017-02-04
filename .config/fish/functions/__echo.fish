function __echo
  if test (count $argv) -gt 1
    echo "
    ------
    $argv[1]: $argv[2]
    ------
    "
  end
end

