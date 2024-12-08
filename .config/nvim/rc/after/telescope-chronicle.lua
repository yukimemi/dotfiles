-- =============================================================================
-- File        : telescope-chronicle.lua
-- Author      : yukimemi
-- Last Change : 2024/12/08 00:12:54.
-- =============================================================================

require("telescope").load_extension("chronicle")

vim.keymap.set("n", "mr", "<cmd>Telescope chronicle read<cr>", { noremap = true, silent = true })
vim.keymap.set("n", "mw", "<cmd>Telescope chronicle write<cr>", { noremap = true, silent = true })

