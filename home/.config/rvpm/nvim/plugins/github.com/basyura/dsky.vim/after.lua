-- =============================================================================
-- File        : after.lua
-- Author      : yukimemi
-- Last Change : 2026/04/20 01:10:06.
-- =============================================================================

vim.g.dsky_id = "yukimemi"
vim.g.dsky_password = vim.fn.getenv("DSKY_PASSWORD")
vim.keymap.set("n", "<space>Th", "<cmd>DSkyTimeline<cr>")
vim.keymap.set("n", "<space>Tm", "<cmd>DSkyNotifications<cr>")
