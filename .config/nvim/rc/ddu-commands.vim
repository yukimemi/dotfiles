" Specify name
" Keymap n <leader>df <cmd>Ddu files<cr>
" Keymap n <leader>du <cmd>Ddu mr<cr>
" Keymap n <leader>dc <cmd>Ddu colorscheme<cr>
"
" Keymap n <leader>dh <cmd>Ddu file_rec -path=expand('~')<cr>
" Keymap n <leader>dd <cmd>Ddu file_rec -path=expand('%:p:h')<cr>
"
" Keymap n <localleader>/ <cmd>Ddu -name=search line -ui-param-startFilter=v:true<cr>

" Specify source with params
" Keymap n <leader>dh <cmd>Ddu file_rec

Keymap n <silent> <leader>du <cmd>Ddu mr -ui-param-startFilter=v:true<cr>
Keymap n <silent> <leader>db <cmd>Ddu buffer -ui-param-startFilter=v:false<cr>
Keymap n <silent> <leader>dc <cmd>Ddu colorscheme -ui-param-startFilter=v:true<cr>
Keymap n <silent> <leader>df <cmd>Ddu -name=files file_point file_old `finddir('.git', ';') != '' ? 'file_external' : 'file_rec'` -ui-param-displaySourceName=short -ui-param-startFilter=v:true<cr>
Keymap n <silent> <leader>d/ <cmd>Ddu -name=search line -ui-param-startFilter=v:true<cr>
Keymap n <silent> <leader>d* <cmd>Ddu -name=search line -input=`expand('<cword>')` -ui-param-startFilter=v:false<cr>
Keymap n <silent> <leader>dn <cmd>Ddu -name=search -resume -ui-param-startFilter=v:false<cr>
Keymap n <silent> <leader>dR <cmd>Ddu -buffer-name=register register -ui-param-autoResize<cr>
" Keymap n <silent> <leader>dD <cmd>Ddu file_rec -source-param-path=`expand('~/.dotfiles')` -ui-param-startFilter=v:true<cr>
" Keymap n <silent> <leader>dm <cmd>Ddu file_rec -source-param-path=`expand('~/.memolist')` -ui-param-startFilter=v:true<cr>
Keymap n <silent> <leader>dD <cmd>Ddu file_rec -source-param-path='~/.dotfiles' -ui-param-startFilter=v:true<cr>
Keymap n <silent> <leader>dm <cmd>Ddu file_rec -source-param-path='~/.memolist' -ui-param-startFilter=v:true<cr>

" Search.
Keymap n <silent> <leader>ds <cmd>Ddu -name=search rg -ui-param-ignoreEmpty -source-param-input=`input('Pattern: ')`<cr>
Keymap n <silent> <leader>drs <cmd>Ddu -name=search -resume<cr>
