-- =============================================================================
-- File        : nvim-hlslens.lua
-- Author      : yukimemi
-- Last Change : 2024/02/11 22:46:50.
-- =============================================================================

require('hlslens').setup()

local kopts = { noremap = true, silent = true }

vim.keymap.set('n', 'n', [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]], kopts)
vim.keymap.set('n', 'N', [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]], kopts)

vim.keymap.set({ 'n', 'x', 'o' }, '*', [[<Plug>(asterisk-z*)zv<Cmd>lua require('hlslens').start()<CR>]], kopts)
vim.keymap.set({ 'n', 'x', 'o' }, '#', [[<Plug>(asterisk-z#)zv<Cmd>lua require('hlslens').start()<CR>]], kopts)
vim.keymap.set({ 'n', 'x', 'o' }, 'g*', [[<Plug>(asterisk-gz*)zv<Cmd>lua require('hlslens').start()<CR>]], kopts)
vim.keymap.set({ 'n', 'x', 'o' }, 'g#', [[<Plug>(asterisk-gz#)zv<Cmd>lua require('hlslens').start()<CR>]], kopts)
