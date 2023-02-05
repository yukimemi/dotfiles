return {
  "atlj/Pixie.nvim",

  cmd = "PixieCopy",

  build = function()
    vim.cmd.PixieInstall()
  end,
}
