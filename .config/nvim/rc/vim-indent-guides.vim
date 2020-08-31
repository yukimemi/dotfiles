let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_tab_guides = 0
let g:indent_guides_start_level = 2
let g:indent_guides_guide_size = 1
let g:indent_guides_exclude_filetypes = ['help', 'nerdtree', 'tagbar', 'denite']


au MyAutoCmd CursorHold * call <SID>my_vim_indent_guides()

function! s:my_vim_indent_guides() abort
  silent! packadd vim-indent-guides
  silent! IndentGuidesEnable
endfunction

