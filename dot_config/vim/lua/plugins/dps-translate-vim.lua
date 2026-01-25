return {
  "Omochice/dps-translate-vim",

  enabled = false,

  lazy = false,

  init = function()
    vim.g.dps_translate_source = "en"
    vim.g.dps_translate_target = "ja"
  end,

  dependencies = {
    "vim-denops/denops.vim",
  },
}
