require("mason-lspconfig").setup()

vim.lsp.enable(require('mason-lspconfig').get_installed_servers())

