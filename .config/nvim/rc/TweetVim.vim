au MyAutoCmd FileType tweetvim call s:my_tweetvim_mappings()
function! s:my_tweetvim_mappings()
  setl nowrap
  nnoremap <buffer> <space>s :<c-u>TweetVimSay<cr>
endfunction

nnoremap <silent> <space>tu :<c-u>silent! packadd webapi-vim \| packadd open-browser.vim \| packadd twibill.vim \| packadd bitly.vim \| packadd favstar-vim \| TweetVimUserStream<cr>
nnoremap <silent> <space>th :<c-u>silent! packadd webapi-vim \| packadd open-browser.vim \| packadd twibill.vim \| packadd bitly.vim \| packadd favstar-vim \| TweetVimHomeTimeline<cr>

let g:tweetvim_default_account = "yukimemi"
let g:tweetvim_tweet_per_page = 100
let g:tweetvim_cache_size = 50
"let g:tweetvim_display_username = 1
let g:tweetvim_display_source = 1
let g:tweetvim_display_time = 1
"let g:tweetvim_display_icon = 1
let g:tweetvim_async_post = 1
let g:tweetvim_display_separator = 0
let g:tweetvim_empty_separator = 1
let g:tweetvim_align_right = 0

