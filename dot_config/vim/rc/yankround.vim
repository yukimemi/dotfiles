if !IsInstalled('yankround.vim')
	finish
endif

let g:yankround_max_history   = 10000
let g:yankround_use_region_hl = 1
let g:yankround_dir           = expand('~/.cache/yankround')

Keymap nx p <Plug>(yankround-p)
Keymap n  P <Plug>(yankround-P)

Keymap n <silent> <expr> <C-p> yankround#is_active() ? '<Plug>(yankround-prev)' : '<Plug>(ctrlp)'
Keymap n <silent> <expr> <C-n> yankround#is_active() ? '<Plug>(yankround-next)' : ""
