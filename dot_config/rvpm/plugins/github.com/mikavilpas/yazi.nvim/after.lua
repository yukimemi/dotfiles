-- =============================================================================
-- File        : yazi.lua
-- Author      : yukimemi
-- Last Change : 2024/12/24 11:37:12.
-- =============================================================================

require("yazi").setup({
  open_for_directories = false,
  keymaps = {
    show_help = '<f1>',
  },
})

vim.keymap.set("n", "<up>", "<cmd>Yazi cwd<cr>", { desc = "Open the yazi in working directory" })
vim.keymap.set("n", "<c-up>", "<cmd>Yazi toggle<cr>", { desc = "Resume the yazi session" })
