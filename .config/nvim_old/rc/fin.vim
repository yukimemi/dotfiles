" au MyAutoCmd FileType qf,quickfix Fin
au MyAutoCmd FileType qf,quickfix call <SID>my_fin_cfg()

function! s:my_fin_cfg() abort
  imap <buffer> <c-k> <Plug>(fin-line-prev)
  imap <buffer> <c-j> <Plug>(fin-line-next)
endfunction

