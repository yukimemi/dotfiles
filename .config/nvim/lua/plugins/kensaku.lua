return {
  "lambdalisue/kensaku.vim",

  lazy = false,

  dependencies = {
    "vim-denops/denops.vim",
  },

  init = function()
    vim.api.nvim_create_autocmd("User", {
      group = "MyAutoCmd",
      pattern = "DenopsPluginPost:kensaku",
      callback = function()
        vim.notify("kensaku loaded !")
      end,
    })
  end,
}
