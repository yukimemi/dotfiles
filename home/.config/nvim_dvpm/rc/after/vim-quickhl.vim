" =============================================================================
" File        : vim-quickhl.vim
" Author      : yukimemi
" Last Change : 2025/04/27 11:08:13.
" =============================================================================

let g:quickhl_manual_enable_at_startup = 1

nnoremap <leader>mh <Plug>(quickhl-manual-this)
xnoremap <leader>mh <Plug>(quickhl-manual-this)
nnoremap <leader>mH <Plug>(quickhl-manual-reset)
xnoremap <leader>mH <Plug>(quickhl-manual-reset)

let g:quickhl_manual_keywords = [
      \ "失敗",
      \ "警告",
      \ "エラー",
      \ "異常",
      \ "warn",
      \ "WARN",
      \ "error",
      \ "ERROR",
      \ ]

