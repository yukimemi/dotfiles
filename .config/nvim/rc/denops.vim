let g:denops#debug = 0
" let g:denops_server_addr = '127.0.0.1:32123'

" let g:denops#server#deno_args = ['-q', '--no-check', '--unstable', '-A', '--unsafely-ignore-certificate-errors']

if g:is_windows && !has('nvim')
  let g:denops_server_addr = '127.0.0.1:32123'

  let s:server = ch_open(g:denops_server_addr)

  if empty(s:server)
    silent! execute
          \ '!start /b cd'
          \ dein#get('denops.vim').path
          \ '& deno.exe run -A --no-check ./denops/@denops-private/cli.ts'
  endif

  silent! call ch_close(s:server)
  unlet s:server
endif
