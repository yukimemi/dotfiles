-- =============================================================================
-- File        : asyncwalker.lua
-- Author      : yukimemi
-- Last Change : 2025/09/01 01:48:54.
-- =============================================================================

vim.keymap.set("n", "<space>wa", "<cmd>AsyncWalk<cr>", { noremap = true, desc = "AsyncWalk" })
vim.keymap.set("n", "<space>ws", "<cmd>AsyncWalk --path=~/src<cr>", { noremap = true, desc = "AsyncWalk src dir" })
vim.keymap.set("n", "<space>wd", "<cmd>AsyncWalk --path=~/.dotfiles<cr>", { noremap = true, desc = "AsyncWalk dotfiles" })
vim.keymap.set("n", "<space>wc", "<cmd>AsyncWalk --path=~/.cache<cr>", { noremap = true, desc = "AsyncWalk cache" })
vim.keymap.set("n", "<space>wm", "<cmd>AsyncWalk --path=~/.memolist<cr>", { noremap = true, desc = "AsyncWalk memolist" })
vim.keymap.set("n", "<space>wj", "<cmd>AsyncWalk --path=~/.cache/junkfile<cr>",
  { noremap = true, desc = "AsyncWalk junkfile" })

vim.keymap.set("n", "<space>wb", "<cmd>AsyncWalkBufferDir<cr>", { noremap = true, desc = "AsyncWalkBufferDir" })
vim.keymap.set("n", "<space>wr", "<cmd>AsyncWalkResume<cr>", { noremap = true, desc = "AsyncWalkResume" })
