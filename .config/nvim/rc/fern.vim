" Don't use netrw.
let g:loaded_netrwPlugin = 1
let g:fern#default_hidden = 1

nnoremap <silent> ge :<c-u>exe printf("Fern file:///%s -drawer -reveal=%s", expand("%:p:h"), expand("%:t"))<cr>

" fern-bookmark.vim
" let g:fern#mapping#bookmark#disable_default_mappings = 0

" fern-renderer-devicons.vim
let g:fern#renderer = "devicons"

" fern-comparator-lexical.vim
" let g:fern#comparator = "lexical"

