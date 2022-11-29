if !g:plugin_use_fern
  finish
endif

" Don't use netrw.
let g:loaded_netrwPlugin = 1
let g:fern#default_hidden = 1

Keymap n <silent> gE <cmd>exe printf("Fern file:///%s -drawer -reveal=%s", expand("%:p:h"), expand("%:t"))<cr>
Keymap n <silent> ge <cmd>Fern . -reveal=% -drawer -width=40<cr>

" fern-bookmark.vim
" let g:fern#mapping#bookmark#disable_default_mappings = 0

" fern-renderer-nerdfont.vim
let g:fern#renderer = "nerdfont"

" fern-comparator-lexical.vim
" let g:fern#comparator = "lexical"

" ctrlp-fern-action.vim
" au MyAutoCmd FileType fern nnoremap ; <buffer> <cmd>CtrlPFernAction<cr>

function! s:init_fern() abort
  Keymap n <buffer><expr> <Plug>(fern-my-open-or-expand-or-collapse)
        \ fern#smart#leaf(
        \   "\<Plug>(fern-action-open)",
        \   "\<Plug>(fern-action-expand)",
        \   "\<Plug>(fern-action-collapse)",
        \ )

  Keymap n <buffer> n <Nop>
  Keymap n <buffer> s <Nop>
  Keymap n <buffer> <c-l> <c-w>l
  Keymap n <buffer> S <Plug>(fern-action-open:select)
  Keymap n <buffer> o <Plug>(fern-my-open-or-expand-or-collapse)
  Keymap n <buffer> h <Plug>(fern-action-leave)
endfunction

au MyAutoCmd FileType fern call <SID>init_fern()
