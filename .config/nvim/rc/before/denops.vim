" =============================================================================
" File        : denops.vim
" Author      : yukimemi
" Last Change : 2025/01/02 14:07:06.
" =============================================================================

let g:denops#server#deno_args = ['-q', '--no-lock', '--unstable-kv', '--unstable-ffi', '-A']

" Interrupt the process of plugins via <c-c>
nnoremap <silent> <c-c> <Cmd>call denops#interrupt()<cr><C-c>
inoremap <silent> <c-c> <Cmd>call denops#interrupt()<cr><C-c>
" cnoremap <silent> <c-c> <Cmd>call denops#interrupt()<cr><C-c>

" Restart Denops server
command! DenopsRestart call denops#server#restart()

" Fix Deno module cache issue
command! DenopsFixCache call denops#cache#update(#{reload: v:true})

