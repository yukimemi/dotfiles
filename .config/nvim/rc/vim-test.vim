" let g:test#preserve_screen = 1

nmap <silent> <leader>tn <cmd>TestNearest<cr>
nmap <silent> <leader>tf <cmd>TestFile<cr>
nmap <silent> <leader>ts <cmd>TestSuite<cr>
nmap <silent> <leader>tl <cmd>TestLast<cr>
nmap <silent> <leader>tg <cmd>TestVisit<cr>

let test#strategy = {
			\ 'nearest': 'neoterm',
			\ 'file'   : 'neoterm',
			\ 'suite'  : 'neoterm',
			\ }

let test#javascript#denotest#options = {
      \ 'all': '--no-check --unstable -A'
      \ }

