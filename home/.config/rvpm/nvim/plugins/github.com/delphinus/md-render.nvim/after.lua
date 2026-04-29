-- =============================================================================
-- File        : after.lua
-- Author      : yukimemi
-- Last Change : 2026/04/26 10:20:02
-- =============================================================================

vim.keymap.set("n", "<leader>mp", "<Plug>(md-render-preview)", { desc = "Markdown preview (toggle)" })
vim.keymap.set("n", "<leader>mt", "<Plug>(md-render-preview-tab)", { desc = "Markdown preview in tab (toggle)" })

local ok, snacks = pcall(require, "snacks")
if ok then
  snacks.setup({
    picker = {
      preview = require("md-render.snacks").preview(),
    },
  })
end
