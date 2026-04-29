-- =============================================================================
-- File        : after.lua
-- Author      : yukimemi
-- Last Change : 2026/04/20 00:48:29
-- =============================================================================

vim.keymap.set("n", "mr", function() Snacks.picker.chronicle_read() end, { desc = "Chronicle Read" })
vim.keymap.set("n", "mw", function() Snacks.picker.chronicle_write() end, { desc = "Chronicle Write" })
