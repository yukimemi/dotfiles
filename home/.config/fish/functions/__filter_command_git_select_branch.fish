function __filter_command_git_select_branch
  git branch -a | __filter_command | read -l line
  and set br (string trim (string replace -r '.*/([^/]*)' '$1' (string replace '*' '' $line)))
  __echo "Checkout" $br
  and git co $br
  commandline -f repaint
end

