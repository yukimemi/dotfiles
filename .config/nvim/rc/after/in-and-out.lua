-- =============================================================================
-- File        : in-and-out.lua
-- Author      : yukimemi
-- Last Change : 2025/11/16 09:17:59
-- =============================================================================

require('in-and-out').setup({})

vim.keymap.set("i", "<c-l>", function()
  require('in-and-out').in_and_out()
end, { desc = "in-and-out" })
