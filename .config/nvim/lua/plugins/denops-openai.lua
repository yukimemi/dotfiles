return {
  "skanehira/denops-openai.vim",

  lazy = false,

  dependencies = {
    "vim-denops/denops.vim",
  },

  init = function()
    vim.g.openai_config = { apiKey = vim.env.OPENAI_API_KEY }
  end,
}
