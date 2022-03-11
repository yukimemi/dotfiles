if !g:plugin_use_gina
  finish
endif

" nnoremap <leader>gs :<c-u>Gina status<cr>
nnoremap <leader>gc :<c-u>Gina commit -v<cr>
nnoremap <leader>gb :<c-u>Gina branch<cr>
nnoremap <leader>gg :<c-u>Gina grep<cr>
nnoremap <leader>gd :<c-u>Gina diff<cr>
nnoremap <leader>gl :<c-u>Gina log<cr>
nnoremap <leader>gL :<c-u>execute printf('Gina log -p %s', expand('%'))<cr>
nnoremap <leader>gp :<c-u>Gina push<cr>

