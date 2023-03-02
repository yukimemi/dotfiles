return {
  "skanehira/denops-openai.vim",

  lazy = false,

  dependencies = {
    "vim-denops/denops.vim",
  },

  init = function()
    vim.g.openai_config = { apiKey = vim.env.OPENAI_API_KEY }

    vim.api.nvim_create_autocmd("BufRead", {
      group = "MyAutoCmd",
      pattern = "openai://*",
      callback = function()
        vim.bo.swap = false
      end,
    })
  end,
}
