let g:autocursor_debug = v:false
let g:autocursor_blacklist_filetypes = ["list", "ctrlp", "ddu-ff", "ddu-ff-filter", "ddu-filer", "dpswalk", "qf", "quickfix"]
let g:autocursor_fix_interval = 30000
let g:autocursor_cursorline = {
  \ "enable": v:true,
  \ "events": [
  \   {
  \     "name": "FocusGained",
  \     "set": v:true,
  \     "wait": 0,
  \   },
  \   {
  \     "name": "FocusLost",
  \     "set": v:true,
  \     "wait": 0,
  \   },
  \   {
  \     "name": "WinEnter",
  \     "set": v:true,
  \     "wait": 0,
  \   },
  \   {
  \     "name": "BufEnter",
  \     "set": v:true,
  \     "wait": 0,
  \   },
  \   {
  \     "name": "CmdwinLeave",
  \     "set": v:true,
  \     "wait": 0,
  \   },
  \   {
  \     "name": "CursorHold",
  \     "set": v:true,
  \     "wait": 0,
  \   },
  \   {
  \     "name": "CursorHoldI",
  \     "set": v:true,
  \     "wait": 0,
  \   },
  \   {
  \     "name": "DirChanged",
  \     "set": v:true,
  \     "wait": 0,
  \   },
  \   {
  \     "name": "VimResized",
  \     "set": v:true,
  \     "wait": 0,
  \   },
  \   {
  \     "name": "InsertLeave",
  \     "set": v:true,
  \     "wait": 0,
  \   },
  \   {
  \     "name": "ModeChanged",
  \     "set": v:true,
  \     "wait": 0,
  \   },
  \   {
  \     "name": "CursorMoved",
  \     "set": v:false,
  \     "wait": 300,
  \   },
  \   {
  \     "name": "CursorMovedI",
  \     "set": v:false,
  \     "wait": 300,
  \   }
  \  ]
  \ }
let g:autocursor_cursorcolumn = {
  \ "enable": v:true,
  \ "events": [
  \   {
  \     "name": "FocusGained",
  \     "set": v:true,
  \     "wait": 300,
  \   },
  \   {
  \     "name": "FocusLost",
  \     "set": v:true,
  \     "wait": 300,
  \   },
  \   {
  \     "name": "WinEnter",
  \     "set": v:true,
  \     "wait": 300,
  \   },
  \   {
  \     "name": "BufEnter",
  \     "set": v:true,
  \     "wait": 300,
  \   },
  \   {
  \     "name": "CmdwinLeave",
  \     "set": v:true,
  \     "wait": 300,
  \   },
  \   {
  \     "name": "CursorHold",
  \     "set": v:true,
  \     "wait": 300,
  \   },
  \   {
  \     "name": "CursorHoldI",
  \     "set": v:true,
  \     "wait": 300,
  \   },
  \   {
  \     "name": "DirChanged",
  \     "set": v:true,
  \     "wait": 300,
  \   },
  \   {
  \     "name": "VimResized",
  \     "set": v:true,
  \     "wait": 300,
  \   },
  \   {
  \     "name": "InsertLeave",
  \     "set": v:true,
  \     "wait": 300,
  \   },
  \   {
  \     "name": "ModeChanged",
  \     "set": v:true,
  \     "wait": 300,
  \   },
  \   {
  \     "name": "CursorMoved",
  \     "set": v:false,
  \     "wait": 500,
  \   },
  \   {
  \     "name": "CursorMovedI",
  \     "set": v:false,
  \     "wait": 500,
  \   }
  \  ]
  \ }
