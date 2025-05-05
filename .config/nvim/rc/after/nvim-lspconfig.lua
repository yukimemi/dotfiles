-- =============================================================================
-- File        : nvim-lspconfig.lua
-- Author      : yukimemi
-- Last Change : 2025/05/05 20:47:03.
-- =============================================================================

vim.lsp.config('*', {
  capabilities = require('cmp_nvim_lsp').default_capabilities(),
})

vim.lsp.enable(require('mason-lspconfig').get_installed_servers())
