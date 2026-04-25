require('hover').config({
  providers = {
    'hover.providers.diagnostic',
    'hover.providers.lsp',
    'hover.providers.dap',
    'hover.providers.man',
    'hover.providers.dictionary',
  },
  preview_opts = {
    border = 'single'
  },
  preview_window = false,
  title = true,
})
