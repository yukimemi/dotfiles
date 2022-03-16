if !g:plugin_use_ddu
  finish
endif

call ddu#custom#patch_global({
\   'ui': 'ff',
\   'sourceOptions': {
\     '_': {
\       'ignoreCase': v:true,
\       'matchers': ['matcher_substring'],
\     },
\   },
\   'file_old': {
\     'matchers': [
\       'matcher_substring', 'matcher_relative', 'matcher_hidden',
\     ],
\   },
\   'file_external': {
\     'matchers': [
\       'matcher_substring', 'matcher_hidden',
\     ],
\   },
\   'file_rec': {
\     'matchers': [
\       'matcher_substring', 'matcher_hidden',
\     ],
\   },
\   'dein': {
\     'defaultAction': 'cd',
\   },
\   'sourceParams': {
\     'file_external': {
\       'cmd': ['git', 'ls-files', '-co', '--exclude-standard'],
\     },
\   },
\   'uiParams': {
\     'ff': {
\       'prompt': '»',
\       'winHeight': 10,
\       'reversed': v:true,
\       'split': has('nvim') ? 'floating' : 'horizontal',
\       'displaySourceName': 'long',
\     },
\   },
\   'kindOptions': {
\     'file': {
\       'defaultAction': 'open',
\     },
\     'word': {
\       'defaultAction': 'append',
\     },
\     'deol': {
\       'defaultAction': 'switch',
\     },
\     'action': {
\       'defaultAction': 'do',
\     },
\   }
\ })

" Specify name
" nnoremap <leader>df <cmd>call ddu#start({'name': 'files'})<cr>
" nnoremap <leader>du <cmd>call ddu#start({'name': 'file_old'})<cr>

" Specify source with params
" nnoremap <leader>dh <cmd>call ddu#start({'name': 'file_rec', 'params': {'path': expand('~')}})<cr>

function! s:ddu_ff_cfg() abort
  Keymap n <buffer><silent> <CR> <Cmd>call ddu#ui#ff#do_action('itemAction')<CR>
  Keymap n <buffer><silent> <Space> <Cmd>call ddu#ui#ff#do_action('toggleSelectItem')<CR>
  Keymap n <buffer><silent> i <Cmd>call ddu#ui#ff#do_action('openFilterWindow')<CR>
  Keymap n <buffer><silent> <C-l> <Cmd>call ddu#ui#ff#do_action('refreshItems')<CR>
  Keymap n <buffer><silent> p <Cmd>call ddu#ui#ff#do_action('preview')<CR>
  Keymap n <buffer><silent> q <Cmd>call ddu#ui#ff#do_action('quit')<CR>
  Keymap n <buffer><silent> a <Cmd>call ddu#ui#ff#do_action('chooseAction')<CR>
  Keymap n <buffer><silent> c <Cmd>call ddu#ui#ff#do_action('itemAction', {'name': 'cd'})<CR>
  Keymap n <buffer><silent> d <Cmd>call ddu#ui#ff#do_action('itemAction', {'name': 'delete'})<CR>
  Keymap n <buffer><silent> e <Cmd>call ddu#ui#ff#do_action('itemAction', {'name': 'edit'})<CR>
  Keymap n <buffer><silent> E <Cmd>call ddu#ui#ff#do_action('itemAction', {'params': eval(input('params: '))})<CR>
  Keymap n <buffer><silent> v <Cmd>call ddu#ui#ff#do_action('itemAction', {'name': 'open', 'params': {'command': 'vsplit'}})<CR>
  Keymap n <buffer><silent> N <Cmd>call ddu#ui#ff#do_action('itemAction', {'name': 'new'})<CR>
  Keymap n <buffer><silent> r <Cmd>call ddu#ui#ff#do_action('itemAction', {'name': 'quickfix'})<CR>
  Keymap n <buffer><silent><nowait> <esc> <Cmd>call ddu#ui#ff#do_action('quit')<CR>
  Keymap n <buffer><silent> u <Cmd>call ddu#ui#ff#do_action('updateOptions', {
  \   'sourceOptions': {
  \     '_': {
  \       'matchers': [],
  \     },
  \   },
  \ })<CR>
endfunction

function! s:ddu_ff_filter_cfg() abort
  Keymap i <buffer><silent> <CR> <Esc><Cmd>close \| call ddu#ui#ff#do_action('itemAction')<CR>
  Keymap i <buffer><silent><nowait> <esc> <esc><cmd>close<cr>
  Keymap n <buffer><silent> <CR> <Cmd>close<CR>
endfunction

au MyAutoCmd FileType ddu-ff call s:ddu_ff_cfg()
au MyAutoCmd FileType ddu-ff-filter call s:ddu_ff_filter_cfg()

