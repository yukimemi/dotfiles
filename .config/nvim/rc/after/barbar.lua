-- =============================================================================
-- File        : barbar.lua
-- Author      : yukimemi
-- Last Change : 2024/05/06 17:00:52.
-- =============================================================================

require("barbar").setup({
  animation = true,
  auto_hide = true,
  tabpages = true,
  clickable = true,
  focus_on_close = "left",
  highlight_visible = true,

  insert_at_end = false,
  insert_at_start = false,

  maximum_padding = 1,
  minimum_padding = 1,
  maximum_length = 30,
  minimum_length = 0,

  semantic_letters = true,

  letters = "asdfjkl;ghnmxcvbziowerutyqpASDFJKLGHNMXCVBZIOWERUTYQP",
})
