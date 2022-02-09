" Specify name
" nnoremap <leader>df <cmd>Ddu files<cr>
" nnoremap <leader>du <cmd>Ddu mr<cr>
" nnoremap <leader>dc <cmd>Ddu colorscheme<cr>
"
" nnoremap <leader>dh <cmd>Ddu file_rec -path=expand('~')<cr>
" nnoremap <leader>dD <cmd>Ddu file_rec -path=expand('~/.dotfiles')<cr>
" nnoremap <leader>dd <cmd>Ddu file_rec -path=expand('%:p:h')<cr>
"
" nnoremap <localleader>/ <cmd>Ddu -name=search line -ui-param-startFilter=v:true<cr>

" Specify source with params
" nnoremap <leader>dh <cmd>Ddu file_rec

nnoremap <silent> <leader>du <Cmd>Ddu mr -ui-param-startFilter=v:true<CR>
nnoremap <silent> <leader>db <Cmd>Ddu buffer -ui-param-startFilter=v:false<CR>
nnoremap <silent> <leader>dc <Cmd>Ddu colorscheme -ui-param-startFilter=v:true<CR>
" nnoremap <silent> <leader>ds <Cmd>Ddu -name=files file_rec -source-param-path='`fnamemodify($MYVIMRC, ':h').'/rc'`'<CR>
nnoremap <silent> <leader>df <Cmd>Ddu -name=files file_old `finddir('.git', ';') != '' ? 'file_external' : 'file_rec'`<CR>
nnoremap <silent> <leader>d/ <Cmd>Ddu -name=search line -ui-param-startFilter=v:true<CR>
nnoremap <silent> <leader>d* <Cmd>Ddu -name=search line -input=`expand('<cword>')` -ui-param-startFilter=v:false<CR>
nnoremap <silent> <leader>ds <Cmd>Ddu -name=search rg -source-param-input=`input('Pattern: ')`<CR>
nnoremap <silent> <leader>dn <Cmd>Ddu -name=search -resume -ui-param-startFilter=v:false<CR>
nnoremap <silent> <leader>dR <Cmd>Ddu -buffer-name=register register<CR>
nnoremap <silent> <leader>dr <Cmd>Ddu -resume<CR>
