function fish_user_key_bindings

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

  # Additional bind for fish_vi_key_bindings.
  bind -M insert \cf accept-autosuggestion
  bind -M insert \cn down-or-search
  bind -M insert \cp up-or-search

  # for tmux.
  bind sv tmux_split_window_vertical
  bind ss tmux_split_window_horizontal

  bind sh tmux_select_pane_left
  bind sj tmux_select_pane_down
  bind sk tmux_select_pane_up
  bind sl tmux_select_pane_right
  bind st tmux_new_window
  bind sq tmux_kill_pane

  bind \ch tmux_previous_window
  bind \cl tmux_next_window

  bind so tmux_resize_pane_zoom

end
