-- =============================================================================
-- File        : after.lua
-- Author      : yukimemi
-- Last Change : 2026/04/26 13:48:01.
-- =============================================================================

require("aibo").setup({})

vim.keymap.set("n", "<space>b", "<cmd>Aibo gemini<cr>", { desc = "Aibo gemini" })
vim.keymap.set("n", "<space>B", "<cmd>Aibo -focus gemini<cr>", { desc = "Aibo gemini" })
