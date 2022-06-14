Keymap i <expr> <c-j>   vsnip#available(1)  ? '<Plug>(vsnip-expand)'         : '<c-j>'
Keymap i <expr> <c-k>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<c-k>'
Keymap s <expr> <c-k>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<c-k>'
Keymap i <expr> <Tab>   vsnip#available(1)  ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
Keymap s <expr> <Tab>   vsnip#available(1)  ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
Keymap i <expr> <S-Tab> vsnip#available(-1) ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'
Keymap s <expr> <S-Tab> vsnip#available(-1) ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'

au MyAutoCmd User PumCompleteDone call vsnip_integ#on_complete_done(g:pum#completed_item)
