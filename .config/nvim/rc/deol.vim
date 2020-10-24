tnoremap <esc> <c-\><c-n>
nnoremap <c-s> :<c-u>execute 'Deol' '-cwd='.fnamemodify(expand('%'), ':h')<cr>

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
