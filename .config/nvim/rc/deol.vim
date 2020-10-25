tnoremap <esc> <c-\><c-n>
nnoremap <leader>s :<c-u>execute 'Deol' '-cwd='.fnamemodify(expand('%'), ':h')<cr>

au MyAutoCmd FileType deol nnoremap <buffer> p <c-w>""

if has('nvim')
  au MyAutoCmd WinEnter * if &buftype ==# 'terminal' | startinsert | endif
else
  au MyAutoCmd WinEnter * if &buftype ==# 'terminal' | normal i | endif
endif

let g:deol#custom_map = {
      \ 'edit': 'e',
      \ 'start_insert': 'i',
      \ 'start_insert_first': 'I',
      \ 'start_append': 'a',
      \ 'start_append_last': 'A',
      \ 'execute_line': '<CR>',
      \ 'previous_prompt': '<C-p>',
      \ 'next_prompt': '<C-n>',
      \ 'paste_prompt': '<C-y>',
      \ 'bg': '<C-z>',
      \ 'quit': 'q',
      \ }
