if !g:plugin_use_ddu
  finish
endif

function! s:my_ddu_config() abort
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
  \     'file_rg': {
  \       'cmd': ['rg', '--files', '--glob', '!.git', '--color', 'never', '--no-messages'],
  \       'updateItems': 50000,
  \     },
  \     'rg': {
  \       'args': ['--ignore-case', '--column', '--no-heading', '--color', 'never'],
  \     },
  \   },
  \   'uiParams': {
  \     'ff': {
  \       'prompt': '»',
  \       'reversed': v:true,
  \       'split': 'horizontal',
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
  \     'colorscheme': {
  \       'defaultAction': 'set',
  \     },
  \   },
  \ })
endfunction

" Specify name
" nnoremap <leader>df <cmd>call ddu#start({'name': 'files'})<cr>
" nnoremap <leader>du <cmd>call ddu#start({'name': 'file_old'})<cr>

" Specify source with params
" nnoremap <leader>dh <cmd>call ddu#start({'name': 'file_rec', 'params': {'path': expand('~')}})<cr>

function! s:ddu_ff_cfg() abort
  Keymap n <buffer><silent> <cr> <cmd>call ddu#ui#ff#do_action('itemAction')<cr>
  Keymap n <buffer><silent> <space> <cmd>call ddu#ui#ff#do_action('toggleSelectItem')<cr>
  Keymap n <buffer><silent> i <cmd>call ddu#ui#ff#do_action('openFilterWindow')<cr>
  Keymap n <buffer><silent> <C-l> <cmd>call ddu#ui#ff#do_action('refreshItems')<cr>
  Keymap n <buffer><silent> p <cmd>call ddu#ui#ff#do_action('preview')<cr>
  Keymap n <buffer><silent> q <cmd>call ddu#ui#ff#do_action('quit')<cr>
  Keymap n <buffer><silent> a <cmd>call ddu#ui#ff#do_action('chooseAction')<cr>
  Keymap n <buffer><silent> c <cmd>call ddu#ui#ff#do_action('itemAction', {'name': 'cd'})<cr>
  Keymap n <buffer><silent> d <cmd>call ddu#ui#ff#do_action('itemAction', {'name': 'delete'})<cr>
  Keymap n <buffer><silent> e <cmd>call ddu#ui#ff#do_action('itemAction', {'name': 'edit'})<cr>
  Keymap n <buffer><silent> E <cmd>call ddu#ui#ff#do_action('itemAction', {'params': eval(input('params: '))})<cr>
  Keymap n <buffer><silent> v <cmd>call ddu#ui#ff#do_action('itemAction', {'name': 'open', 'params': {'command': 'vsplit'}})<cr>
  Keymap n <buffer><silent> N <cmd>call ddu#ui#ff#do_action('itemAction', {'name': 'new'})<cr>
  Keymap n <buffer><silent> r <cmd>call ddu#ui#ff#do_action('itemAction', {'name': 'quickfix'})<cr>
  Keymap n <buffer><silent><nowait> <esc> <cmd>call ddu#ui#ff#do_action('quit')<cr>
  Keymap n <buffer><silent> u <cmd>call ddu#ui#ff#do_action('updateOptions', {
  \   'sourceOptions': {
  \     '_': {
  \       'matchers': [],
  \     },
  \   },
  \ })<cr>
endfunction

function! s:ddu_ff_filter_cfg() abort
  Keymap i <buffer><silent> <cr> <esc><cmd>close \| call ddu#ui#ff#do_action('itemAction')<cr>
  Keymap i <buffer><silent><nowait> <esc> <esc><cmd>close<cr>
  Keymap n <buffer><silent> <cr> <cmd>close<cr>
  Keymap i <buffer> <c-j> <cmd>call ddu#ui#ff#execute("call cursor(line('.')+1,0)")<cr>
  Keymap i <buffer> <c-k> <cmd>call ddu#ui#ff#execute("call cursor(line('.')-1,0)")<cr>
endfunction

au MyAutoCmd VimEnter * ++once call s:my_ddu_config()
au MyAutoCmd FileType ddu-ff call s:ddu_ff_cfg()
au MyAutoCmd FileType ddu-ff-filter call s:ddu_ff_filter_cfg()

