-- =============================================================================
-- File        : nvim-lint.lua
-- Last Change : 2024/10/14 22:33:08.
-- Last Change : 2024/10/14 22:33:08.
-- =============================================================================

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  group = vim.api.nvim_create_augroup("MyLintGroup", { clear = true }),
  pattern = '*',
  callback = function()
    require("lint").try_lint()
  end,
})
