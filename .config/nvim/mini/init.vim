set encoding=utf-8
scriptencoding utf-8

let s:jetpackfile = expand('<sfile>:p:h') .. '/pack/jetpack/opt/vim-jetpack/plugin/jetpack.vim'
let s:jetpackurl = "https://raw.githubusercontent.com/tani/vim-jetpack/master/plugin/jetpack.vim"
if !filereadable(s:jetpackfile)
  call system(printf('curl -fsSLo %s --create-dirs %s', s:jetpackfile, s:jetpackurl))
endif

packadd vim-jetpack
call jetpack#begin()
Jetpack 'vim-denops/denops.vim'
Jetpack 'Shougo/ddu.vim'
Jetpack 'Shougo/ddu-ui-ff'
Jetpack 'Shougo/ddu-filter-matcher_substring'
Jetpack 'Shougo/ddu-commands.vim'
Jetpack 'Shougo/ddu-source-action'
Jetpack 'matsui54/ddu-source-command_history'
call jetpack#end()

for name in jetpack#names()
  if !jetpack#tap(name)
    call jetpack#sync()
    break
  endif
endfor

let g:denops_server_addr = '127.0.0.1:32123'
let s:denops_path = jetpack#get('denops.vim').path
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

call ddu#custom#patch_global({
      \   'ui': 'ff',
      \   'sourceOptions': {
      \     '_': {
      \       'ignoreCase': v:true,
      \       'matchers': ['matcher_substring'],
      \       'converters': ['matcher_substring'],
      \     },
      \   },
      \   'kindOptions': {
      \     'command_history': {
      \       'defaultAction': 'execute',
      \     },
      \   },
      \ })

function! s:ddu_ff_cfg() abort
  nnoremap <buffer><silent> <cr> <cmd>call ddu#ui#ff#do_action('itemAction')<cr>
endfunction

function! s:ddu_ff_filter_cfg() abort
  inoremap <buffer><silent> <cr> <esc><cmd>call ddu#ui#ff#do_action('itemAction')<cr>
  inoremap <buffer><silent><nowait> <esc> <esc><cmd>call ddu#ui#ff#close()<cr>
endfunction

au FileType ddu-ff call s:ddu_ff_cfg()
au FileType ddu-ff-filter call s:ddu_ff_filter_cfg()


