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

  " nextfile.vim
  call submode#enter_with('nextfile', 'n', 'r', '<leader>j', '<Plug>(nextfile-next)')
  call submode#enter_with('nextfile', 'n', 'r', '<leader>k', '<Plug>(nextfile-previous)')
  call submode#map('nextfile', 'n', 'r', 'j', '<Plug>(nextfile-next)')
  call submode#map('nextfile', 'n', 'r', 'k', '<Plug>(nextfile-previous)')
endfunction

