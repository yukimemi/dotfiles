return {
  "Omochice/dps-translate-vim",

  enabled = true,

  lazy = false,

  init = function()
    vim.g.dps_translate_source = "en"
    vim.g.dps_translate_target = "ja"
  end,

  dependencies = {
    "vim-denops/denops.vim",
  },
}
