-- =============================================================================
-- File        : nvim-treesitter.lua
-- Author      : yukimemi
-- Last Change : 2025/09/15 18:57:52.
-- =============================================================================

require("nvim-treesitter").setup()

vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("vim-treesitter-start", {}),
  callback = function(ctx)
    pcall(vim.treesitter.start)
    vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  end,
})
