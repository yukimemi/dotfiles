-- =============================================================================
-- File        : after.lua
-- Author      : yukimemi
-- Last Change : 2026/04/20 01:10:06.
-- =============================================================================

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

-- blink.cmp の capabilities を全 LSP サーバーに適用
local capabilities = require('blink.cmp').get_lsp_capabilities()
vim.lsp.config('*', { capabilities = capabilities })
