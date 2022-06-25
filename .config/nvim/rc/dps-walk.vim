let g:walk_debug = v:false
let g:walk_bufsize = 300
let g:walk_skips = ["\\.git", "\\.svn", "\\.hg", "\\.o$", "\\.obj$", "\\.a$", "\\.exe~?$", "tags$"]

nnoremap <space>wa <cmd>DenopsWalk<cr>
nnoremap <space>ws <cmd>DenopsWalk --path=~/src<cr>
nnoremap <space>wD <cmd>DenopsWalk --path=~/.dotfiles<cr>
nnoremap <space>wc <cmd>DenopsWalk --path=~/.cache<cr>
nnoremap <space>wm <cmd>DenopsWalk --path=~/.memolist<cr>
nnoremap <space>wd <cmd>DenopsWalkBufferDir<cr>
