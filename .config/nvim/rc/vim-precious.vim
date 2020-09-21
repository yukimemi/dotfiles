let g:precious_enable_switch_CursorMoved = { '*': 0, 'help': 1 }
au MyAutoCmd InsertEnter * PreciousSwitch
au MyAutoCmd InsertLeave * PreciousReset

