return {
  "kuuote/jsonyaml.vim",

  lazy = false,

  dependencies = {
    "vim-denops/denops.vim",
  },

  init = function()
    vim.api.nvim_create_autocmd("User", {
      group = "MyAutoCmd",
      pattern = "DenopsPluginPost:jsonyaml",
      callback = function()
        vim.notify("jsonyaml loaded !")
      end,
    })
    vim.api.nvim_create_autocmd("FileType", {
      group = "MyAutoCmd",
      pattern = "json,yaml",
      callback = function()
        vim.cmd([[
          command! -buffer -range=% JY call denops#request('jsonyaml', 'jsonYAML', [<line1>, <line2>])
          command! -buffer -range=% YJ call denops#request('jsonyaml', 'yamlJSON', [<line1>, <line2>])
        ]])
      end,
    })
  end,
}
