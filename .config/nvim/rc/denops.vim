let g:denops#debug = 0

" let g:denops#server#deno_args = ['-q', '--no-check', '--unstable', '-A', '--unsafely-ignore-certificate-errors']

if g:is_windows
  let g:denops_server_addr = '127.0.0.1:32123'
endif

