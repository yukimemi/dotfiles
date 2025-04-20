-- =============================================================================
-- File        : editarble-term.lua
-- Author      : yukimemi
-- Last Change : 2025/04/20 21:51:12.
-- =============================================================================

local editableterm = require('editable-term')
editableterm.setup({
  promts = {
    ['^%(gdb%) '] = {}, -- gdb promt
    ['^>>> '] = {}, -- python PS1
    ['^... '] = {}, -- python PS2
    ['➤  '] = {}, -- starship
  },
})

if vim.fn.has('win32') == 1 then
  vim.keymap.set("n", "<c-s>", "<cmd>terminal pwsh<cr>", { noremap = true, silent = true })
else
  vim.keymap.set("n", "<c-s>", "<cmd>terminal<cr>", { noremap = true, silent = true })
end
