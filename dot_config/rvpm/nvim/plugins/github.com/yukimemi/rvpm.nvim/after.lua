-- =============================================================================
-- File        : after.lua
-- Author      : yukimemi
-- Last Change : 2026/04/20 01:45:37
-- =============================================================================

require("rvpm").setup({
  terminal = {
    opener = "enew!",
  },
})

vim.keymap.set("n", "<space>rv", "<cmd>Rvpm<cr>", { desc = "Rvpm" })
