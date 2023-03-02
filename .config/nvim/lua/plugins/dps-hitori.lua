return {
  "yukimemi/dps-hitori",
  dev = false,

  lazy = false,

  dependencies = {
    "vim-denops/denops.vim",
  },

  init = function()
    vim.g.hitori_debug = false
    vim.g.hitori_enable = true
    vim.g.hitori_quit = true

    vim.g.hitori_blacklist_patterns = { "\\.tmp$", "\\.diff$", "(COMMIT_EDIT|TAG_EDIT|MERGE_|SQUASH_)MSG$" }

    vim.api.nvim_create_autocmd("User", {
      group = "MyAutoCmd",
      pattern = "DenopsPluginPost:hitori",
      callback = function()
        vim.notify("dps-hitori loaded !")
      end,
    })
  end,
}
