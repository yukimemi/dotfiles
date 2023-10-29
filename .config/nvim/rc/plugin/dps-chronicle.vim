" hook_add {{{
const g:chronicle_echo = v:false
const g:chronicle_notify = v:true
const g:chronicle_read_path = '~/.cache/chronicle/read'
const g:chronicle_write_path = '~/.cache/chronicle/write'
Keymap n mr <cmd>OpenChronicleRead<cr>
Keymap n me <cmd>OpenChronicleWrite<cr>
Keymap n mo <cmd>copen<cr>
" }}}
