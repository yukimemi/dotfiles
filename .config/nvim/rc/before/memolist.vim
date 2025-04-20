" =============================================================================
" File        : memolist.vim
" Author      : yukimemi
" Last Change : 2025/04/17 13:16:42.
" =============================================================================

if isdirectory($HOME . '/GoogleDrive')
  let g:memolist_path = $HOME .. '/GoogleDrive/.memolist'
elseif has("win32")
  execute printf("let g:memolist_path = '%s\\.memolist'", expand($HOME))
else
  let g:memolist_path = $HOME .. '/.memolist'
endif

silent! call mkdir(g:memolist_path, 'p')

let g:memolist_memo_suffix = "md"
let g:memolist_prompt_tags = 1

" mappings
nnoremap <space>mn <cmd>MemoNew<cr>
nnoremap <space>ml <cmd>MemoList<cr>
nnoremap <space>mg <cmd>MemoGrep<cr>

