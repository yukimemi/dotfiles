if !g:plugin_use_gin
  finish
endif

nnoremap <leader>gs <cmd>GinStatus<cr>
nnoremap <leader>gc <cmd>Gin commit -v<cr>
nnoremap <leader>gb <cmd>GinBranch<cr>
nnoremap <leader>gg <cmd>Gin grep<cr>
nnoremap <leader>gd <cmd>Gin diff<cr>
nnoremap <leader>gl <cmd>Gin log<cr>
nnoremap <leader>gL <cmd>execute printf('Gin log -p %s', expand('%'))<cr>
nnoremap <leader>gp <cmd>Gin push<cr>

