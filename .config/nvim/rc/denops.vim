let g:denops#debug = 0

" let g:denops#server#channel#deno_args = ['-q', '--no-check', '--allow-net', '--unsafely-ignore-certificate-errors']
if g:is_windows
  let g:denops#server#service#deno_args = ['-q', '--no-check', '--unstable', '-A', '--unsafely-ignore-certificate-errors']
endif

