let g:signify_line_highlight = 0
let g:signify_number_highlight = 0

let g:signify_sign_add               = '󿕓'
let g:signify_sign_delete            = '󿕂'
let g:signify_sign_delete_first_line = '󿕛'
let g:signify_sign_change            = '󿕓'
let g:signify_sign_change_delete     = g:signify_sign_change . g:signify_sign_delete_first_line

au MyAutoCmd User SignifyHunk call s:show_current_hunk()

function! s:show_current_hunk() abort
  let h = sy#util#get_hunk_stats()
  if !empty(h)
    echo printf('[Hunk %d/%d]', h.current_hunk, h.total_hunks)
  endif
endfunction
