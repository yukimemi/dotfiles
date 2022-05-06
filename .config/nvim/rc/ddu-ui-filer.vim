if !g:plugin_use_ddu
  finish
endif

function! s:ddu_filer_cfg() abort
  Keymap n <buffer> <Space> <Cmd>call ddu#ui#filer#do_action('toggleSelectItem')<CR>
  Keymap n <buffer> q <Cmd>call ddu#ui#filer#do_action('quit')<CR>
  Keymap n <buffer> o <Cmd>call ddu#ui#filer#do_action('expandItem')<CR>
  Keymap n <buffer> O <Cmd>call ddu#ui#filer#do_action('collapseItem')<CR>
  Keymap n <buffer> d <Cmd>call ddu#ui#filer#do_action('itemAction', {'name': 'delete'})<CR>
  Keymap n <buffer> x <Cmd>call ddu#ui#filer#do_action('itemAction', {'name': 'executeSystem'})<CR>
  Keymap n <buffer> K <Cmd>call ddu#ui#filer#do_action('itemAction', {'name': 'newDirectory'})<CR>
  Keymap n <buffer> N <Cmd>call ddu#ui#filer#do_action('itemAction', {'name': 'newFile'})<CR>
  Keymap n <buffer> ~ <Cmd>call ddu#ui#filer#do_action('itemAction', {'name': 'narrow', 'params': {'path': expand('~')}})<CR>
  Keymap n <buffer> h <Cmd>call ddu#ui#filer#do_action('itemAction', {'name': 'narrow', 'params': {'path': ".."}})<CR>
  Keymap n <buffer><expr> <CR> ddu#ui#filer#is_directory() ? "<Cmd>call ddu#ui#filer#do_action('itemAction', {'name': 'narrow'})<CR>" : "<Cmd>call ddu#ui#filer#do_action('itemAction', {'name': 'open'})<CR>"
endfunction

au MyAutoCmd FileType ddu-filer call s:ddu_filer_cfg()

