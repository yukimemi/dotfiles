" let g:autocursor_debug = v:true
let g:autocursor_cursorline = {
  \ "enable": v:true,
  \ "events": [
  \   {
  \     "name": "FocusGained",
  \     "set": v:true,
  \     "wait": 0,
  \   },
  \   {
  \     "name": "CursorHold",
  \     "set": v:true,
  \     "wait": 100,
  \   },
  \   {
  \     "name": "CursorMoved",
  \     "set": v:false,
  \     "wait": 500,
  \   }
  \  ]
  \ }
let g:autocursor_cursorcolumn = {
  \ "enable": v:true,
  \ "events": [
  \   {
  \     "name": "FocusGained",
  \     "set": v:true,
  \     "wait": 0,
  \   },
  \   {
  \     "name": "CursorHold",
  \     "set": v:true,
  \     "wait": 300,
  \   },
  \   {
  \     "name": "CursorMoved",
  \     "set": v:false,
  \     "wait": 500,
  \   }
  \  ]
  \ }
