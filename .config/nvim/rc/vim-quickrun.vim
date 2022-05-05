if !g:plugin_use_quickrun
  finish
endif

let g:quickrun_config = get(g:, 'quickrun_config', {})
let g:quickrun_config['_'] = get(g:quickrun_config, '_', {})

if has('nvim')
  let g:quickrun_config._.runner = 'neovim_job'
elseif exists('*ch_close_in')
  let g:quickrun_config._.runner = 'job'
endif

map <leader>R <Plug>(quickrun)

function s:quickrun_sweep_sessions() abort
  echom "Stop quickrun"
  call quickrun#sweep_sessions()
endfunction

Keymap n <expr><silent> <c-c> quickrun#is_running() ? <SID>quickrun_sweep_sessions() : "\<c-c>"
