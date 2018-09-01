function __judge_os
  switch (uname)
  case Linux
    echo -n "Linux"
  case Darwin
    echo -n "Mac"
  case FreeBSD NetBSD DragonFly
    echo -n "BSD"
  case '*'
    echo -n "Other"
  end
end
