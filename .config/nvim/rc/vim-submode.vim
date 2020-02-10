let g:submode_leave_with_key = 1

au MyAutoCmd VimEnter * call <SID>vim_submode_aft()
function! s:vim_submode_aft() abort
  silent! packadd vim-submode
  call submode#enter_with('bufmove', 'n', '', 's>', '<c-w>>')
  call submode#enter_with('bufmove', 'n', '', 's<', '<c-w><')
  call submode#enter_with('bufmove', 'n', '', 's+', '<c-w>+')
  call submode#enter_with('bufmove', 'n', '', 's-', '<c-w>-')
  call submode#map('bufmove', 'n', '', '>', '<c-w>>')
  call submode#map('bufmove', 'n', '', '<', '<c-w><')
  call submode#map('bufmove', 'n', '', '+', '<c-w>+')
  call submode#map('bufmove', 'n', '', '-', '<c-w>-')
endfunction

