if isdirectory($HOME . '/GoogleDrive')
  let g:memolist_path = $HOME . '/GoogleDrive/.memolist'
else
  let g:memolist_path = $HOME . '/.memolist'
endif

call Mkdir(g:memolist_path)

let g:memolist_memo_suffix = "md"
let g:memolist_prompt_tags = 1

" mappings
nnoremap <Leader>mn :<C-u>MemoNew<CR>
nnoremap <Leader>ml :<C-u>MemoList<CR>
nnoremap <Leader>mg :<C-u>MemoGrep<CR>


