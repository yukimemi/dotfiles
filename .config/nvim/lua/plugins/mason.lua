return {
  "williamboman/mason.nvim",

  enabled = true,

  cmd = "Mason",

  dependencies = {
    "williamboman/mason-lspconfig.nvim",
    config = {
      ensure_installed = { "sumneko_lua", "rust_analyzer", "denols", "gopls", "jsonls" },
      automatic_installation = true,
    },
  },

  config = {
    providers = {
      "mason.providers.client",
      "mason.providers.registry-api",
    },
  },
}
