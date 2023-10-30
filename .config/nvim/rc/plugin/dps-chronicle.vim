" hook_add {{{
let g:chronicle_echo = v:false
let g:chronicle_notify = v:true
let g:chronicle_read_path = '~/.cache/chronicle/read'
let g:chronicle_write_path = '~/.cache/chronicle/write'
Keymap n mr <cmd>OpenChronicleRead<cr>
Keymap n me <cmd>OpenChronicleWrite<cr>
Keymap n mo <cmd>copen<cr>
" }}}
