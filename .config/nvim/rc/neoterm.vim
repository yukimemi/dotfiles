if ! g:is_windows
  let g:neoterm_autoinsert = 1
  nnoremap [Space]s :<C-u>terminal<CR>
  tnoremap sj <C-\><C-n><C-w>j
  tnoremap sk <C-\><C-n><C-w>k
  tnoremap sl <C-\><C-n><C-w>l
  tnoremap sh <C-\><C-n><C-w>h
endif

