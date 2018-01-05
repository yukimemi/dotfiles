function fish_user_key_bindings

  # Additional bind for fish_vi_key_bindings.
  bind -M insert \cf accept-autosuggestion
  bind -M insert \cn down-or-search
  bind -M insert \cp up-or-search
  # TODO: Not work.
  bind -M insert \c\^ __cdup

  # tmux.
  bind sv __tmux_split_window_vertical
  bind ss __tmux_split_window_horizontal
  bind sh __tmux_select_pane_left
  bind sj __tmux_select_pane_down
  bind sk __tmux_select_pane_up
  bind sl __tmux_select_pane_right
  bind st __tmux_new_window
  bind sq __tmux_kill_pane
  bind \ch __tmux_previous_window
  bind \cl __tmux_next_window
  bind so __tmux_resize_pane_zoom

  # filter command.
  bind -M insert \cr __filter_command_history_select
  # bind -M insert \cs __filter_command_shell_snippets
  bind -M insert \cs __filter_command_pets
  bind sul __filter_command_history_execute
  bind -M insert \ck __filter_command_kill

end
