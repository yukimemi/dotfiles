function fish_user_key_bindings

  # Additional bind for fish_vi_key_bindings.
  bind -M insert \cf accept-autosuggestion
  bind -M insert \cn down-or-search
  bind -M insert \cp up-or-search
  # TODO: Not enable.
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
  bind sul __filter_command_history_execute

  ### fzf ###
  bind \ct '__fzf_ctrl_t'
  bind \cr '__fzf_ctrl_r'
  bind \cx '__fzf_ctrl_x'
  bind \ec '__fzf_alt_c'
  bind \eC '__fzf_alt_shift_c'
  if bind -M insert >/dev/null ^/dev/null
    bind -M insert \ct '__fzf_ctrl_t'
    bind -M insert \cr '__fzf_ctrl_r'
    bind -M insert \cx '__fzf_ctrl_x'
    bind -M insert \ec '__fzf_alt_c'
    bind -M insert \eC '__fzf_alt_shift_c'
  end
  ### fzf ###
end
