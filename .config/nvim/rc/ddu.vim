if !g:plugin_use_ddu
  finish
endif

call ddu#custom#alias('source', 'file_rg', 'file_external')

call ddu#custom#patch_global({
      \   'ui': 'ff',
      \   'sourceOptions': {
      \     '_': {
      \       'ignoreCase': v:true,
      \       'matchers': ['matcher_substring'],
      \       'converters': ['converter_display_word', 'matcher_substring'],
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
      \   'uiOptions': {
      \     'filer': {
      \       'toggle': v:true,
      \       'split': 'vertical',
      \       'winWidth': 40,
      \     },
      \   },
      \   'uiParams': {
      \     'ff': {
      \       'prompt': '»',
      \       'filterSplitDirection': 'floating',
      \       'previewFloating': v:true,
      \       'reversed': v:true,
      \       'split': has('nvim') ? 'floating' : 'horizontal',
      \     },
      \     'filer': {
      \       'toggle': v:true,
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
      \     'source': {
      \       'defaultAction': 'execute',
      \     },
      \     'help': {
      \       'defaultAction': 'open',
      \     },
      \     'command_history': {
      \       'defaultAction': 'execute',
      \     },
      \   },
      \   'actionOptions': {
      \     'narrow': {
      \       'quit': v:false,
      \     },
      \   },
      \ })

call ddu#custom#patch_global({
    \   'filterParams': {
    \     'matcher_substring': {
    \       'highlightMatched': 'Search',
    \     },
    \   }
    \ })


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
