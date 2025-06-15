-- =============================================================================
-- File        : nvim-ufo.lua
-- Author      : yukimemi
-- Last Change : 2025/06/15 12:14:15.
-- =============================================================================

vim.o.foldcolumn = '1'
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.foldenable = true

vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)

require('ufo').setup({
  provider_selector = function(bufnr, filetype, buftype)
    return { 'treesitter', 'indent' }
  end,
  close_fold_current_line_for_ft = {
    default = false,
  },
})
