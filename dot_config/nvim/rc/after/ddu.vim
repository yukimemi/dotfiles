" =============================================================================
" File        : ddu.vim
" Author      : yukimemi
" Last Change : 2025/11/08 16:31:21.
" =============================================================================

nnoremap <silent> <space>dd <cmd>Ddu source <cr>

nnoremap <silent> mr <cmd>Ddu chronicle -source-param-chronicle-kind='read'<cr>
nnoremap <silent> mw <cmd>Ddu chronicle -source-param-chronicle-kind='write'<cr>

nnoremap <silent> m, <cmd>Ddu buffer<cr>
nnoremap <silent> mb <cmd>Ddu file_rec -source-option-file-path=`substitute(expand('%:p:h'), '\\', '/', 'g')`<cr>
nnoremap <silent> md <cmd>Ddu file_rec -source-option-file-path=`substitute(expand('~/.local/share/chezmoi'), '\\', '/', 'g')`<cr>
nnoremap <silent> mm <cmd>Ddu file_rec -source-option-file-path=`substitute(expand('~/.memolit'), '\\', '/', 'g')`<cr>
nnoremap <silent> ms <cmd>Ddu file_rec -source-option-file-path=`substitute(expand('~/src'), '\\', '/', 'g')`<cr>
nnoremap <silent> mC <cmd>Ddu file_rec -source-option-file-path=`substitute(expand('~/.cache'), '\\', '/', 'g')`<cr>

nnoremap <silent> <space>dh <cmd>Ddu help<cr>
nnoremap <silent> <space>ds <cmd>Ddu -name=search rg -ui-param-ff-ignoreEmpty -source-option-file-path=`input('Directory: ', getcwd())` -source-param-rg-input=`input('Pattern: ')`<cr>
nnoremap <silent> <space>di <cmd>Ddu -name=search rg -ui-param-ff-ignoreEmpty -source-option-file-path=`input('Directory: ', getcwd())` -source-option-rg-volatile<cr>
nnoremap <silent> <space>dr <cmd>Ddu -name=search -resume<cr>

nnoremap <silent> q: <cmd>Ddu command_history<cr>
nnoremap <silent> q/ <cmd>Ddu search_history<cr>


au MyAutoCmd FileType ddu-ff call s:ddu_ff_my_settings()

