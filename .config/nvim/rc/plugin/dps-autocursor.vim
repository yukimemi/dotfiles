" hook_add {{{
let g:autocursor_debug = v:false
let g:autocursor_ignore_filetypes = ["list", "ctrlp", "ddu-ff", "ddu-ff-filter", "ddu-filer", "dpswalk", "qf", "quickfix"]
let g:autocursor_fix_interval = 10000
let g:autocursor_throttle = 1000
let g:autocursor_cursorline = {
  \ "enable": v:true,
  \ "events": [
  \   {
  \     "name": "FocusGained",
  \     "set": v:true,
  \     "wait": 500,
  \   },
  \   {
  \     "name": "FocusLost",
  \     "set": v:true,
  \     "wait": 500,
  \   },
  \   {
  \     "name": "WinEnter",
  \     "set": v:true,
  \     "wait": 500,
  \   },
  \   {
  \     "name": "BufEnter",
  \     "set": v:true,
  \     "wait": 500,
  \   },
  \   {
  \     "name": "CmdwinLeave",
  \     "set": v:true,
  \     "wait": 500,
  \   },
  \   {
  \     "name": "CursorHold",
  \     "set": v:true,
  \     "wait": 500,
  \   },
  \   {
  \     "name": "CursorHoldI",
  \     "set": v:true,
  \     "wait": 500,
  \   },
  \   {
  \     "name": "DirChanged",
  \     "set": v:true,
  \     "wait": 500,
  \   },
  \   {
  \     "name": "VimResized",
  \     "set": v:true,
  \     "wait": 500,
  \   },
  \   {
  \     "name": "InsertLeave",
  \     "set": v:true,
  \     "wait": 500,
  \   },
  \   {
  \     "name": "CursorMoved",
  \     "set": v:false,
  \     "wait": 100,
  \   },
  \   {
  \     "name": "CursorMovedI",
  \     "set": v:false,
  \     "wait": 100,
  \   }
  \  ]
  \ }
let g:autocursor_cursorcolumn = {
  \ "enable": v:true,
  \ "events": [
  \   {
  \     "name": "FocusGained",
  \     "set": v:true,
  \     "wait": 600,
  \   },
  \   {
  \     "name": "FocusLost",
  \     "set": v:true,
  \     "wait": 600,
  \   },
  \   {
  \     "name": "WinEnter",
  \     "set": v:true,
  \     "wait": 600,
  \   },
  \   {
  \     "name": "BufEnter",
  \     "set": v:true,
  \     "wait": 600,
  \   },
  \   {
  \     "name": "CmdwinLeave",
  \     "set": v:true,
  \     "wait": 600,
  \   },
  \   {
  \     "name": "CursorHold",
  \     "set": v:true,
  \     "wait": 600,
  \   },
  \   {
  \     "name": "CursorHoldI",
  \     "set": v:true,
  \     "wait": 600,
  \   },
  \   {
  \     "name": "DirChanged",
  \     "set": v:true,
  \     "wait": 600,
  \   },
  \   {
  \     "name": "VimResized",
  \     "set": v:true,
  \     "wait": 600,
  \   },
  \   {
  \     "name": "InsertLeave",
  \     "set": v:true,
  \     "wait": 600,
  \   },
  \   {
  \     "name": "CursorMoved",
  \     "set": v:false,
  \     "wait": 100,
  \   },
  \   {
  \     "name": "CursorMovedI",
  \     "set": v:false,
  \     "wait": 100,
  \   }
  \  ]
  \ }
" }}}
