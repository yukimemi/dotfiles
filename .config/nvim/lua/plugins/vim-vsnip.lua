return {
  "hrsh7th/vim-vsnip",

  dependencies = {
    "hrsh7th/vim-vsnip-integ",
    "rafamadriz/friendly-snippets",
  },

  config = function()
    local util = require("util")
    vim.keymap.set({ "i", "s" }, "<Tab>", function()
      if (vim.fn["vsnip#available"](1) or vim.fn["vsnip#jumpable"](1)) then
        vim.api.nvim_feedkeys(util.t('<Plug>(vsnip-jump-next)'), "n", false)
      else
        vim.api.nvim_feedkeys(util.t('<Tab>'), "n", false)
      end
    end)
    vim.keymap.set({ "i", "s" }, "<S-Tab>", function()
      if (vim.fn["vsnip#available"](1) or vim.fn["vsnip#jumpable"](-1)) then
        vim.api.nvim_feedkeys(util.t('<Plug>(vsnip-jump-prev)'), "n", false)
      else
        vim.api.nvim_feedkeys(util.t('<S-Tab>'), "n", false)
      end
    end)
  end,
}
