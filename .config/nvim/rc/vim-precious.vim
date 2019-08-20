let g:precious_enable_switch_CursorMoved = { '*': 0, 'help': 1 }
au MyAutoCmd InsertEnter * :packadd vim-precious PreciousSwitch
au MyAutoCmd InsertLeave * :packadd vim-precious PreciousReset

