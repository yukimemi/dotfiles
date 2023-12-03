-- =============================================================================
-- File        : nvim-lint.lua
-- Author      : yukimemi
-- Last Change : 2023/12/04 01:32:49.
-- =============================================================================

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  callback = function()
    require("lint").try_lint()
  end,
})
