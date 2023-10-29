" au MyAutoCmd InsertEnter * inoremap <expr> <cr> pumvisible() ? "\<c-y>\<cr>" : lexima#expand('<cr>', 'i')

silent! packadd lexima.vim
call lexima#init()
inoremap <expr> <cr> pumvisible() ? "\<c-y>" .  lexima#expand('<cr>', 'i') : lexima#expand('<cr>', 'i')

