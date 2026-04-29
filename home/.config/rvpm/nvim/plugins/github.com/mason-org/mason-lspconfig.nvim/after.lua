-- =============================================================================
-- File        : after.lua
-- Author      : yukimemi
-- Last Change : 2026/04/20 01:10:06.
-- =============================================================================

require("mason-lspconfig").setup()

vim.lsp.enable(require('mason-lspconfig').get_installed_servers())