function s:ddu_ff_my_settings()
  nnoremap <buffer> <CR>
        \ <Cmd>call ddu#ui#do_action('itemAction')<CR>
  nnoremap <buffer> <2-LeftMouse>
        \ <Cmd>call ddu#ui#do_action('itemAction')<CR>
  nnoremap <buffer> <Space>
        \ <Cmd>call ddu#ui#do_action('toggleSelectItem')<CR>
  nnoremap <buffer> *
        \ <Cmd>call ddu#ui#do_action('toggleAllItems')<CR>
  nnoremap <buffer> i
        \ <Cmd>call ddu#ui#do_action('openFilterWindow')<CR>
  nnoremap <buffer> <C-l>
        \ <Cmd>call ddu#ui#do_action('redraw', #{ method: 'refreshItems' })<CR>
  nnoremap <buffer> p
        \ <Cmd>call ddu#ui#do_action('previewPath')<CR>
  nnoremap <buffer> P
        \ <Cmd>call ddu#ui#do_action('togglePreview')<CR>
  nnoremap <buffer> q
        \ <Cmd>call ddu#ui#do_action('quit')<CR>
  nnoremap <buffer> a
        \ <Cmd>call ddu#ui#do_action('chooseAction')<CR>
  nnoremap <buffer> A
        \ <Cmd>call ddu#ui#do_action('inputAction')<CR>
  nnoremap <buffer> o
        \ <Cmd>call ddu#ui#do_action('expandItem',
        \ #{ mode: 'toggle' })<CR>
  nnoremap <buffer> O
        \ <Cmd>call ddu#ui#do_action('collapseItem')<CR>
  nnoremap <buffer> d
        \ <Cmd>call ddu#ui#do_action('itemAction',
        \   b:ddu_ui_name ==# 'filer'
        \ ? #{ name: 'trash' }
        \ : #{ name: 'delete' })<CR>
  nnoremap <buffer> e
        \ <Cmd>call ddu#ui#do_action('itemAction',
        \   ddu#ui#get_item()->get('action', {})->get('isDirectory', v:false)
        \ ? #{ name: 'narrow' }
        \ : #{ name: 'edit' })<CR>
  nnoremap <buffer> E
        \ <Cmd>call ddu#ui#do_action('itemAction',
        \ #{ params: input('params: ', '{}')->eval() })<CR>
  nnoremap <buffer> N
        \ <Cmd>call ddu#ui#do_action('itemAction',
        \   b:ddu_ui_name ==# 'file'
        \ ? #{ name: 'newFile' }
        \ : #{ name: 'new' })<CR>
  nnoremap <buffer> r
        \ <Cmd>call ddu#ui#do_action('itemAction', #{ name: 'quickfix' })<CR>
  nnoremap <buffer> yy
        \ <Cmd>call ddu#ui#do_action('itemAction', #{ name: 'yank' })<CR>
  nnoremap <buffer> gr
        \ <Cmd>call ddu#ui#do_action('itemAction', #{ name: 'grep' })<CR>
  nnoremap <buffer> n
        \ <Cmd>call ddu#ui#do_action('itemAction', #{ name: 'narrow' })<CR>
  nnoremap <buffer> K
        \ <Cmd>call ddu#ui#do_action('kensaku')<CR>
  nnoremap <buffer> <C-v>
        \ <Cmd>call ddu#ui#do_action('toggleAutoAction')<CR>
  nnoremap <buffer> <C-p>
        \ <Cmd>call ddu#ui#do_action('previewExecute',
        \ #{ command: 'execute "normal! \<C-y>"' })<CR>
  nnoremap <buffer> <C-n>
        \ <Cmd>call ddu#ui#do_action('previewExecute',
        \ #{ command: 'execute "normal! \<C-e>"' })<CR>

  xnoremap <silent><buffer> <Space>
        \ :call ddu#ui#do_action('toggleSelectItem')<CR>

  " Switch options
  nnoremap <buffer> u
        \ <Cmd>call ddu#ui#multi_actions([
        \   [
        \      'updateOptions', #{
        \        filterParams: #{
        \          matcher_files: #{
        \             globs: 'Filter files: '
        \                    ->cmdline#input('', 'file')->split(','),
        \          },
        \        },
        \      }
        \   ],
        \   [
        \      'redraw', #{ method: 'refreshItems' },
        \   ],
        \ ])<CR>

  " Switch sources
  nnoremap <buffer> ff
        \ <Cmd>call ddu#ui#do_action('updateOptions', #{
        \   sources: [
        \     #{ name: 'file' },
        \   ],
        \ })<CR>
        \<Cmd>call ddu#ui#do_action('redraw', #{ method: 'refreshItems' })<CR>

  " Cursor move
  nnoremap <C-n>
        \ <Cmd>call ddu#ui#multi_actions(
        \   ['cursorNext', 'itemAction'], 'files')<CR>
  nnoremap <C-p>
        \ <Cmd>call ddu#ui#multi_actions(
        \   ['cursorPrevious', 'itemAction'], 'files')<CR>
  nnoremap <buffer> <C-j>
        \ <Cmd>call ddu#ui#do_action('cursorNext')<CR>
  nnoremap <buffer> <C-k>
        \ <Cmd>call ddu#ui#do_action('cursorPrevious')<CR>

  nnoremap <buffer> >
        \ <Cmd>call ddu#ui#do_action('updateOptions', #{
        \   uiParams: #{
        \     ff: #{
        \       winWidth: 80,
        \     },
        \   },
        \ })<CR>
        \<Cmd>call ddu#ui#do_action('redraw', #{ method: 'uiRedraw' })<CR>
endfunction

autocmd MyAutoCmd User Ddu:ui:ff:openFilterWindow call s:ddu_ff_filter_my_settings()

function s:ddu_ff_filter_my_settings() abort
  set cursorline
  call ddu#ui#ff#save_cmaps([
        \  '<C-f>', '<C-b>',
        \ ])
  cnoremap <C-f>
        \ <Cmd>call ddu#ui#do_action('cursorNext', #{ loop: v:true })<CR>
  cnoremap <C-b>
        \ <Cmd>call ddu#ui#do_action('cursorPrevious', #{ loop: v:true })<CR>
  cnoremap <CR>
        \ <Cmd>call ddu#ui#do_action('itemAction')<CR>
  call cmdline#enable()
endfunction

autocmd MyAutoCmd User Ddu:ui:ff:closeFilterWindow call s:ddu_ff_filter_cleanup()

function s:ddu_ff_filter_cleanup() abort
  set nocursorline
  call ddu#ui#ff#restore_cmaps()
endfunction
