-- =============================================================================
-- File        : nvim-silicon.lua
-- Author      : yukimemi
-- Last Change : 2024/10/12 22:13:08.
-- =============================================================================

require("nvim-silicon").setup()

vim.keymap.set("x", "<space>sc", function() require("nvim-silicon").clip() end,
  { desc = "Copy code screenshot to clipboard" })
