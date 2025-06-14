-- =============================================================================
-- File        : mason-lspconfig.lua
-- Author      : yukimemi
-- Last Change : 2025/05/10 21:45:17.
-- =============================================================================

local servers = {
  "lua_ls",
  "denols",
  "lua_ls",
  "powershell_es",
  "rust_analyzer",
  "taplo",
}

require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = servers,
  automatic_enable = true,
})
