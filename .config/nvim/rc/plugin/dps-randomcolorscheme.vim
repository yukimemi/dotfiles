" hook_add {{{
let g:randomcolorscheme_debug = v:false
let g:randomcolorscheme_echo = v:true
let g:randomcolorscheme_interval = 1800
let g:randomcolorscheme_background = "dark"
let g:randomcolorscheme_notmatch = "[lL]ight"
let g:randomcolorscheme_disables = ["evening", "default", "blue"]
let g:randomcolorscheme_events = ['FocusLost']

let g:randomcolorscheme_path = expand("~/.config/randomcolorscheme/colorscheme.toml")
let g:randomcolorscheme_colors_path = [expand('~/.cache/dpp/repos')]

Keymap n <space>ro <cmd>ChangeColorscheme<cr>
Keymap n <space>rd <cmd>DisableColorscheme<cr>
Keymap n ml <cmd>LikeThisColorscheme<cr>
Keymap n mh <cmd>HateThisColorscheme<cr>
" }}}
