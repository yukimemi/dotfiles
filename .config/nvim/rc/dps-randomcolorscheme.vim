let g:randomcolorscheme_debug = v:false
let g:randomcolorscheme_echo = v:true
let g:randomcolorscheme_interval = 180
" let g:randomcolorscheme_background = "dark"
" let g:randomcolorscheme_match = "dark"
let g:randomcolorscheme_notmatch = "light"
let g:randomcolorscheme_disables = ["evening", "default"]
let g:randomcolorscheme_events = ["FocusLost", "BufWritePost", "BufRead"]

Keymap n <space>co <cmd>ChangeColorscheme<cr>
