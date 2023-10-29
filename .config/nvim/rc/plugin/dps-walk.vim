" hook_add {{{
let g:walk_debug = v:false
let g:walk_bufsize = 300
let g:walk_skips = ["\\.git", "\\.svn", "\\.hg", "\\.o$", "\\.obj$", "\\.a$", "\\.exe~?$", "tags$"]

Keymap n mw <cmd>DenopsWalk<cr>
Keymap n ms <cmd>DenopsWalk --path=~/src<cr>
Keymap n mD <cmd>DenopsWalk --path=~/.dotfiles<cr>
Keymap n mc <cmd>DenopsWalk --path=~/.cache<cr>
Keymap n mj <cmd>DenopsWalk --path=~/.cache/junkfile<cr>
Keymap n mM <cmd>DenopsWalk --path=~/.memolist<cr>
Keymap n md <cmd>DenopsWalkBufferDir<cr>
" }}}
