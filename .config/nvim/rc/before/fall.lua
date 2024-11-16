-- =============================================================================
-- File        : fall.lua
-- Author      : yukimemi
-- Last Change : 2024/11/16 19:57:01.
-- =============================================================================

vim.keymap.set("n", "<space>lf", "<cmd>Fall file<cr>", { desc = "Fall file" })
vim.keymap.set("n", "<space>la", "<cmd>Fall file:all<cr>", { desc = "Fall file:all" })
vim.keymap.set("n", "<space>ld", "<cmd>Fall file ~/.dotfiles<cr>", { desc = "Fall dotfiles" })
vim.keymap.set("n", "<space>ls", "<cmd>Fall file ~/src<cr>", { desc = "Fall src" })
vim.keymap.set("n", "<space>lc", "<cmd>Fall file ~/.cache/nvim<cr>", { desc = "Fall cache" })
vim.keymap.set("n", "<space>lm", "<cmd>Fall file ~/.memolist<cr>", { desc = "Fall memolist" })

vim.keymap.set("n", "<space>lb", "<cmd>Fall buffer<cr>", { desc = "Fall buffer" })
vim.keymap.set("n", "<space>lr", "<cmd>Fall rg<cr>", { desc = "Fall rg" })
vim.keymap.set("n", "<space>lg", "<cmd>Fall git-grep<cr>", { desc = "Fall git-grep" })
vim.keymap.set("n", "<space>ll", "<cmd>Fall line<cr>", { desc = "Fall line" })
vim.keymap.set("n", "<space>lh", "<cmd>Fall help<cr>", { desc = "Fall help" })
