let g:denops#debug = 1

let g:denops#server#channel#deno_args = ['-q', '--no-check', '--allow-net', '--unsafely-ignore-certificate-errors']
let g:denops#server#service#deno_args = ['-q', '--no-check', '--unstable', '-A', '--unsafely-ignore-certificate-errors']

