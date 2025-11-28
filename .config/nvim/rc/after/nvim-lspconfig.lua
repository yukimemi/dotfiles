-- =============================================================================
-- File        : nvim-lspconfig.lua
-- Author      : yukimemi
-- Last Change : 2025/11/28 21:35:05.
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

vim.lsp.enable(require('mason-lspconfig').get_installed_servers())

vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, { desc = "Code Action" })
