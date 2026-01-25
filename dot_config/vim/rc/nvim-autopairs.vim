lua << EOF
require("nvim-autopairs").setup {}

-- If you want insert `(` after select function or method item
if vim.g.plugin_use_cmp then
  local cmp_autopairs = require('nvim-autopairs.completion.cmp')
  local cmp = require('cmp')
  cmp.event:on(
    'confirm_done',
    cmp_autopairs.on_confirm_done()
  )
end
EOF

" vim: ft=vim ts=2 sw=2 sts=2:
