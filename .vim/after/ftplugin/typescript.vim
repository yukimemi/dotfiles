setl fenc=utf8 ff=unix

setl ballooneval
au MyAutoCmd FileType typescript setlocal balloonexpr=tsuquyomi#balloonexpr()
au MyAutoCmd FileType typescript nnoremap <buffer> <Leader>t :<C-u>echo tsuquyomi#hint()<CR>

