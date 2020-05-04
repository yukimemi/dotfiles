au MyAutoCmd CmdwinEnter * call <SID>init_cmdwin()
function! s:init_cmdwin() abort
  inoremap <buffer> <expr> <space> ambicmd#expand("\<space>")
  inoremap <buffer> <expr> <cr>    ambicmd#expand("\<cr>")
  " startinsert!
endfunction
