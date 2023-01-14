return {
  "lambdalisue/vim-findent",

  enabled = vim.g.plugin_use_findent,

  cmd = "Findent",

  init = function()
    vim.g["findent#enable_warnings"] = 1
    vim.g["findent#enable_messages"] = 1

    vim.api.nvim_create_autocmd("BufRead", {
      group = "MyAutoCmd",
      pattern = "*",
      callback = function()
        vim.cmd("Findent!")
      end,
    })
  end,
}
