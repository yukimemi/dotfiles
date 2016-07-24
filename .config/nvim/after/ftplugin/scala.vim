" http://vim-users.jp/2013/02/vim-advent-calendar-2012-ujihisa-4/
function! s:ujihisa_start_sbt()"{{{
  execute 'VimShellInteractive sbt'
  stopinsert
  let t:sbt_bufname = bufname('%')
  if !has_key(t:, 'sbt_cmds')
    let t:sbt_cmds = [input('t:sbt_cmds[0] = ')]
  endif
  wincmd p
endfunction

command! -nargs=0 StartSBT call <SID>ujihisa_start_sbt()
"}}}

function! s:sbt_run()"{{{
  let cmds = get(t:, 'sbt_cmds', 'run')

  let sbt_bufname = get(t:, 'sbt_bufname')
  if sbt_bufname !=# ''
    call vimshell#interactive#set_send_buffer(sbt_bufname)
    call vimshell#interactive#send(cmds)
  else
    echoerr 'try StartSBT'
  endif
endfunction
"}}}

function! s:vimrc_scala()"{{{
  nnoremap <buffer> [Space]m :<C-u>write<Cr>:call <SID>sbt_run()<Cr>
endfunction
"}}}

augroup vimrc_scala"{{{
  autocmd!
  au FileType scala call s:vimrc_scala()
  au FileType scala nnoremap <buffer> [Space]st :<C-u>StartSBT<Cr>
augroup END
"}}}
