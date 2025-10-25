-- =============================================================================
-- File        : vim-gin.lua
-- Author      : yukimemi
-- Last Change : 2025/10/26 08:33:41
-- =============================================================================

vim.api.nvim_create_autocmd({ 'BufRead', 'BufNew' }, {
  group = vim.api.nvim_create_augroup("MyGinCd", { clear = true }),
  pattern = "*",
  callback = function()
    vim.cmd("GinLcd")
  end,
})
