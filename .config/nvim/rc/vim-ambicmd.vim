let g:ambicmd#show_completion_menu = 1

Keymap c <expr> <space> ambicmd#expand("\<space>")
Keymap c <expr> <cr>    ambicmd#expand("\<cr>")
Keymap c <expr> <c-f>   ambicmd#expand("\<right>")

au MyAutoCmd CmdwinEnter * call <SID>init_cmdwin()
function! s:init_cmdwin() abort
  Keymap i <buffer> <expr> <space> ambicmd#expand("\<space>")
  Keymap i <buffer> <expr> <cr>    ambicmd#expand("\<cr>")
  " startinsert!
endfunction


