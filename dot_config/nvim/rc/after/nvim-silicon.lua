-- =============================================================================
-- File        : nvim-silicon.lua
-- Author      : yukimemi
-- Last Change : 2024/10/13 11:35:33.
-- =============================================================================

require("nvim-silicon").setup({})

vim.keymap.set("x", "<space>sc", function() require("nvim-silicon").clip() end,
  { desc = "Copy code screenshot to clipboard" })
