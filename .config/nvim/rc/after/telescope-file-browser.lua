-- =============================================================================
-- File        : telescope-file-browser.lua
-- Author      : yukimemi
-- Last Change : 2024/12/01 08:55:21.
-- =============================================================================

require("telescope").load_extension("file_browser")

vim.keymap.set("n", "<space>pp", "<cmd>Telescope file_browser cwd=~/src<cr>", { desc = "Browse ~/src" })
