augroup qfopen-bufenter
  function! s:qfopen_keymap() abort
    Keymap n <buffer> a <Plug>(qfopen-action)
    Keymap n <buffer> <C-v> <Plug>(qfopen-open-vsplit)
    Keymap n <buffer> <C-x> <Plug>(qfopen-open-split)
    Keymap n <buffer> <C-t> <Plug>(qfopen-open-tab)
  endfunction
  au!
  au FileType quickfix,qf call s:qfopen_keymap()
augroup END
