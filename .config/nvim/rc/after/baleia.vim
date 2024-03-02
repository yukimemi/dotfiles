" =============================================================================
" File        : baleia.vim
" Author      : yukimemi
" Last Change : 2024/03/02 17:50:34.
" =============================================================================

let s:baleia = luaeval("require('baleia').setup { }")
command! BaleiaColorize call s:baleia.once(bufnr('%'))

