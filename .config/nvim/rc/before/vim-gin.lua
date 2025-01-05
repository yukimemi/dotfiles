-- =============================================================================
-- File        : vim-gin.lua
-- Author      : yukimemi
-- Last Change : 2025/01/01 19:21:37.
-- =============================================================================

local map = vim.keymap.set
local opts = { noremap = true, silent = true }

map("n", "<space>gs", "<cmd>GinStatus<cr>", opts)
map("n", "<space>gc", "<cmd>Gin commit -v<cr>", opts)
map("n", "<space>gb", "<cmd>GinBranch<cr>", opts)
map("n", "<space>gd", "<cmd>GinDiff<cr>", opts)
map("n", "<space>gl", "<cmd>GinLog<cr>", opts)
map("n", "<space>gL", "<cmd>GinLog -p -- %<cr>", opts)
map("n", "<space>gp", "<cmd>Gin push<cr>", opts)
-- map("n", "<space>gg", ":<c-u>Gin grep ", opts)

vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("MyGinStatus", { clear = true }),
  pattern = "gin-status",
  callback = function()
    local bufmap = function(mode, lhs, rhs)
      vim.keymap.set(mode, lhs, rhs, { noremap = true, silent = true, buffer = true })
    end

    bufmap("n", "c", "<cmd>Gin commit -v<cr>")
    bufmap("n", "d", "<cmd>GinDiff --cached<cr>")
    bufmap("n", "L", "<cmd>GinLog --graph --oneline<cr>")
    bufmap("n", "p", "<cmd>Gin push<cr>")
    bufmap("n", "P", "<cmd>Gin pull<cr>")
    bufmap("n", "q", "<cmd>q<cr>")
    bufmap({ "n", "x" }, "h", "<Plug>(gin-action-stage)")
    bufmap({ "n", "x" }, "l", "<Plug>(gin-action-unstage)")
  end,
})
