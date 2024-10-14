-- =============================================================================
-- File        : nvim-treesitter.lua
-- Author      : yukimemi
-- Last Change : 2024/10/14 17:20:30.
-- =============================================================================

require("nvim-treesitter.configs").setup({
  ensure_installed = {
    "c",
    "lua",
    "markdown",
    "markdown_inline",
    "powershell",
    "query",
    "rust",
    "typescript",
    "vim",
    "vimdoc",
    "xml",
  },
  sync_install = false,
  auto_install = true,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
    disable = function(lang)
      local byte_size = vim.api.nvim_buf_get_offset(0, vim.api.nvim_buf_line_count(0))
      if byte_size > 1024 * 1024 then
        return true
      end
      if not pcall(function()
            vim.treesitter.get_parser(0, lang):parse()
          end) then
        return true
      end
      if not pcall(function()
            vim.treesitter.query.get(lang, "highlights")
          end) then
        return true
      end
      return false
    end,
  },
})
