" let g:test#preserve_screen = 1

Keymap n <silent> <leader>tn <cmd>TestNearest<cr>
Keymap n <silent> <leader>tf <cmd>TestFile<cr>
Keymap n <silent> <leader>ts <cmd>TestSuite<cr>
Keymap n <silent> <leader>tl <cmd>TestLast<cr>
Keymap n <silent> <leader>tg <cmd>TestVisit<cr>

let test#strategy = {
      \ 'nearest': 'neoterm',
      \ 'file'   : 'neoterm',
      \ 'suite'  : 'neoterm',
      \ }

let test#javascript#denotest#options = {
      \ 'all': '--unstable -A'
      \ }

