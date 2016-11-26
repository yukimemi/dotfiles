function tmux_split_window_horizontal
  tmux split-window -vc "#{pane_current_path}"
end

