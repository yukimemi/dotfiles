imap <expr> <c-j>   vsnip#available(1)  ? '<Plug>(vsnip-expand)'         : '<c-j>'
imap <expr> <c-k>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<c-k>'
smap <expr> <c-k>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<c-k>'
imap <expr> <Tab>   vsnip#available(1)  ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
smap <expr> <Tab>   vsnip#available(1)  ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
imap <expr> <S-Tab> vsnip#available(-1) ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'
smap <expr> <S-Tab> vsnip#available(-1) ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'

au MyAutoCmd User PumCompleteDone call vsnip_integ#on_complete_done(g:pum#completed_item)
