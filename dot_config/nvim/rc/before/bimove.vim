" =============================================================================
" File        : biomove.vim
" Author      : yukimemi
" Last Change : 2025/10/25 23:46:33.
" =============================================================================

nnoremap M <Plug>(bimove-enter)<Plug>(bimove)

nnoremap <Plug>(bimove)H <Plug>(bimove-high)<Plug>(bimove)
nnoremap <Plug>(bimove)L <Plug>(bimove-low)<Plug>(bimove)

highlight link BimoveHigh Search
highlight link BimoveCursor Visual
highlight link BimoveLow Visual
