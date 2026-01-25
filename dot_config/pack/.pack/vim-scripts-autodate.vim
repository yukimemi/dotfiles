let g:autodate_format = "%Y/%m/%d %H:%M:%S"
let g:autodate_keyword_pre  = "Last Change *:"
let g:autodate_keyword_post = "."
au MyAutoCmd FileType markdown call <SID>autodate_markdown()
function! s:autodate_markdown() abort
  let b:autodate_format = "%Y-%m-%dT%H:%M:%S+09:00"
  let b:autodate_keyword_pre  = 'date: "'
  let b:autodate_keyword_post = '"'
endfunction

