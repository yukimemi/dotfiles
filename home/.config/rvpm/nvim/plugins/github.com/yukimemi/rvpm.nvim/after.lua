-- =============================================================================
-- File        : after.lua
-- Author      : yukimemi
-- Last Change : 2026/04/20 01:45:37
-- =============================================================================

require("rvpm").setup({
  verbose = true,
  terminal = {
    opener = "enew!",
  },
})

vim.keymap.set("n", "<F3>", "<cmd>Rvpm<cr>", { desc = "Rvpm" })
