if ! g:is_windows
  let g:neoterm_autoinsert = 1
  nnoremap <space>s :<c-u>terminal<cr>
  tnoremap sj <c-\><c-n><c-w>j
  tnoremap sk <c-\><c-n><c-w>k
  tnoremap sl <c-\><c-n><c-w>l
  tnoremap sh <c-\><c-n><c-w>h
endif

