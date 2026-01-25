function __filter_command_pets
  if not type -q pet
    echo "'pet' command not found !"
    return 1
  end

  commandline (pet search --query (commandline))
end

