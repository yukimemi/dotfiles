" hook_add {{{
let g:autobackup_debug = v:false

let g:autobackup_enable = v:true
let g:autobackup_write_echo = v:false
let g:autobackup_dir = $BACKUP_PATH .. '/autobackup'

let g:autobackup_events = ["CursorHold", "CursorHoldI", "BufWritePre", "FocusLost", "FocusGained", "InsertLeave"]
let g:autobackup_ignore_filetypes = ["log", "csv"]
" }}}
