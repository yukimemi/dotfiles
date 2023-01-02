return {
  "yukimemi/dps-hitori",

  lazy = false,

  dependencies = {
    "vim-denops/denops.vim",
  },

  init = function()
    vim.g.hitori_debug = false
    vim.g.hitori_enable = true
    vim.g.hitori_quit = true

    vim.api.nvim_create_autocmd("User", {
      group = "MyAutoCmd",
      pattern = "DenopsPluginPost:hitori",
      callback = function()
        vim.notify("dps-hitori loaded !")
      end,
    })
  end,
}
