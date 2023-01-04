return {
  "yukimemi/dps-walk",

  dev = false,

  lazy = false,

  dependencies = {
    "vim-denops/denops.vim",
  },

  init = function()
    vim.g.walk_debug = false

    vim.keymap.set("n", "<space>wa", "<cmd>DenopsWalk<cr>")
    vim.keymap.set("n", "<space>ws", "<cmd>DenopsWalk --path=~/src<cr>")
    vim.keymap.set("n", "<space>wd", "<cmd>DenopsWalk --path=~/.dotfiles<cr>")
    vim.keymap.set("n", "<space>wc", "<cmd>DenopsWalk --path=~/.cache<cr>")
    vim.keymap.set("n", "<space>wj", "<cmd>DenopsWalk --path=~/.cache/junkfile<cr>")
    vim.keymap.set("n", "<space>wm", "<cmd>DenopsWalk --path=~/.memolist<cr>")
    vim.keymap.set("n", "<space>wD", "<cmd>DenopsWalkBufferDir<cr>")

    vim.api.nvim_create_autocmd("User", {
      group = "MyAutoCmd",
      pattern = "DenopsPluginPost:walk",
      callback = function()
        vim.notify("dps-walk loaded !")
      end,
    })
  end,
}
