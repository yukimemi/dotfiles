return {
  "lambdalisue/gin.vim",

  lazy = false,

  dependencies = {
    "vim-denops/denops.vim",
    "lambdalisue/askpass.vim",
    "lambdalisue/guise.vim",
  },

  init = function()
    vim.keymap.set("n", "<space>gs", "<cmd>GinStatus<cr>")
    vim.keymap.set("n", "<space>gc", "<cmd>Gin commit -v<cr>")
    vim.keymap.set("n", "<space>gb", "<cmd>GinBranch<cr>")
    vim.keymap.set("n", "<space>gg", "<cmd>Gin grep<cr>")
    vim.keymap.set("n", "<space>gd", "<cmd>Gin diff<cr>")
    vim.keymap.set("n", "<space>gl", "<cmd>Gin log<cr>")
    vim.keymap.set("n", "<space>gL", "<cmd>execute printf('Gin log -p %s', expand('%'))<cr>")
    vim.keymap.set("n", "<space>gp", "<cmd>Gin push<cr>")
  end,
}
