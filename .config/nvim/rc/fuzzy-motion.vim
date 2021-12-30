au MyAutoCmd BufEnter * if !(&buftype is# "quickfix" || &buftype is# "qf") | nnoremap <buffer> <cr> <cmd>FuzzyMotion<cr> | endif

