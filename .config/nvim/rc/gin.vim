if !g:plugin_use_gin
  finish
endif

nnoremap <leader>gs :<c-u>GinStatus<cr>
nnoremap <leader>gc :<c-u>Gin commit -v<cr>
nnoremap <leader>gb :<c-u>Gin branch<cr>
nnoremap <leader>gg :<c-u>Gin grep<cr>
nnoremap <leader>gd :<c-u>Gin diff<cr>
nnoremap <leader>gl :<c-u>Gin log<cr>
nnoremap <leader>gL :<c-u>execute printf('Gin log -p %s', expand('%'))<cr>
nnoremap <leader>gp :<c-u>Gin push<cr>

