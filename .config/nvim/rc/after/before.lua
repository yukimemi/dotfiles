-- =============================================================================
-- File        : before.lua
-- Author      : yukimemi
-- Last Change : 2024/07/15 20:21:05.
-- =============================================================================

local before = require('before')

before.setup({
  -- How many edit locations to store in memory (default: 10)
  history_size = 42,
  -- Wrap around the ends of the edit history (default: false)
  history_wrap_enabled = true,
})

-- Jump to previous entry in the edit history
-- vim.keymap.set('n', '<C-h>', before.jump_to_last_edit, {})

-- Jump to next entry in the edit history
-- vim.keymap.set('n', '<C-l>', before.jump_to_next_edit, {})

-- Look for previous edits in quickfix list
-- vim.keymap.set('n', '<leader>oq', before.show_edits_in_quickfix, {})

-- Look for previous edits in telescope (needs telescope, obviously)
-- vim.keymap.set('n', '<leader>oe', before.show_edits_in_telescope, {})

-- You can provide telescope opts to the picker as show_edits_in_telescope argument:
-- vim.keymap.set('n', '<leader>oe', function()
--   before.show_edits_in_telescope(require('telescope.themes').get_dropdown())
-- end, {})
