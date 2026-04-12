-- =============================================================================
-- File        : treesitter-compat-highlights.lua
-- Author      : yukimemi
-- Last Change : 2024/02/17 13:31:44.
-- =============================================================================

vim.api.nvim_create_autocmd("ColorScheme", {
  group = vim.api.nvim_create_augroup("treesitter-compat-highlights", { clear = true }),
  pattern = "*",
  callback = require("treesitter-compat-highlights").apply,
  desc = "Apply compatible highlights for nvim-treesitter",
})
