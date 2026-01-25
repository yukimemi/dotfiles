function __add_fish_user_paths -a addpath
  if test -d $addpath
    fish_add_path $addpath
  end
end
