let g:reanimate_save_dir = $CACHE_HOME . "/reanimate"
let g:reanimate_default_category = "def"
let g:reanimate_default_save_name = "lat"

let g:reanimate_event_disables = {
      \	"_" : {
      \		"reanimate_confirm" : 1
      \	}
      \ }

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

au MyAutoCmd VimLeavePre * silent! call <SID>reanimate_save_cwd()
au MyAutoCmd BufWritePost * silent! call <SID>reanimate_save_cwd()

