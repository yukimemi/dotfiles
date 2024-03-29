if isdirectory($HOME . '/GoogleDrive')
  let g:memolist_path = $HOME .. '/GoogleDrive/.memolist'
elseif g:is_windows
  execute printf("let g:memolist_path = '%s\\.memolist'", expand($HOME))
else
  let g:memolist_path = $HOME .. '/.memolist'
endif

silent! call mkdir(g:memolist_path, 'p')

let g:memolist_memo_suffix = "md"
let g:memolist_prompt_tags = 1
let g:memolist_ex_cmd = 'Ctrlp'

" mappings
nnoremap <localleader>mn :<c-u>MemoNew<cr>
nnoremap <localleader>ml :<c-u>MemoList<cr>
nnoremap <localleader>mg :<c-u>MemoGrep<cr>

