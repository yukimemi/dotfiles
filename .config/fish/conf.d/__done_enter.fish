function __done_enter --on-event fish_postexec
  if test -z "$argv"
    if git rev-parse --is-inside-work-tree >/dev/null ^&1
      echo (set_color yellow)"--- git status ---"(set_color normal)
      git status -sb
    end
  end
end
