" Don't use netrw.
let g:loaded_netrwPlugin = 1
if g:is_windows || !has('python3')
  " nnoremap <space>v :<c-u>Dirvish %<cr>
endif
