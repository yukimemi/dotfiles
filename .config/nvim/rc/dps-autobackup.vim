let g:autobackup_debug = v:false

let g:autobackup_enable = v:true
let g:autobackup_write_echo = v:true
let g:autobackup_dir = $CACHE_HOME .. "/autobackup"

let g:autobackup_events = ["CursorHold", "CursorHoldI", "BufWritePre"]

