let g:autobackup_debug = v:false

let g:autobackup_enable = v:true
let g:autobackup_write_echo = v:false
let g:autobackup_dir = $BACKUP_PATH .. '/autobackup'

let g:autobackup_events = ["CursorHold", "CursorHoldI", "BufWritePre"]
let g:autobackup_blacklist_filetypes = ["log", "csv"]

