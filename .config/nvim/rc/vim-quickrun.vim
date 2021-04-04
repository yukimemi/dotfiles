let g:quickrun_config = get(g:, 'quickrun_config', {})
let g:quickrun_config['_'] = get(g:quickrun_config, '_', {})

if has('nvim')
  let g:quickrun_config._.runner = 'neovim_job'
elseif exists('*ch_close_in')
  let g:quickrun_config._.runner = 'job'
endif

function! s:is_deno() abort
  if finddir('node_modules', expand('%:p:h') . ';') ==# ''
    let b:quickrun_config = get(b:, 'quickrun_config', {})
    let b:quickrun_config['typescript'] = extend({
      \  'type': 'typescript/deno',
      \}, get(g:quickrun_config, 'typescript', {}), "keep")
  endif
  call setenv('NO_COLOR', 1)
endfunction

au MyAutoCmd Filetype typescript call s:is_deno()

" dein settings
" typescript
let g:quickrun_config['typescript'] = extend({
      \ 'type': executable('ts-node') ? 'typescript/ts-node' :
      \         executable('tsc')     ? 'typescript/tsc'     :
      \         executable('deno')    ? 'typescript/deno'    :
      \         '',
      \ }, get(g:quickrun_config, 'typescript', {}), "keep")

" deno
let g:quickrun_config['typescript/deno'] = extend({
      \ 'command' : 'deno',
      \ 'cmdopt'  : 'run --unstable -A',
      \ 'hook/output_encode/enable'     : 1,
      \ 'hook/output_encode/fileformat' : 'unix',
      \ 'outputter/loclist/errorformat' : '%A%*[^:]: TS%n [%t%*[A-Z]]: %m,%Z    at file:\/\/\/%f:%l:%n,%C    %m,%-GCheck%.%#' ,
      \ }, get(g:quickrun_config, 'typescript/deno', {}), "keep")

map <leader>R <Plug>(quickrun)
