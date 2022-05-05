if !g:plugin_use_nvimlsp
  finish
endif

lua << EOF
require("nvim-lsp-installer").setup({
  ensure_installed = { 'pyright', 'rust_analyzer', 'sumneko_lua' }, -- ensure these servers are always installed
  automatic_installation = true, -- automatically detect which servers to install (based on which servers are set up via lspconfig)
  ui = {
    icons = {
      server_installed = "✓",
      server_pending = "➜",
      server_uninstalled = "✗"
    }
  }
})
EOF
