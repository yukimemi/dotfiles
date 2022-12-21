return {
  "yukimemi/dps-walk",

  lazy = false,
  dependencies = {
    "vim-denops/denops.vim",
  },
  init = function()
    vim.g.walk_debug = false

    vim.keymap.set("n", "<leader>wa", "<cmd>DenopsWalk<cr>")
    vim.keymap.set("n", "<leader>ws", "<cmd>DenopsWalk --path=~/src<cr>")
    vim.keymap.set("n", "<leader>wD", "<cmd>DenopsWalk --path=~/.dotfiles<cr>")
    vim.keymap.set("n", "<leader>wc", "<cmd>DenopsWalk --path=~/.cache<cr>")
    vim.keymap.set("n", "<leader>wj", "<cmd>DenopsWalk --path=~/.cache/junkfile<cr>")
    vim.keymap.set("n", "<leader>wm", "<cmd>DenopsWalk --path=~/.memolist<cr>")
    vim.keymap.set("n", "<leader>wd", "<cmd>DenopsWalkBufferDir<cr>")
  end,
}
