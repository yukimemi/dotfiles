-- =============================================================================
-- File        : init.lua
-- Author      : yukimemi
-- Last Change : 2026/04/20 01:10:06.
-- =============================================================================

vim.g.ts_enable = {
  parsers = {
    "bash", "editorconfig", "fish", "git_config", "gitcommit", "gitignore",
    "go", "html", "javascript", "jq", "lua", "markdown", "markdown_inline",
    "nu", "powershell", "rust", "tmux", "typescript", "vim", "xml", "yaml",
  },
  auto_install = true,
  highlights = true,
  folds = true,
  indents = true,
}
