-- =============================================================================
-- File        : nvim-aibo.lua
-- Author      : yukimemi
-- Last Change : 2025/11/02 13:33:47.
-- =============================================================================

require("aibo").setup()

vim.keymap.set("n", "<space>b", "<cmd>Aibo gemini<cr>", { desc = "Aibo gemini" })
