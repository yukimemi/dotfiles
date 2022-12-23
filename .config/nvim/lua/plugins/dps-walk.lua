return {
  "yukimemi/dps-walk",

  lazy = false,
  dependencies = {
    "vim-denops/denops.vim",
  },
  init = function()
    vim.g.walk_debug = false

    vim.keymap.set("n", "<space>wa", "<cmd>DenopsWalk<cr>")
    vim.keymap.set("n", "<space>ws", "<cmd>DenopsWalk --path=~/src<cr>")
    vim.keymap.set("n", "<space>wD", "<cmd>DenopsWalk --path=~/.dotfiles<cr>")
    vim.keymap.set("n", "<space>wc", "<cmd>DenopsWalk --path=~/.cache<cr>")
    vim.keymap.set("n", "<space>wj", "<cmd>DenopsWalk --path=~/.cache/junkfile<cr>")
    vim.keymap.set("n", "<space>wm", "<cmd>DenopsWalk --path=~/.memolist<cr>")
    vim.keymap.set("n", "<space>wd", "<cmd>DenopsWalkBufferDir<cr>")
  end,
}
