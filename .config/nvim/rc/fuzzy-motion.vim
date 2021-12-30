au MyAutoCmd BufEnter * if &buftype isnot# "quickfix" | nnoremap <buffer> <cr> <cmd>FuzzyMotion<cr> | endif

