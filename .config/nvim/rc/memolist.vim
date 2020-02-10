if isdirectory($HOME . '/GoogleDrive')
  let g:memolist_path = $HOME . '/GoogleDrive/.memolist'
else
  let g:memolist_path = $HOME . '/.memolist'
endif

call Mkdir(g:memolist_path)

let g:memolist_memo_suffix = "md"
let g:memolist_prompt_tags = 1

" mappings
nnoremap <Leader>mn :<c-u>MemoNew<cr>
nnoremap <Leader>ml :<c-u>MemoList<cr>
nnoremap <Leader>mg :<c-u>MemoGrep<cr>


