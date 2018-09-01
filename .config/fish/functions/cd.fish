function cd
    builtin cd $argv
    ls -a
    __save_directory $PWD &
end
