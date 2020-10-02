let g:VimTodoListsCustomKeyMapper = 'VimTodoListsCustomMappings'

function! VimTodoListsCustomMappings()
  nnoremap <buffer> <localleader>t :VimTodoListsToggleItem<cr>
  noremap <buffer> <localleader>e :silent call VimTodoListsSetItemMode()<cr>
endfunction

let g:VimTodoListsDatesEnabled = 1
let g:VimTodoListsDatesFormat = "%Y/%m/%d %H:%M:%S"
