let g:reanimate_save_dir = $CACHE_HOME . "/save_point"
let g:reanimate_default_category = "def"
let g:reanimate_default_save_name = "lat"

function s:reanimate_save_cwd() abort
  let l:cmd = "ReanimateSave " . fnamemodify(getcwd(), ":t")
  echom l:cmd
  exe l:cmd
endfunction

function s:reanimate_load_cwd() abort
  let l:cmd = "ReanimateLoad " . fnamemodify(getcwd(), ":t")
  echom l:cmd
  exe l:cmd
endfunction

nnoremap <leader>rs <cmd>call <SID>reanimate_save_cwd()<cr>
nnoremap <leader>rl <cmd>call <SID>reanimate_load_cwd()<cr>

" nnoremap <leader>rs <cmd>ReanimateSave<cr>
" nnoremap <leader>rl <cmd>ReanimateLoad<cr>

" sessionoptions
" let g:reanimate_sessionoptions = "resize,winpos,winsize"

" au MyAutoCmd VimLeavePre * ReanimateSave
" au MyAutoCmd BufWritePost * ReanimateSave
" au MyAutoCmd VimEnter * ReanimateLoad

