let g:submode_leave_with_key = 1

au MyAutoCmd VimEnter * call <SID>vim_submode_aft()
function! s:vim_submode_aft() abort
  silent! packadd vim-submode
  silent! call submode#enter_with('bufmove', 'n', '', 's>', '<c-w>>')
  silent! call submode#enter_with('bufmove', 'n', '', 's<', '<c-w><')
  silent! call submode#enter_with('bufmove', 'n', '', 's+', '<c-w>+')
  silent! call submode#enter_with('bufmove', 'n', '', 's-', '<c-w>-')
  silent! call submode#map('bufmove', 'n', '', '>', '<c-w>>')
  silent! call submode#map('bufmove', 'n', '', '<', '<c-w><')
  silent! call submode#map('bufmove', 'n', '', '+', '<c-w>+')
  silent! call submode#map('bufmove', 'n', '', '-', '<c-w>-')
endfunction

