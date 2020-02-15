if !IsInstalled("autoload/lexima.vim")
  finish
endif

" au MyAutoCmd InsertEnter * inoremap <expr> <cr> pumvisible() ? "\<c-y>\<cr>" : lexima#expand('<cr>', 'i')

packadd lexima.vim
call lexima#init()
inoremap <expr> <cr> pumvisible() ? "\<c-y>" .  lexima#expand('<cr>', 'i') : lexima#expand('<cr>', 'i')

