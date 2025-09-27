-- =============================================================================
-- File        : nvim-treesitter.lua
-- Author      : yukimemi
-- Last Change : 2025/09/28 01:01:43.
-- =============================================================================

require("nvim-treesitter").setup()

vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("vim-treesitter-start", {}),
  pattern = {
    'bash',
    'editorconfig',
    'fish',
    'git_config',
    'gitcommit',
    'gitignore',
    'go',
    'html',
    'javascript',
    'jq',
    'lua',
    'markdown',
    'markdown_inline',
    'nu',
    'powershell',
    'rust',
    'tmux',
    'typescript',
    'vim',
    'xml',
    'yaml',
  },
  callback = function(ctx)
    -- syntax highlighting, provided by Neovim
    pcall(vim.treesitter.start)
    -- folds, provided by Neovim
    vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
    -- indentation, provided by nvim-treesitter
    vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  end,
})
