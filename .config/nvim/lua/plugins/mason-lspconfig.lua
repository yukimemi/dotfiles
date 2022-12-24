return {
  "williamboman/mason-lspconfig.nvim",

  enabled = true,

  dependencies = {
    "williamboman/mason.nvim",
    "neovim/nvim-lspconfig",
  },

  config = function()
    require("mason-lspconfig").setup({
      ensure_installed = { "sumneko_lua", "rust_analyzer", "denols", "gopls", "jsonls" },
      automatic_installation = true,
    })
  end,
}

