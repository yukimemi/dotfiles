if !IsInstalled("marvim")
  finish
endif

let g:marvim_store = $CACHE . '/marvim' " change store place.
let g:marvim_register = 'q'           " change used register from 'q' to 'c'
" let g:marvim_prefix = 0               " disable default syntax based prefix

