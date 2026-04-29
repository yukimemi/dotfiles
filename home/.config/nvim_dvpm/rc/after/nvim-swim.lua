-- =============================================================================
-- File        : nvim-swim.lua
-- Author      : yukimemi
-- Last Change : 2025/02/01 09:40:20.
-- =============================================================================

local swm = require('swm')
vim.keymap.set({ 'n', 'x' }, '<c-h>', swm.h, { desc = 'swm left' })
vim.keymap.set({ 'n', 'x' }, '<c-j>', swm.j, { desc = 'swm down' })
vim.keymap.set({ 'n', 'x' }, '<c-k>', swm.k, { desc = 'swm up' })
vim.keymap.set({ 'n', 'x' }, '<c-l>', swm.l, { desc = 'swm right' })
