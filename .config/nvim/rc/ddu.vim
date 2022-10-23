if !g:plugin_use_ddu
  finish
endif

let s:patch_global = {}
let s:sourceOptions = {}
let s:sourceParams = {}
let s:filterParams = {}
let s:uiParams = {}
let s:kindOptions = {}
let s:actionOptions = {}

call ddu#custom#alias('source', 'color', 'custom-list')
call ddu#custom#alias('source', 'file_git', 'file_external')
call ddu#custom#alias('source', 'mrr', 'mr')
call ddu#custom#alias('source', 'mrw', 'mr')

let s:sourceOptions._ = {
      \ 'ignoreCase': v:true,
      \ 'matchers': ['matcher_fzf'],
      \ }
let s:sourceOptions.dein_update = {'matchers': ['matcher_dein_update']}
let s:sourceOptions.file = {'defaultAction': 'narrow'}

let s:sourceParams.ghq = {
      \ 'display': 'relative',
      \ }
let s:sourceParams.file_git = {
      \ 'cmd': ['git', 'ls-files', '-co', '--exclude-standard'],
      \ }
let s:sourceParams.mrr = {'kind': 'mrr'}
let s:sourceParams.mrw = {'kind': 'mrw'}

let s:filterParams.matcher_fzf = {
      \ 'highlightMatched': 'Search',
      \ }

let s:uiParams.ff = {
      \ 'floatingBorder': 'rounded',
      \ 'previewFloating': v:true,
      \ 'previewWidth': &columns / 8 * 6,
      \ 'prompt': '»',
      \ 'split': has('nvim') ? 'floating' : 'horizontal',
      \ 'statusline': v:false,
      \ 'winCol': &columns / 8,
      \ 'winHeight': &lines / 8 * 6,
      \ 'winRow': &lines / 8,
      \ 'winWidth': &columns / 8 * 6,
      \ }

call ddu#custom#patch_local('file_rec', {
      \ 'sources': [{
      \   'name': 'file_rec',
      \ }],
      \ 'uiParams': {'ff': {
      \   'autoAction': {
      \     'name': 'preview',
      \   },
      \   'previewHeight': &lines / 2,
      \   'previewVertical': v:true,
      \   'previewWidth': &columns / 3,
      \   'winWidth': &columns / 3,
      \ }},
      \ })
call ddu#custom#patch_local('rg_live', {
      \ 'volatile': v:true,
      \ 'sources': [{
      \   'name': 'rg',
      \   'options': {'matchers': []},
      \ }],
      \ 'uiParams': {'ff': {
      \   'ignoreEmpty': v:false,
      \   'autoResize': v:false,
      \ }},
      \ })
call ddu#custom#patch_local('preview_colorscheme', {
      \ 'sources': [{
      \   'name': 'color',
      \ }],
      \ 'uiParams': {'ff': {
      \   'autoAction': {
      \     'name': 'itemAction',
      \   },
      \ }},
      \ 'actionOptions': {
      \   'callback': {'quit': v:false},
      \   'set': {'quit': v:false},
      \ },
      \ })

let s:kindOptions.action = {'defaultAction': 'do'}
let s:kindOptions.colorscheme = {'defaultAction': 'set'}
let s:kindOptions.command_history = {'defaultAction': 'edit'}
let s:kindOptions.dein_update = {'defaultAction': 'viewDiff'}
let s:kindOptions.file = {'defaultAction': 'open'}
let s:kindOptions.help = {'defaultAction': 'open'}
let s:kindOptions.highlight = {'defaultAction': 'edit'}
let s:kindOptions.readme_viewer = {'defaultAction': 'open'}
let s:kindOptions.source = {'defaultAction': 'execute'}
let s:kindOptions.url = {'defaultAction': 'open'}
let s:kindOptions.word = {'defaultAction': 'append'}
let s:kindOptions['custom-list'] = {'defaultAction': 'callback'}
let s:kindOptions['ui-select'] = {'defaultAction': 'execute'}

let s:actionOptions.echo = {'quit': v:false}
let s:actionOptions.echoDiff = {'quit': v:false}

let s:patch_global.ui = 'ff'
let s:patch_global.sourceOptions = s:sourceOptions
let s:patch_global.sourceParams = s:sourceParams
let s:patch_global.filterParams = s:filterParams
let s:patch_global.uiParams = s:uiParams
let s:patch_global.kindOptions = s:kindOptions
let s:patch_global.actionOptions = s:actionOptions
call ddu#custom#patch_global(s:patch_global)

function! s:ddu_ff_cfg() abort
  setl cursorline
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
  setl cursorline
  Keymap i <buffer><silent> <cr> <esc><cmd>call ddu#ui#ff#do_action('itemAction')<cr>
  Keymap i <buffer><silent><nowait> <esc> <esc><cmd>call ddu#ui#ff#close()<cr>
  Keymap i <buffer><silent> <C-j> <cmd>call ddu#ui#ff#execute('call cursor(line(".") % line("$") + 1, 0)<Bar>redraw')<cr>
  Keymap i <buffer><silent> <C-k> <cmd>call ddu#ui#ff#execute('call cursor((line(".") - 2 + line("$")) % line("$") + 1, 0)<Bar>redraw')<cr>
endfunction

au MyAutoCmd FileType ddu-ff call s:ddu_ff_cfg()
au MyAutoCmd FileType ddu-ff-filter call s:ddu_ff_filter_cfg()
