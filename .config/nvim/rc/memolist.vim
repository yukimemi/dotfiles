if isdirectory($HOME . '/GoogleDrive')
  let g:memolist_path = $HOME . '/GoogleDrive/.memolist'
else
  let g:memolist_path = $HOME . '/.memolist'
endif

silent! call mkdir(g:memolist_path, 'p')

let g:memolist_memo_suffix = "md"
let g:memolist_prompt_tags = 1

" mappings
nnoremap <leader>mn :<c-u>MemoNew<cr>
nnoremap <leader>ml :<c-u>MemoList<cr>
nnoremap <leader>mg :<c-u>MemoGrep<cr>


