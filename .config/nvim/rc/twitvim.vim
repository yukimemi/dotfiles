let twitvim_count = 1000
let twitvim_browser_cmd = 'open'
nnoremap <F8> :FriendsTwitter<cr>
nnoremap <S-F8> :UserTwitter<cr>
nnoremap <A-F8> :RepliesTwitter<cr>
nnoremap <C-F8> :DMTwitter<cr>

au MyAutoCmd FileType twitvim call <SID>my_twitvim_settings()

function! s:my_twitvim_settings()
  nnoremap <buffer> <space>s :<c-u>PosttoTwitter<cr>
endfunction
