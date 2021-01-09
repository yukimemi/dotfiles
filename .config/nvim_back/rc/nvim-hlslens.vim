if !IsInstalled('nvim-hlslens')
  finish
endif

noremap <silent> n <cmd>execute('normal! ' . v:count1 . 'nzv')<cr> <cmd>lua require('hlslens').start()<cr>
noremap <silent> N <cmd>execute('normal! ' . v:count1 . 'Nzv')<cr> <cmd>lua require('hlslens').start()<cr>

if IsInstalled('vim-asterisk')
  map *  <Plug>(asterisk-z*)zv<cmd>lua require('hlslens').start()<cr>
  map #  <Plug>(asterisk-z#)zv<cmd>lua require('hlslens').start()<cr>
  map g* <Plug>(asterisk-gz*)zv<cmd>lua require('hlslens').start()<cr>
  map g# <Plug>(asterisk-gz#)zv<cmd>lua require('hlslens').start()<cr>
else
  noremap * *<cmd>lua require('hlslens').start()<cr>
  noremap # #<cmd>lua require('hlslens').start()<cr>
  noremap g* g*<cmd>lua require('hlslens').start()<cr>
  noremap g# g#<cmd>lua require('hlslens').start()<cr>
endif

silent! packadd nvim-hlslens
