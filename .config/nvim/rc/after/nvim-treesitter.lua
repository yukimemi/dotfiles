-- =============================================================================
-- File        : nvim-treesitter.lua
-- Author      : yukimemi
-- Last Change : 2025/09/15 08:34:26.
-- =============================================================================

require("nvim-treesitter").setup({})

vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("vim-treesitter-start", {}),
  callback = function(ctx)
    pcall(vim.treesitter.start)
    vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  end,
})

require("nvim-treesitter").install({
  "bash",
  "editorconfig",
  "fish",
  "git_config",
  "gitcommit",
  "gitignore",
  "go",
  "html",
  "javascript",
  "jq",
  "lua",
  "markdown",
  "markdown_inline",
  "nu",
  "powershell",
  "rust",
  "tmux",
  "typescript",
  "vim",
  "xml",
  "yaml",
}, {
  force = false,
  generate = true,
  max_jobs = 4,
  summary = false,
})
