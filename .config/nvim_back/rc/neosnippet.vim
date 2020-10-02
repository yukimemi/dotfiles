imap <c-k> <Plug>(neosnippet_expand_or_jump)
smap <c-k> <Plug>(neosnippet_expand_or_jump)
xmap <c-k> <Plug>(neosnippet_expand_target)
" Tell Neosnippet about the other snippets
let g:neosnippet#snippets_directory = $VIM_PATH . '/snippets'

" For snippet_complete marker.
if has('conceal')
  set conceallevel=2 concealcursor=i
endif

