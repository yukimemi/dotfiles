let g:denops#debug = 0

" let g:denops#server#deno_args = ['-q', '--no-check', '--unstable', '-A', '--unsafely-ignore-certificate-errors']

" If you use dein.vim, you can get the path via `dein#get('denops.vim').path`.
" Or if you are a user of jetpack.vim, you can use `jetpack#get('denops.vim').path`.
" https://github.com/vim-denops/denops.vim/wiki/Configurations-for-shared-server

if g:is_windows
  finish
endif

let g:denops_server_addr = '127.0.0.1:32123'
if g:plugin_use_dein
  let s:denops_path = dein#get('denops.vim').path
elseif g:plugin_use_jetpack
  let s:denops_path = jetpack#get('denops.vim').path
endif
if has('nvim')
  call jobstart(
        \ 'deno run -A --no-check ' . s:denops_path . '/denops/@denops-private/cli.ts',
        \ {'detach': v:true}
        \ )
else
  call job_start(
        \ 'deno run -A --no-check ' . s:denops_path . '/denops/@denops-private/cli.ts',
        \ {'stoponexit': ''}
        \ )
endif
