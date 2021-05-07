if !IsInstalled('vim-ambicmd')
  finish
endif

let g:ambicmd#show_completion_menu = 1

cnoremap <expr> <space> ambicmd#expand("\<space>")
cnoremap <expr> <cr>    ambicmd#expand("\<cr>")
cnoremap <expr> <c-f>   ambicmd#expand("\<right>")

au MyAutoCmd CmdwinEnter * call <SID>init_cmdwin()
function! s:init_cmdwin() abort
  inoremap <buffer> <expr> <space> ambicmd#expand("\<space>")
  inoremap <buffer> <expr> <cr>    ambicmd#expand("\<cr>")
  " startinsert!
endfunction


