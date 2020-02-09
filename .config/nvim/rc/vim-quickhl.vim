let g:quickhl_manual_enable_at_startup = 1

nmap <space>m <Plug>(quickhl-manual-this)
xmap <space>m <Plug>(quickhl-manual-this)
nmap <space>M <Plug>(quickhl-manual-reset)
xmap <space>M <Plug>(quickhl-manual-reset)

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

