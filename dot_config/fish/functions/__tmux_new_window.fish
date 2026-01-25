function __tmux_new_window
  tmux new-window -c "#{pane_current_path}"
end

