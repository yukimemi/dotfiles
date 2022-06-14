let g:autocursor_debug = v:false
let g:autocursor_blacklist_filetypes = ["list"]
let g:autocursor_fix_interval = 10000
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
  \     "wait": 100,
  \   },
  \   {
  \     "name": "FocusLost",
  \     "set": v:true,
  \     "wait": 100,
  \   },
  \   {
  \     "name": "WinEnter",
  \     "set": v:true,
  \     "wait": 100,
  \   },
  \   {
  \     "name": "BufEnter",
  \     "set": v:true,
  \     "wait": 100,
  \   },
  \   {
  \     "name": "CmdwinLeave",
  \     "set": v:true,
  \     "wait": 100,
  \   },
  \   {
  \     "name": "CursorHold",
  \     "set": v:true,
  \     "wait": 100,
  \   },
  \   {
  \     "name": "CursorHoldI",
  \     "set": v:true,
  \     "wait": 100,
  \   },
  \   {
  \     "name": "DirChanged",
  \     "set": v:true,
  \     "wait": 100,
  \   },
  \   {
  \     "name": "VimResized",
  \     "set": v:true,
  \     "wait": 100,
  \   },
  \   {
  \     "name": "InsertLeave",
  \     "set": v:true,
  \     "wait": 100,
  \   },
  \   {
  \     "name": "ModeChanged",
  \     "set": v:true,
  \     "wait": 100,
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
