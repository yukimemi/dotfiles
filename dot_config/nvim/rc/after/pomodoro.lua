-- =============================================================================
-- File        : pomodoro.lua
-- Author      : yukimemi
-- Last Change : 2024/10/12 21:46:27.
-- =============================================================================

require("pomodoro").setup({
  start_at_launch = true,
  work_duration = 25,
  break_duration = 5,
  delay_duration = 1, -- The additionnal work time you get when you delay a break
  long_break_duration = 15,
  breaks_before_long = 4,
})

