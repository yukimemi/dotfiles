-- =============================================================================
-- File        : editarble-term.lua
-- Author      : yukimemi
-- Last Change : 2025/04/20 18:55:35.
-- =============================================================================

local editableterm = require('editable-term')
editableterm.setup({
  promts = {
    ['^%(gdb%) '] = {}, -- gdb promt
    ['^>>> '] = {},     -- python PS1
    ['^... '] = {},     -- python PS2
    ['➤  '] = {},       -- starship
  },
})

vim.keymap.set("n", "<c-s>", "<cmd>terminal<cr>", { noremap = true, silent = true })
