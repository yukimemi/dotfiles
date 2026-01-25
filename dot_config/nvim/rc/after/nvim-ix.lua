-- =============================================================================
-- File        : nvim-ix.lua
-- Author      : yukimemi
-- Last Change : 2025/08/03 14:42:36.
-- =============================================================================

vim.o.winborder = 'rounded' -- (Optional) nvim-ix follows global `winborder` settings to render windows

local ix = require('ix')

-- Setup nvim-ix
ix.setup({
  -- Register snippet expand function (optional if not using snippets)
  expand_snippet = function(snippet_body)
    -- vim.snippet.expand(snippet) -- for `neovim built-in` users
    -- require('luasnip').lsp_expand(snippet) -- for `LuaSnip` users
    -- require('snippy').expand_snippet(snippet) -- for `nvim-snippy` users
    vim.fn["vsnip#anonymous"](snippet_body) -- for `vim-vsnip` users
  end
})

-- Setup keymaps (Using `ix.charmap`; See below).
do
  -- common.
  ix.charmap.set({ 'i', 'c', 's' }, '<C-d>', ix.action.scroll(0 + 3))
  ix.charmap.set({ 'i', 'c', 's' }, '<C-u>', ix.action.scroll(0 - 3))

  -- completion.
  vim.keymap.set({ 'i', 'c' }, '<C-n>', ix.action.completion.select_next({ no_insert = true }))
  vim.keymap.set({ 'i', 'c' }, '<C-p>', ix.action.completion.select_prev({ no_insert = true }))
  ix.charmap.set({ 'i', 'c' }, '<C-Space>', ix.action.completion.complete())
  ix.charmap.set({ 'i', 'c' }, '<C-e>', ix.action.completion.close())
  ix.charmap.set({ 'c' }, '<CR>', ix.action.completion.commit_cmdline())
  ix.charmap.set({ 'i' }, '<CR>', ix.action.completion.commit({ select_first = true }))
  vim.keymap.set({ 'i' }, '<Down>', ix.action.completion.select_next({ no_insert = true }))
  vim.keymap.set({ 'i' }, '<Up>', ix.action.completion.select_prev({ no_insert = true }))
  ix.charmap.set({ 'i' }, '<Tab>', ix.action.completion.commit({
    select_first = true,
    replace = true,
    no_snippet = false
  }))

  -- signature_help.
  ix.charmap.set({ 'i', 's' }, '<C-o>', ix.action.signature_help.trigger_or_close())
  ix.charmap.set({ 'i', 's' }, '<C-j>', ix.action.signature_help.select_next())
end
