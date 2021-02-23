if !IsInstalled('ctrlp.vim')
  finish
endif

" let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_key_loop = 1
" let g:ctrlp_lazy_update = 200
let g:ctrlp_line_prefix = '» '
let g:ctrlp_map = '<nop>'
let g:ctrlp_match_current_file = 1
" let g:ctrlp_match_window = 'bottom,order:btt,min:1,max:20,results:100'
" let g:ctrlp_mruf_max = 100000
let g:ctrlp_show_hidden = 1
let g:ctrlp_use_caching = 1
let g:ctrlp_user_command_async = 1
nnoremap <silent> <leader>ff :<c-u>CtrlPCurFile<cr>
nnoremap <silent> <leader>fF :<c-u>CtrlPFiletype<cr>
nnoremap <silent> <leader>fl :<c-u>CtrlPLauncher<cr>
nnoremap <silent> <leader>f/ :<c-u>CtrlPSearchHistory<cr>
nnoremap <silent> <leader>fc :<c-u>CtrlPCmdHistory<cr>
" nnoremap <silent> <leader>fc :<c-u>CtrlPCommandLine<cr>
nnoremap <silent> <leader>fM :<c-u>CtrlPMemolist<cr>
nnoremap <silent> <leader>fs :<c-u>CtrlP ~/src<cr>
nnoremap <silent> <leader>fd :<c-u>CtrlP ~/.dotfiles<cr>

command! CtrlPCommandLine silent! packadd vim-ctrlp-commandline | call ctrlp#init(ctrlp#commandline#id())

au MyAutoCmd FileType ctrlp call <SID>my_ctrlp_settings()

function s:my_ctrlp_settings() abort
  let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']
endfunction

if executable('rg') && !g:is_windows
  let g:ctrlp_grep_command = 'rg -i --vimgrep --no-heading --hidden --no-ignore --regexp'
endif

if exists('*matchfuzzy')
  " Use ctrlp-matchfuzzy.
  let g:ctrlp_match_func = {'match': 'ctrlp_matchfuzzy#matcher'}
elseif has('python')
  " Use fruzzy.
  let g:fruzzy#usenative = 1
  let g:ctrlp_match_func = {'match': 'fruzzy#ctrlp#matcher'}
endif
