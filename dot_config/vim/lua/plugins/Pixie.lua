return {
  "atlj/Pixie.nvim",

  enabled = false,

  cmd = "PixieCopy",

  build = function()
    vim.cmd.PixieInstall()
  end,
}
