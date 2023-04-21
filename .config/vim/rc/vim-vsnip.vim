Keymap is <expr> <c-j>   vsnip#available(1)  ? '<Plug>(vsnip-expand)'         : '<c-j>'
Keymap is <expr> <c-k>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<c-k>'
Keymap is <expr> <Tab>   vsnip#available(1)  ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
Keymap is <expr> <S-Tab> vsnip#available(-1) ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'

if g:plugin_use_ddc
  au MyAutoCmd User PumCompleteDone call vsnip_integ#on_complete_done(g:pum#completed_item)
endif
