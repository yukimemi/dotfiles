-- =============================================================================
-- File        : nvim-tree.lua
-- Author      : yukimemi
-- Last Change : 2024/03/30 17:43:35.
-- =============================================================================

local function my_on_attach(bufnr)
  local api = require "nvim-tree.api"

  local function opts(desc)
    return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  -- default mappings
  api.config.mappings.default_on_attach(bufnr)

  -- custom mappings
  vim.keymap.set('n', 'l', api.node.open.edit, opts('Open'))
  vim.keymap.set('n', 'h', api.node.navigate.parent_close, opts('Close Directory'))
  vim.keymap.set('n', '?', api.tree.toggle_help, opts('Help'))
end

-- pass to setup along with your other options
require("nvim-tree").setup({
  on_attach = my_on_attach,
})

vim.keymap.set('n', '<leader>e', '<cmd>NvimTreeFindFile<CR>')
