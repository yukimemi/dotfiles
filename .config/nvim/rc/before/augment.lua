-- =============================================================================
-- File        : augment.lua
-- Author      : yukimemi
-- Last Change : 2025/02/15 15:19:41.
-- =============================================================================

vim.g.augment_disable_tab_mapping = true

vim.keymap.set("i", "<c-e>", "<cmd>call augment#Accept()<cr>")
