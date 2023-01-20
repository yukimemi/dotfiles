return {
  "yuki-yano/ai-review.vim",

  lazy = false,

  dependencies = {
    "vim-denops/denops.vim",
  },

  init = function()
    vim.api.nvim_create_autocmd("User", {
      group = "MyAutoCmd",
      pattern = "DenopsPluginPost:ai-review",
      callback = function()
        vim.notify("ai-review loaded !")
      end,
    })
  end,
}
