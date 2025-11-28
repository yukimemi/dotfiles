-- =============================================================================
-- File        : github-actions.lua
-- Author      : yukimemi
-- Last Change : 2025/11/28 17:05:10
-- =============================================================================

local actions = require('github-actions')
vim.keymap.set('n', '<leader>Gd', actions.dispatch_workflow, { desc = 'Dispatch workflow' })
vim.keymap.set('n', '<leader>Gh', actions.show_history, { desc = 'Show workflow history' })
vim.keymap.set('n', '<leader>Gw', actions.watch_workflow, { desc = 'Watch running workflow' })
actions.setup({});
