" hook_add {{{
Keymap nx :      <Cmd>call CommandlinePre(':')<CR>:
Keymap nx /      <Cmd>call CommandlinePre('/')<CR>/
Keymap nx ?      <Cmd>call CommandlinePre('/')<CR>?

function! CommandlinePre(mode) abort
  " Overwrite sources
  let b:prev_buffer_config = ddc#custom#get_buffer()

  if a:mode ==# ':'
    call ddc#custom#patch_buffer('sourceOptions', #{
          \   _: #{
          \     keywordPattern: '[0-9a-zA-Z_:#-]*',
          \   },
          \ })
  endif

  autocmd MyAutoCmd User DDCCmdlineLeave ++once call CommandlinePost()

  call ddc#enable_cmdline_completion()
endfunction

function! CommandlinePost() abort
  " Restore config
  if 'b:prev_buffer_config'->exists()
    call ddc#custom#set_buffer(b:prev_buffer_config)
    unlet b:prev_buffer_config
  endif
endfunction
" }}}

" hook_source {{{
call ddc#custom#load_config(expand('$BASE_DIR/plugin/ddc.ts'))

" For insert mode completion
inoremap <expr> <c-n>
      \ pum#visible() ?
      \   '<Cmd>call pum#map#insert_relative(+1, "empty")<CR>' :
      \ (col('.') <= 1 <Bar><Bar> getline('.')[col('.') - 2] =~# '\s') ?
      \   '<TAB>' : ddc#map#manual_complete()
inoremap <c-p> <Cmd>call pum#map#insert_relative(-1, 'empty')<CR>
" inoremap <C-n>   <Cmd>call pum#map#select_relative(+1)<CR>
" inoremap <C-p>   <Cmd>call pum#map#select_relative(-1)<CR>
inoremap <C-y>   <Cmd>call pum#map#confirm()<CR>
inoremap <C-o>   <Cmd>call pum#map#confirm_word()<CR>
inoremap <Home>  <Cmd>call pum#map#insert_relative(-9999, 'ignore')<CR>
inoremap <End>   <Cmd>call pum#map#insert_relative(+9999, 'ignore')<CR>
inoremap <expr> <C-e> ddc#visible()
      \ ? '<Cmd>call ddc#hide()<CR>'
      \ : '<End>'

" Refresh the completion
inoremap <expr> <c-space>  ddc#map#manual_complete()

" For command line mode completion
cnoremap <expr> <Tab>
      \ wildmenumode() ? &wildcharm->nr2char() :
      \ pum#visible() ? '<Cmd>call pum#map#insert_relative(+1)<CR>' :
      \ ddc#map#manual_complete()
cnoremap <S-Tab> <Cmd>call pum#map#insert_relative(-1)<CR>
cnoremap <C-o>   <Cmd>call pum#map#confirm()<CR>
cnoremap <C-q>   <Cmd>call pum#map#select_relative(+1)<CR>
cnoremap <C-z>   <Cmd>call pum#map#select_relative(-1)<CR>
cnoremap <C-y>   <Cmd>call pum#map#confirm()<CR>
cnoremap <expr> <C-e> ddc#visible()
      \ ? '<Cmd>call ddc#hide()<CR>'
      \ : '<End>'

" Narrowing by ddu
inoremap <C-a> <Cmd>call ddu#start(#{
      \   name: 'ddc',
      \   ui: 'ff',
      \   sync: v:true,
      \   input: matchstr(getline('.')[: col('.') - 1], '\k*$'),
      \   sources: [
      \     #{ name: 'ddc', options: #{ defaultAction: 'complete' } },
      \   ],
      \   uiParams: #{
      \     ff: #{
      \       startFilter: v:true,
      \       replaceCol: match(getline('.')[: col('.') - 1], '\k*$') + 1,
      \     },
      \   },
      \ })<CR>

call ddc#enable(#{
      \   context_filetype: has('nvim') ? 'treesitter' : 'context_filetype',
      \ })
" }}}
