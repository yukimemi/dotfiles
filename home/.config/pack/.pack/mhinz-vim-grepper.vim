nnoremap <leader>g :Grepper -tool git<cr>
if executable("pt")
  nnoremap <leader>G :Grepper -tool pt<cr>
elseif executable("rg")
  nnoremap <leader>G :Grepper -tool rg<cr>
endif

nmap gs <Plug>(GrepperOperator)
xmap gs <Plug>(GrepperOperator)
