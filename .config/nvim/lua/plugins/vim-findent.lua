return {
  "lambdalisue/vim-findent",

  cmd = "Findent",

  init = function()
    vim.g["findent#enable_warnings"] = 0
    vim.g["findent#enable_messages"] = 0

    vim.api.nvim_create_autocmd("BufRead", {
      group = "MyAutoCmd",
      pattern = "*",
      callback = function()
        vim.cmd("Findent!")
      end,
    })
  end,
}
