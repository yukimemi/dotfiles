" let g:test#preserve_screen = 1

nnoremap <silent> <leader>tn <cmd>TestNearest<cr>
nnoremap <silent> <leader>tf <cmd>TestFile<cr>
nnoremap <silent> <leader>ts <cmd>TestSuite<cr>
nnoremap <silent> <leader>tl <cmd>TestLast<cr>
nnoremap <silent> <leader>tg <cmd>TestVisit<cr>

let test#strategy = {
			\ 'nearest': 'neoterm',
			\ 'file'   : 'neoterm',
			\ 'suite'  : 'neoterm',
			\ }

let test#javascript#denotest#options = {
      \ 'all': '--unstable -A'
      \ }

