-- =============================================================================
-- File        : nvim-lspconfig.lua
-- Author      : yukimemi
-- Last Change : 2025/08/24 09:20:47.
-- =============================================================================

vim.lsp.config('*', {
  root_markers = { '.git' },
  -- capabilities = require('cmp_nvim_lsp').default_capabilities(),
  -- capabilities = require('blink.cmp').get_lsp_capabilities(),
})

vim.api.nvim_create_user_command('LspHealth', function()
  vim.cmd.checkhealth('vim.lsp')
end, { desc = 'LSP health check' })

local function diagnostic_format(diagnostic)
  return string.format('%s (%s)', diagnostic.message, diagnostic.source)
end

vim.diagnostic.config({
  severity_sort = true,
  virtual_text = { format = diagnostic_format },
  float = { format = diagnostic_format },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = '',
      [vim.diagnostic.severity.WARN] = '',
      [vim.diagnostic.severity.INFO] = '',
      [vim.diagnostic.severity.HINT] = '',
    },
  },
})

vim.lsp.enable(require('mason-lspconfig').get_installed_servers())
