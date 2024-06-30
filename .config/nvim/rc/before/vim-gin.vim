" =============================================================================
" File        : vim-gin.vim
" Author      : yukimemi
" Last Change : 2024/06/30 19:29:51.
" =============================================================================

nnoremap <space>gs <cmd>GinStatus<cr>
nnoremap <space>gc <cmd>Gin commit -v<cr>
nnoremap <space>gb <cmd>GinBranch<cr>
nnoremap <space>gd <cmd>GinDiff<cr>
nnoremap <space>gl <cmd>GinLog<cr>
nnoremap <space>gL <cmd>GinLog -p -- %<cr>
nnoremap <space>gp <cmd>Gin push<cr>
nnoremap <space>gg :<c-u>Gin grep<space>

au MyAutoCmd BufRead ginstatus://* call s:my_ginstatus_cfg()

function s:my_ginstatus_cfg() abort
  nnoremap <buffer> c <cmd>Gin commit -v<cr>
  nnoremap <buffer> d <cmd>GinDiff --cached<cr>
  nnoremap <buffer> L <cmd>GinLog --graph --oneline<cr>
  nnoremap <buffer> p <cmd>Gin push<cr>
  nnoremap <buffer> P <cmd>Gin pull<cr>
  nnoremap <buffer> q <cmd>q<cr>
  nnoremap <buffer> h <Plug>(gin-action-stage)
  xnoremap <buffer> h <Plug>(gin-action-stage)
  nnoremap <buffer> l <Plug>(gin-action-unstage)
  xnoremap <buffer> l <Plug>(gin-action-unstage)
endfunction



