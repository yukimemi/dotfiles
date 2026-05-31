-- =============================================================================
-- File        : before.lua
-- Author      : yukimemi
-- Last Change : 2026/05/31 12:22:53
-- =============================================================================

-- Keymaps migrated from lumiris.vim (before.lua). The command model changed:
--   lumiris.vim : Like / Hate (priority) + Disable (per-scheme exclude)
--   lumiris.nvim: Like (boost) / Hate (exclude a scheme), plus
--                 Enable / Disable / Toggle for the whole rotation.
vim.keymap.set("n", "<space>co", "<cmd>LumirisChange<cr>", { desc = "lumiris: change colorscheme" })
vim.keymap.set("n", "mL", "<cmd>LumirisLike<cr>", { desc = "lumiris: like this colorscheme" })
vim.keymap.set("n", "mh", "<cmd>LumirisHate<cr>", { desc = "lumiris: hate (exclude) this colorscheme" })
vim.keymap.set("n", "<space>Rd", "<cmd>LumirisToggle<cr>", { desc = "lumiris: toggle auto rotation" })
