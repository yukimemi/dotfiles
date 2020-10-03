if !IsInstalled("vim-wordmotion")
  finish
endif

let g:wordmotion_mappings = get(g:, 'wordmotion_mappings', {})
let g:wordmotion_mappings['ge'] = ''

