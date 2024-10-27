-- =============================================================================
-- File        : asyncwalker.lua
-- Author      : yukimemi
-- Last Change : 2024/10/27 16:25:16.
-- =============================================================================

vim.keymap.set("n", "mw", "<cmd>AsyncWalk<cr>", { noremap = true, silent = true, desc = "AsyncWalk" })
vim.keymap.set("n", "ms", "<cmd>AsyncWalk --path=~/src<cr>",
  { noremap = true, silent = true, desc = "AsyncWalk src dir" })
vim.keymap.set("n", "md", "<cmd>AsyncWalk --path=~/.dotfiles<cr>",
  { noremap = true, silent = true, desc = "AsyncWalk dotfiles" })
vim.keymap.set("n", "mC", "<cmd>AsyncWalk --path=~/.cache<cr>",
  { noremap = true, silent = true, desc = "AsyncWalk cache" })
vim.keymap.set("n", "mM", "<cmd>AsyncWalk --path=~/.memolist<cr>",
  { noremap = true, silent = true, desc = "AsyncWalk memolist" })
vim.keymap.set("n", "mj", "<cmd>AsyncWalk --path=~/.cache/junkfile<cr>",
  { noremap = true, silent = true, desc = "AsyncWalk junkfile" })

vim.keymap.set("n", "mb", "<cmd>AsyncWalkBufferDir<cr>", { noremap = true, silent = true, desc = "AsyncWalkBufferDir" })
vim.keymap.set("n", "<space>wr", "<cmd>AsyncWalkResume<cr>", { noremap = true, silent = true, desc = "AsyncWalkResume" })
