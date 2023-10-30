" hook_add {{{
let g:memolist_path = expand('~/.memolist')
let g:memolist_memo_suffix = "md"
let g:memolist_prompt_tags = 1

" mappings
nnoremap <leader>mn <cmd>MemoNew<cr>
nnoremap <leader>ml <cmd>MemoList<cr>
nnoremap <leader>mg <cmd>MemoGrep<cr>
" }}}
