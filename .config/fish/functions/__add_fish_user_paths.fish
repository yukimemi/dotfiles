function __add_fish_user_paths -a addpath
  if test -d $addpath
    set -U fish_user_paths $addpath $fish_user_paths
  end
end
