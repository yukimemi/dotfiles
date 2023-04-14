let g:quickhl_manual_enable_at_startup = 1

Keymap nx <leader>m <Plug>(quickhl-manual-this)
Keymap nx <leader>M <Plug>(quickhl-manual-reset)

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

