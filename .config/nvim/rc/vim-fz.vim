if !IsInstalled('autoload/fz.vim') || exists('g:loaded_fz_cfg')
  finish
endif
let g:loaded_fz_cfg = 1

tnoremap <expr> <Esc> (&filetype == "fz") ? "<Esc>" : "<c-\><c-n>"

nmap <silent> scp <Plug>(fz)
nmap <silent> scu <Plug>(fz-mru)

nnoremap <silent> scg :<c-u>Fz ~/.ghq/src<cr>

