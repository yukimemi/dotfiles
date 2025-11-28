-- =============================================================================
-- File        : vim-gin.lua
-- Author      : yukimemi
-- Last Change : 2025/11/28 14:42:03.
-- =============================================================================

local map = vim.keymap.set
local opts = { noremap = true, silent = true }

map("n", "<space>gs", "<cmd>GinStatus<cr>", opts)
map("n", "<space>gc", "<cmd>Gin commit -v<cr>", opts)
-- map("n", "<space>gb", "<cmd>GinBranch<cr>", opts)
-- map("n", "<space>gd", "<cmd>GinDiff<cr>", opts)
-- map("n", "<space>gl", "<cmd>GinLog<cr>", opts)
map("n", "<space>gL", "<cmd>GinLog -p -- %<cr>", opts)
map("n", "<space>gp", "<cmd>Gin push<cr>", opts)
-- map("n", "<space>gg", ":<c-u>Gin grep ", opts)
