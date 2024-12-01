-- =============================================================================
-- File        : telescope-frecency.lua
-- Author      : yukimemi
-- Last Change : 2024/12/01 08:50:12.
-- =============================================================================

require("telescope").load_extension("frecency")
vim.keymap.set("n", "<c-p>", "<cmd>Telescope frecency<cr>", { desc = "Open the frecency list" })

