" Don't use netrw.
let g:loaded_netrwPlugin = 1
nnoremap <silent> ge :<C-u>Fila . -drawer -reveal=<C-r>=expand('%')<CR><CR>
