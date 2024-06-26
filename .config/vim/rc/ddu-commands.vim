if !g:plugin_use_ddu
  finish
endif

Keymap n <silent> <leader>du <cmd>Ddu mr -ui-param-startFilter=v:true<cr>
Keymap n <silent> <leader>dw <cmd>Ddu mr -source-param-kind='mrw' -ui-param-startFilter=v:true<cr>
Keymap n <silent> <leader>db <cmd>Ddu buffer -ui-param-startFilter=v:false<cr>
Keymap n <silent> <leader>df <cmd>Ddu -name=files file_point file_old `finddir('.git', ';') != '' ? 'file_external' : 'file_rec'` -ui-param-displaySourceName=short -ui-param-startFilter=v:true<cr>
Keymap n <silent> <leader>d/ <cmd>Ddu -name=search line -ui-param-startFilter=v:true<cr>
Keymap n <silent> <leader>d* <cmd>Ddu -name=search line -input=`expand('<cword>')` -ui-param-startFilter=v:false<cr>
Keymap n <silent> <leader>dn <cmd>Ddu -name=search -resume -ui-param-startFilter=v:false<cr>
Keymap n <silent> <leader>dR <cmd>Ddu -buffer-name=register register -ui-param-autoResize<cr>
Keymap n <silent> <leader>dd <cmd>Ddu file_rec -source-option-path=`fnamemodify(bufname(), ':p:h')` -ui-param-startFilter=v:true<cr>
Keymap n <silent> <leader>dc <cmd>Ddu file_rec -source-option-path=`expand('~/.cache')` -ui-param-startFilter=v:true<cr>
Keymap n <silent> <leader>dD <cmd>Ddu file_rec -source-option-path=`expand('~/.dotfiles')` -ui-param-startFilter=v:true<cr>
Keymap n <silent> <leader>dm <cmd>Ddu file_rec -source-option-path=`expand('~/.memolist')` -ui-param-startFilter=v:true<cr>
Keymap n <silent> <leader>dS <cmd>Ddu file_rec -source-option-path=`expand('~/src')` -ui-param-startFilter=v:true<cr>
Keymap n <silent> <leader>dH <cmd>Ddu help -ui-param-startFilter=v:true<cr>
Keymap n <silent> <leader>dh <cmd>Ddu command_history -ui-param-startFilter=v:true<cr>
Keymap c <expr><silent> <C-t> "<C-u><ESC><cmd>Ddu command_history -ui-param-startFilter -input='" . getcmdline() . "'<CR>"
Keymap n <silent> <leader>ds <cmd>Ddu -name=search rg -ui-param-ignoreEmpty -source-param-input=`input('Pattern: ')`<cr>
Keymap n <silent> <leader>dr <cmd>Ddu -name=search -resume<cr>
