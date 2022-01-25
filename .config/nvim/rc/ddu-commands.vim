" Specify name
nnoremap <leader>df <cmd>Ddu files<cr>
nnoremap <leader>du <cmd>Ddu mr<cr>
nnoremap <leader>dc <cmd>Ddu colorscheme<cr>

nnoremap <leader>dh <cmd>Ddu file_rec -path=expand('~')<cr>
nnoremap <leader>dD <cmd>Ddu file_rec -path=expand('~/.dotfiles')<cr>
nnoremap <leader>dd <cmd>Ddu file_rec -path=expand('%:p:h')<cr>

nnoremap <localleader>/ <cmd>Ddu -name=search line -ui-param-startFilter=v:true<cr>

" Specify source with params
" nnoremap <leader>dh <cmd>Ddu file_rec
