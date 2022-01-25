if !g:plugin_use_ddu
  finish
endif

call ddu#custom#patch_global({
      \ 'ui': 'std',
      \ 'sourceOptions' : {
      \   '_' : {
      \     'ignoreCase': v:true,
      \     'matchers': ['matcher_substring'],
      \   }
      \ },
      \ 'uiParams': {
      \   'std': {
      \     'startFilter': v:true,
      \     'split': 'vertical',
      \   }
      \ },
      \ })

" Set name specific configuration
call ddu#custom#patch_local('files', {
      \ 'sources': [
      \   {'name': 'file', 'params': {}},
      \   {'name': 'mr', 'params': {}},
      \ ],
      \ })

" Specify name
" nnoremap <leader>df <cmd>call ddu#start({'name': 'files'})<cr>
" nnoremap <leader>du <cmd>call ddu#start({'name': 'file_old'})<cr>

" Specify source with params
" nnoremap <leader>dh <cmd>call ddu#start({'name': 'file_rec', 'params': {'path': expand('~')}})<cr>

function! s:ddu_std_cfg() abort
  nnoremap <buffer><silent> <cr> <cmd>call ddu#ui#std#do_map('doAction')<cr>
  nnoremap <buffer><silent> <space> <cmd>call ddu#ui#std#do_map('toggleSelectItem')<cr>
  nnoremap <buffer><silent> i <cmd>call ddu#ui#std#do_map('openFilterWindow')<cr>
  nnoremap <buffer><silent> a <cmd>call ddu#ui#std#do_map('openFilterWindow')<cr>
  nnoremap <buffer><silent> q <cmd>call ddu#ui#std#do_map('quit')<cr>
  nnoremap <buffer><silent><nowait> <esc> <cmd>call ddu#ui#std#do_map('quit')<cr>
endfunction

function! s:ddu_std_filter_cfg() abort
  inoremap <buffer><silent> <cr> <esc><cmd>close \| call ddu#ui#std#do_map('doAction')<cr>
  inoremap <buffer><silent><nowait> <esc> <esc><cmd>close<cr>
  nnoremap <buffer><silent> <cr> <cmd>close<cr>
endfunction

au MyAutoCmd FileType ddu-std call s:ddu_std_cfg()
au MyAutoCmd FileType ddu-std-filter call s:ddu_std_filter_cfg()

