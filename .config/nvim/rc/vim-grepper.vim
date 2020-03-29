nnoremap <leader>g :Grepper -tool git<cr>
if executable("pt")
  nnoremap <leader>G :Grepper -tool pt<cr>
elseif executable("rg")
  nnoremap <leader>G :Grepper -tool rg<cr>
endif

nmap gs <Plug>(GrepperOperator)
xmap gs <Plug>(GrepperOperator)

au MyAutoCmd VimEnter * packadd vim-grepper | let g:grepper.tools = ['git', 'ag', 'ack', 'ack-grep', 'grep', 'rg', 'pt', 'sift', 'findstr']
