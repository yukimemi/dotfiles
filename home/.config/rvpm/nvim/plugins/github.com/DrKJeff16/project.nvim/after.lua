-- =============================================================================
-- File        : after.lua
-- Author      : yukimemi
-- Last Change : 2026/04/30 00:00:00.
-- =============================================================================

require("project").setup({
  snacks = {
    enabled = true,
  },
})

vim.keymap.set("n", "mp", "<Cmd>ProjectSnacks<CR>", { desc = "Project picker (snacks)" })
