-- =============================================================================
-- File        : modes.lua
-- Author      : yukimemi
-- Last Change : 2024/10/10 11:52:02.
-- =============================================================================

require('modes').setup({
  colors = {
    bg = "", -- Optional bg param, defaults to Normal hl group
    copy = "#f5c359",
    delete = "#c75c6a",
    insert = "#78ccc5",
    visual = "#9745be",
  },

  -- Set opacity for cursorline and number background
  line_opacity = 0.15,

  -- Enable cursor highlights
  set_cursor = true,

  -- Enable cursorline initially, and disable cursorline for inactive windows
  -- or ignored filetypes
  set_cursorline = true,

  -- Enable line number highlights to match cursorline
  set_number = true,

  -- Disable modes highlights in specified filetypes
  -- Please PR commonly ignored filetypes
  ignore_filetypes = { 'NvimTree', 'TelescopePrompt' }
})
