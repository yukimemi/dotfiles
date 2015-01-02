" Setting include path
let &l:path = join(filter(split($VIM_CPP_STDLIB . "," . $VIM_CPP_INCLUDE_DIR, '[,;]'), 'isdirectory(v:val)'), ',')

" Tab
setl tabstop=4
setl shiftwidth=2
setl softtabstop=2

" Use <>
setl matchpairs+=<:>

" Move to last definition and change to insert mode
nnoremap <buffer><silent> [Space]ii :execute "?".&include<CR> :noh<CR> o

" Highlight BOOST_PP_XXX etc
syntax match boost_pp /BOOST_PP_[A-z0-9_]*/
highlight link boost_pp cppStatement
