-- =============================================================================
-- File        : before.lua
-- Author      : yukimemi
-- Last Change : 2026/05/31 14:41:08
-- =============================================================================

-- Backups are silent by default. Browse / diff them with:
vim.keymap.set("n", "<space>so", "<cmd>SilentSaverOpen<cr>", { desc = "silentsaver: open backups" })
vim.keymap.set("n", "<space>sd", "<cmd>SilentSaverDiff<cr>", { desc = "silentsaver: diff backup vs original" })
