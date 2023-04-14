if !g:plugin_use_ddc
  finish
endif

nnoremap :  <Cmd>call CommandlinePre(':')<CR>:
nnoremap /  <Cmd>call CommandlinePre('/')<CR>/
nnoremap ?  <Cmd>call CommandlinePre('/')<CR>?

function! CommandlinePre(mode) abort
  " NOTE: It disables default command line completion!
  set wildchar=<C-t>
  set wildcharm=<C-t>

  cnoremap <expr><buffer> <Tab>
        \ pum#visible() ?
        \  '<Cmd>call pum#map#insert_relative(+1)<CR>' :
        \ exists('b:ddc_cmdline_completion') ?
        \   ddc#map#manual_complete() : "\<C-t>"

  " Overwrite sources
  if !exists('b:prev_buffer_config')
    let b:prev_buffer_config = ddc#custom#get_buffer()
  endif
  if a:mode ==# ':'
    call ddc#custom#patch_buffer('keywordPattern', '[0-9a-zA-Z_:#-]*')
  endif

  autocmd MyAutoCmd User DDCCmdlineLeave ++once call CommandlinePost()
  autocmd MyAutoCmd InsertEnter <buffer> ++once call CommandlinePost()

  call ddc#enable_cmdline_completion()
endfunction
function! CommandlinePost() abort
  silent! cunmap <buffer> <Tab>

  " Restore sources
  if exists('b:prev_buffer_config')
    call ddc#custom#set_buffer(b:prev_buffer_config)
    unlet b:prev_buffer_config
  else
    call ddc#custom#set_buffer({})
  endif

  set wildcharm=<Tab>
endfunction
