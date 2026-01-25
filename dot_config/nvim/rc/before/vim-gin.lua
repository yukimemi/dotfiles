-- =============================================================================
-- File        : vim-gin.lua
-- Author      : yukimemi
-- Last Change : 2025/12/03 13:51:14.
-- =============================================================================

vim.g.gin_log_persistent_args = { '++emojify' }
vim.g.gin_log_disable_default_mappings = 1

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
