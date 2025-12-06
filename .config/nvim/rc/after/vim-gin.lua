-- =============================================================================
-- File        : vim-gin.lua
-- Author      : yukimemi
-- Last Change : 2025/12/03 13:51:56.
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

vim.api.nvim_create_autocmd({ 'BufRead', 'BufNew' }, {
  group = vim.api.nvim_create_augroup("MyGinCd", { clear = true }),
  pattern = "*",
  callback = function()
    vim.cmd("GinLcd")
  end,
})
