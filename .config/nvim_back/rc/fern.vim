" Don't use netrw.
let g:loaded_netrwPlugin = 1
let g:fern#default_hidden = 1

nnoremap <silent> ge :<c-u>exe printf("Fern file:///%s -drawer -reveal=%s", expand("%:p:h"), expand("%:t"))<cr>

" fern-bookmark.vim
" let g:fern#mapping#bookmark#disable_default_mappings = 0

" fern-renderer-nerdfont.vim
let g:fern#renderer = "nerdfont"

" fern-comparator-lexical.vim
" let g:fern#comparator = "lexical"


function! s:init_fern() abort
  nmap <buffer><expr> <Plug>(fern-my-open-or-expand-or-collapse)
        \ fern#smart#leaf(
        \   "\<Plug>(fern-action-open)",
        \   "\<Plug>(fern-action-expand)",
        \   "\<Plug>(fern-action-collapse)",
        \ )

  nmap <buffer> s <Nop>
  nmap <buffer> S <Plug>(fern-action-open:select)
  nmap <buffer> o <Plug>(fern-my-open-or-expand-or-collapse)
endfunction

au MyAutoCmd FileType fern call <SID>init_fern()
