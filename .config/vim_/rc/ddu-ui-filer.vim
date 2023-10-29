if !g:plugin_use_ddu_filer
  finish
endif

function! s:ddu_filer_cfg() abort
  nnoremap <buffer> <Space>
        \ <Cmd>call ddu#ui#filer#do_action('toggleSelectItem')<CR>
  nnoremap <buffer> *
        \ <Cmd>call ddu#ui#filer#do_action('toggleAllItems')<CR>
  nnoremap <buffer> a
        \ <Cmd>call ddu#ui#filer#do_action('chooseAction')<CR>
  nnoremap <buffer> q
        \ <Cmd>call ddu#ui#filer#do_action('quit')<CR>
  nnoremap <buffer> o
        \ <Cmd>call ddu#ui#filer#do_action('expandItem',
        \ {'mode': 'toggle'})<CR>
  nnoremap <buffer> O
        \ <Cmd>call ddu#ui#filer#do_action('expandItem',
        \ {'maxLevel': -1})<CR>
  "nnoremap <buffer> O
        "\ <Cmd>call ddu#ui#filer#do_action('collapseItem')<CR>
  nnoremap <buffer> c
        \ <Cmd>call ddu#ui#filer#multi_actions([
        \ ['itemAction', {'name': 'copy'}],
        \ ['clearSelectAllItems'],
        \ ])<CR>
  nnoremap <buffer> d
        \ <Cmd>call ddu#ui#filer#do_action('itemAction',
        \ {'name': 'delete'})<CR>
  nnoremap <buffer> D
        \ <Cmd>call ddu#ui#filer#do_action('itemAction',
        \ {'name': 'trash'})<CR>
  nnoremap <buffer> m
        \ <Cmd>call ddu#ui#filer#do_action('itemAction',
        \ {'name': 'move'})<CR>
  nnoremap <buffer> r
        \ <Cmd>call ddu#ui#filer#do_action('itemAction',
        \ {'name': 'rename'})<CR>
  nnoremap <buffer> x
        \ <Cmd>call ddu#ui#filer#do_action('itemAction',
        \ {'name': 'executeSystem'})<CR>
  nnoremap <buffer> p
        \ <Cmd>call ddu#ui#filer#do_action('itemAction',
        \ {'name': 'paste'})<CR>
  nnoremap <buffer> K
        \ <Cmd>call ddu#ui#filer#do_action('itemAction',
        \ {'name': 'newDirectory'})<CR>
  nnoremap <buffer> N
        \ <Cmd>call ddu#ui#filer#do_action('itemAction',
        \ {'name': 'newFile'})<CR>
  nnoremap <buffer> ~
        \ <Cmd>call ddu#ui#filer#do_action('itemAction',
        \ {'name': 'narrow', 'params': {'path': expand('~')}})<CR>
  nnoremap <buffer> h
        \ <Cmd>call ddu#ui#filer#do_action('itemAction',
        \ {'name': 'narrow', 'params': {'path': ".."}})<CR>
  nnoremap <buffer> I
        \ <Cmd>call ddu#ui#filer#do_action('itemAction',
        \ {'name': 'narrow', 'params': {'path':
        \  fnamemodify(input('New cwd: ', b:ddu_ui_filer_path, 'dir'), ':p')}})<CR>
  nnoremap <buffer> >
        \ <Cmd>call ddu#ui#filer#do_action('updateOptions', {
        \   'sourceOptions': {
        \     'file': {
        \       'matchers': ToggleHidden('file'),
        \     },
        \   },
        \ })<CR>
  nnoremap <buffer> <C-l>
        \ <Cmd>call ddu#ui#filer#do_action('checkItems')<CR>
  nnoremap <buffer><expr> <CR>
        \ ddu#ui#filer#is_directory() ?
        \ "<Cmd>call ddu#ui#filer#do_action('itemAction', {'name': 'narrow'})<CR>" :
        \ "<Cmd>call ddu#ui#filer#do_action('itemAction', {'name': 'open'})<CR>"
  nnoremap <buffer><expr> l
        \ ddu#ui#filer#is_directory() ?
        \ "<Cmd>call ddu#ui#filer#do_action('itemAction', {'name': 'narrow'})<CR>" :
        \ "<Cmd>call ddu#ui#filer#do_action('itemAction', {'name': 'open'})<CR>"

  function! ToggleHidden(name)
    let current = ddu#custom#get_current(b:ddu_ui_name)
    let source_options = get(current, 'sourceOptions', {})
    let source_options_name = get(source_options, a:name, {})
    let matchers = get(source_options_name, 'matchers', [])
    return empty(matchers) ? ['matcher_hidden'] : []
  endfunction

  au MyAutoCmd TabEnter,CursorHold,FocusGained <buffer>
        \ call ddu#ui#filer#do_action('checkItems')
endfunction

au MyAutoCmd FileType ddu-filer call s:ddu_filer_cfg()

Keymap n ge <Cmd>Ddu
      \ -name=filer-`win_getid()` -ui=filer -resume
      \ -source-option-path=`getcwd()`
      \ -source-option-columns=filename file<CR>
