" =============================================================================
" File        : denops.vim
" Author      : yukimemi
" Last Change : 2024/11/18 23:53:55.
" =============================================================================

let g:denops#server#deno_args = ['-q', '--no-lock', '--unstable-kv', '--unstable-ffi', '-A']

" Interrupt the process of plugins via <C-c>
nnoremap <silent> <C-c> <Cmd>call denops#interrupt()<CR><C-c>
inoremap <silent> <C-c> <Cmd>call denops#interrupt()<CR><C-c>
cnoremap <silent> <C-c> <Cmd>call denops#interrupt()<CR><C-c>

" Restart Denops server
command! DenopsRestart call denops#server#restart()

" Fix Deno module cache issue
command! DenopsFixCache call denops#cache#update(#{reload: v:true})

