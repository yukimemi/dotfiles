return {
  "lambdalisue/vim-findent",

  cmd = "Findent",

  init = function()
    vim.api.nvim_create_autocmd("BufRead", {
      pattern = "*",
      callback = function()
        vim.cmd("Findent!")
      end,
    })
  end,
}
