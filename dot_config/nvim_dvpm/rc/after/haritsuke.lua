-- =============================================================================
-- File        : haritsuke.lua
-- Author      : yukimemi
-- Last Change : 2025/09/28 08:44:01
-- =============================================================================

-- Enhanced paste commands with history cycling
vim.keymap.set({ 'n', 'x' }, 'p', '<Plug>(haritsuke-p)')
vim.keymap.set({ 'n', 'x' }, 'P', '<Plug>(haritsuke-P)')
vim.keymap.set({ 'n', 'x' }, 'gp', '<Plug>(haritsuke-gp)')
vim.keymap.set({ 'n', 'x' }, 'gP', '<Plug>(haritsuke-gP)')

-- Cycle through yank history after pasting
vim.keymap.set('n', '<C-n>', '<Plug>(haritsuke-next)')
vim.keymap.set('n', '<C-p>', '<Plug>(haritsuke-prev)')

-- Replace operator
-- vim.keymap.set({ 'n', 'x' }, '_', '<Plug>(haritsuke-replace)')

-- Toggle smart indent while cycling (optional)
vim.keymap.set('n', '<C-i>', '<Plug>(haritsuke-toggle-smart-indent)')
