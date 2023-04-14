return {
  "uga-rosa/scorpeon.vim",

  enabled = false,

  lazy = false,

  dependencies = {
    "vim-denops/denops.vim",

    {
      "oovm/vscode-toml",
      cond = false,
    },
    {
      "emilast/vscode-logfile-highlighter",
      cond = false,
    }
  },

  init = function()
    vim.g.scorpeon_extensions_path = vim.fn.stdpath("data") .. "/lazy"
  end,
}
