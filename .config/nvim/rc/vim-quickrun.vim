let g:quickrun_config = {'_': {}}

if has('nvim')
  let g:quickrun_config._.runner = 'neovim_job'
elseif exists('*ch_close_in')
  let g:quickrun_config._.runner = 'job'
endif

map <leader>R <Plug>(quickrun)
