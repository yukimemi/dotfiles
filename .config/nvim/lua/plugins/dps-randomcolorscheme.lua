return {
  "yukimemi/dps-randomcolorscheme",

  lazy = false,
  dependencies = {
    "vim-denops/denops.vim",
  },
  init = function()
    vim.g.randomcolorscheme_debug = false
    vim.g.randomcolorscheme_echo = true
    vim.g.randomcolorscheme_interval = 600
    vim.g.randomcolorscheme_events = { "FocusLost" }
    vim.g.randomcolorscheme_path = vim.fn.expand("~/.cache/randomcolorscheme/colors.toml")
    vim.keymap.set("n", "<space>co", "<cmd>ChangeColorscheme<cr>")
    vim.keymap.set("n", "<space>cn", "<cmd>DisableThisColorscheme<cr>")
  end,
}
