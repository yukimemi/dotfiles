-- =============================================================================
-- File        : asyncsearcher.lua
-- Author      : yukimemi
-- Last Change : 2024/10/27 18:11:16.
-- =============================================================================

vim.g.asyncsearcher_debug = false
vim.g.asyncsearcher_cfg_path = vim.fn.expand("~/.config/asyncsearcher/asyncsearcher.toml")
vim.o.grepformat = "%f:%l:%c:%m"

vim.keymap.set("n", "<space>ss", "<cmd>AsyncSearch<cr>", { noremap = true, silent = true, desc = "AsyncSearch" })
vim.keymap.set("n", "<space>sr", "<cmd>AsyncSearch --tool=ripgrep<cr>",
  { noremap = true, silent = true, desc = "AsyncSearch with ripgrep" })
vim.keymap.set("n", "<space>sp", "<cmd>AsyncSearch --tool=pt<cr>",
  { noremap = true, silent = true, desc = "AsyncSearch with pt" })
vim.keymap.set("n", "<space>sj", "<cmd>AsyncSearch --tool=jvgrep<cr>",
  { noremap = true, silent = true, desc = "AsyncSearch with jvgrep" })
vim.keymap.set("n", "<space>sS", "<cmd>AsyncSearch --tool=default-all<cr>",
  { noremap = true, silent = true, desc = "AsyncSearch no ignore" })
vim.keymap.set("n", "<space>sR", "<cmd>AsyncSearch --tool=ripgrep-all<cr>",
  { noremap = true, silent = true, desc = "AsyncSearch no ignore with ripgrep" })
vim.keymap.set("n", "<space>sP", "<cmd>AsyncSearch --tool=pt-all<cr>",
  { noremap = true, silent = true, desc = "AsyncSearch no ignore with pt" })
vim.keymap.set("n", "<space>sP", "<cmd>AsyncSearch --tool=jvgrep-all<cr>",
  { noremap = true, silent = true, desc = "AsyncSearch no ignore with jvgrep" })
