let g:randomcolorscheme_debug = v:false
let g:randomcolorscheme_echo = v:true
let g:randomcolorscheme_interval = 30
let g:randomcolorscheme_background = "dark"
" let g:randomcolorscheme_match = "dark"
let g:randomcolorscheme_notmatch = "[lL]ight"
let g:randomcolorscheme_disables = ["evening", "default"]
let g:randomcolorscheme_events = ['FocusLost']

let g:randomcolorscheme_path = expand("~/.cache/randomcolorscheme/colors.toml")
let g:randomcolorscheme_colors_path = [expand('$CACHE_HOME/dein/repos')]

Keymap n <space>co <cmd>ChangeColorscheme<cr>
