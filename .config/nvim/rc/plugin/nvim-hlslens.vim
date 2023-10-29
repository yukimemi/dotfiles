if !IsInstalled('nvim-hlslens')
  finish
endif

lua << EOF
require('hlslens').setup({
  calm_down = true,
  nearest_only = true,
  nearest_float_when = 'always'
})
EOF

if IsInstalled('vim-asterisk')
  Keymap n / <Cmd>lua require('hlslens').enable()<CR>/
  Keymap n ? <Cmd>lua require('hlslens').enable()<CR>?
  Keymap nx <silent> n <Cmd>lua require('hlslens').enable()<CR><Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR><Plug>(anzu-update-search-status)zzzv
  Keymap nx <silent> N <Cmd>lua require('hlslens').enable()<CR><Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR><Plug>(anzu-update-search-status)zzzv
  Keymap nx <silent> * <Cmd>lua require('hlslens').enable()<CR><Plug>(asterisk-z*)<Cmd>lua require('hlslens').start()<CR><Plug>(anzu-update-search-status)
  Keymap nx <silent> # <Cmd>lua require('hlslens').enable()<CR><Plug>(asterisk-z#)<Cmd>lua require('hlslens').start()<CR><Plug>(anzu-update-search-status)
  Keymap nx <silent> g* <Cmd>lua require('hlslens').enable()<CR><Plug>(asterisk-gz*)<Cmd>lua require('hlslens').start()<CR><Plug>(anzu-update-search-status)
  Keymap nx <silent> g# <Cmd>lua require('hlslens').enable()<CR><Plug>(asterisk-gz#)<Cmd>lua require('hlslens').start()<CR><Plug>(anzu-update-search-status)
else
  Keymap n / <Cmd>lua require('hlslens').enable()<CR>/
  Keymap n ? <Cmd>lua require('hlslens').enable()<CR>?
  Keymap nx <silent> n <Cmd>lua require('hlslens').enable()<CR><Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR><Plug>(anzu-update-search-status)zzzv
  Keymap nx <silent> N <Cmd>lua require('hlslens').enable()<CR><Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR><Plug>(anzu-update-search-status)zzzv
  Keymap nx <silent> * <Cmd>lua require('hlslens').enable()<CR><Cmd>lua require('hlslens').start()<CR><Plug>(anzu-update-search-status)
  Keymap nx <silent> # <Cmd>lua require('hlslens').enable()<CR><Cmd>lua require('hlslens').start()<CR><Plug>(anzu-update-search-status)
  Keymap nx <silent> g* <Cmd>lua require('hlslens').enable()<CR><Cmd>lua require('hlslens').start()<CR><Plug>(anzu-update-search-status)
  Keymap nx <silent> g# <Cmd>lua require('hlslens').enable()<CR><Cmd>lua require('hlslens').start()<CR><Plug>(anzu-update-search-status)
endif

silent! packadd nvim-hlslens
