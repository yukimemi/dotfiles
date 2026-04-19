-- =============================================================================
-- File        : before.lua
-- Author      : yukimemi
-- Last Change : 2026/04/20 01:10:06.
-- =============================================================================

vim.g["lumiris_colors_path"] = { vim.fn.expand("~/.cache/rvpm/nvim/plugins/repos") }
vim.g["lumiris_notify"] = true
vim.g["lumiris_interval"] = 600

vim.keymap.set("n", "<space>co", "<cmd>ChangeColorscheme<cr>", { desc = "ChangeColorscheme" })
vim.keymap.set("n", "<space>Rd", "<cmd>DisableThisColorscheme<cr>", { desc = "DisableThisColorscheme" })
vim.keymap.set("n", "mL", "<cmd>LikeThisColorscheme<cr>", { desc = "LikeThisColorscheme" })
vim.keymap.set("n", "mh", "<cmd>HateThisColorscheme<cr>", { desc = "HateThisColorscheme" })
