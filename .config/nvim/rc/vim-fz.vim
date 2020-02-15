if !IsInstalled('autoload/fz.vim') || exists('g:loaded_fz_cfg')
  finish
endif
let g:loaded_fz_cfg = 1

nmap <silent> scp <Plug>(fz)
nmap <silent> scu <Plug>(fz-mru)

nnoremap <silent> scr :<c-u>Fz ~/.rhq<cr>

