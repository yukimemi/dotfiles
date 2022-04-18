" Specify name
" Keymap n <leader>df <cmd>Ddu files<cr>
" Keymap n <leader>du <cmd>Ddu mr<cr>
" Keymap n <leader>dc <cmd>Ddu colorscheme<cr>
"
" Keymap n <leader>dh <cmd>Ddu file_rec -path=expand('~')<cr>
" Keymap n <leader>dD <cmd>Ddu file_rec -path=expand('~/.dotfiles')<cr>
" Keymap n <leader>dd <cmd>Ddu file_rec -path=expand('%:p:h')<cr>
"
" Keymap n <localleader>/ <cmd>Ddu -name=search line -ui-param-startFilter=v:true<cr>

" Specify source with params
" Keymap n <leader>dh <cmd>Ddu file_rec

Keymap n <silent> <leader>du <Cmd>Ddu mr -ui-param-startFilter=v:true<CR>
Keymap n <silent> <leader>db <Cmd>Ddu buffer -ui-param-startFilter=v:false<CR>
Keymap n <silent> <leader>dc <Cmd>Ddu colorscheme -ui-param-startFilter=v:true<CR>
Keymap n <silent> <leader>df <Cmd>Ddu -name=files file_point file_old `finddir('.git', ';') != '' ? 'file_external' : 'file_rec'` -ui-param-displaySourceName=short<CR>
Keymap n <silent> <leader>d/ <Cmd>Ddu -name=search line -ui-param-startFilter=v:true<CR>
Keymap n <silent> <leader>d* <Cmd>Ddu -name=search line -input=`expand('<cword>')` -ui-param-startFilter=v:false<CR>
Keymap n <silent> <leader>dn <Cmd>Ddu -name=search -resume -ui-param-startFilter=v:false<CR>
Keymap n <silent> <leader>dR <Cmd>Ddu -buffer-name=register register -ui-param-autoResize<CR>

" Search.
Keymap n <silent> <leader>ds <Cmd>Ddu -name=search rg -ui-param-ignoreEmpty -source-param-input=`input('Pattern: ')`<CR>
Keymap n <silent> <leader>drs <Cmd>Ddu -name=search -resume<CR>
