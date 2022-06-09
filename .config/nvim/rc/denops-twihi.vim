function! s:twihi_keymap() abort
  Keymap n <buffer> <silent> y <Plug>(twihi:tweet:yank)
  Keymap n <buffer> <silent> l <Plug>(twihi:tweet:like)
  Keymap n <buffer> <silent> o <Plug>(twihi:tweet:open)
  Keymap n <buffer> <silent> r <Plug>(twihi:reply)
  Keymap n <buffer> <silent> R <Plug>(twihi:retweet)
  Keymap n <buffer> <silent> T <Plug>(twihi:retweet:comment)
  Keymap n <buffer> <silent> s <cmd>TwihiTweet<cr>
  Keymap n <buffer> S :<c-u>TwihiSearch<space>
endfunction

au MyAutoCmd FileType twihi-timeline call <SID>twihi_keymap()

Keymap n <leader>Th <cmd>TwihiHome<cr>
Keymap n <leader>Tm <cmd>TwihiMentions<cr>
