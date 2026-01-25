-- =============================================================================
-- File        : telescope-frecency.lua
-- Author      : yukimemi
-- Last Change : 2024/12/01 10:35:31.
-- =============================================================================

require("telescope").load_extension("frecency")
vim.keymap.set("n", "<space>fo", "<cmd>Telescope frecency<cr>", { desc = "Open the frecency list" })
