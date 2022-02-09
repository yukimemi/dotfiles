if !g:plugin_use_ddu
  finish
endif

call ddu#custom#patch_global({
      \   'ui': 'std',
      \   'sourceOptions': {
      \     '_': {
      \       'ignoreCase': v:true,
      \       'matchers': ['matcher_substring'],
      \     },
      \   },
      \   'sourceParams': {
      \     'file_external': {
      \       'cmd': ['git', 'ls-files', '-co', '--exclude-standard'],
      \     },
      \   },
      \   'uiParams': {
      \     'std': {
      \       'prompt': '»',
      \       'split': 'horizontal',
      \       'filterSplitDirection': 'botright',
      \     }
      \   },
      \   'kindOptions': {
      \     'file': {
      \       'defaultAction': 'open',
      \     },
      \     'word': {
      \       'defaultAction': 'append',
      \     }
      \   }
      \ })

" Specify name
" nnoremap <leader>df <cmd>call ddu#start({'name': 'files'})<cr>
" nnoremap <leader>du <cmd>call ddu#start({'name': 'file_old'})<cr>

" Specify source with params
" nnoremap <leader>dh <cmd>call ddu#start({'name': 'file_rec', 'params': {'path': expand('~')}})<cr>

function! s:ddu_std_cfg() abort
  nnoremap <buffer><silent> <CR> <Cmd>call ddu#ui#std#do_action('itemAction')<CR>
  nnoremap <buffer><silent> <Space> <Cmd>call ddu#ui#std#do_action('toggleSelectItem')<CR>
  nnoremap <buffer><silent> i <Cmd>call ddu#ui#std#do_action('openFilterWindow')<CR>
  nnoremap <buffer><silent> <C-l> <Cmd>call ddu#ui#std#do_action('refreshItems')<CR>
  nnoremap <buffer><silent> q <Cmd>call ddu#ui#std#do_action('quit')<CR>
  nnoremap <buffer><silent><nowait> <esc> <Cmd>call ddu#ui#std#do_action('quit')<CR>
  nnoremap <buffer><silent> r <Cmd>call ddu#ui#std#do_action('updateOptions', {
        \   'sourceOptions': {
        \     '_': {
        \       'matchers': [],
        \     },
        \   },
        \ })<CR>
endfunction

function! s:ddu_std_filter_cfg() abort
  inoremap <buffer><silent> <CR> <Esc><Cmd>close \| call ddu#ui#std#do_action('itemAction')<CR>
  inoremap <buffer><silent><nowait> <esc> <esc><cmd>close<cr>
  nnoremap <buffer><silent> <CR> <Cmd>close<CR>
endfunction

au MyAutoCmd FileType ddu-std call s:ddu_std_cfg()
au MyAutoCmd FileType ddu-std-filter call s:ddu_std_filter_cfg()

