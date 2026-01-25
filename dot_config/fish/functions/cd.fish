function cd
    builtin cd $argv
    ls -a
    if not type -q zoxide
      __save_directory $PWD &
    end
end
