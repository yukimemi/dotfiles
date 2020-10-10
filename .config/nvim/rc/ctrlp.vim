let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_extensions = ['tag', 'buffertag', 'quickfix', 'dir', 'rtscript', 'undo', 'line', 'changes', 'mixed', 'bookmarkdir', 'commandline']
let g:ctrlp_key_loop = 1
let g:ctrlp_lazy_update = 200
let g:ctrlp_line_prefix = '» '
let g:ctrlp_map = '<nop>'
let g:ctrlp_match_current_file = 1
let g:ctrlp_match_window = 'bottom,order:btt,min:1,max:20,results:100'
let g:ctrlp_mruf_max = 100000
let g:ctrlp_show_hidden = 1
let g:ctrlp_use_caching = 1
let g:ctrlp_user_command_async = 1
nnoremap <silent> scp :<c-u>CtrlP<cr>
nnoremap <silent> scb :<c-u>CtrlPBuffer<cr>
nnoremap <silent> scd :<c-u>CtrlPCurFile<cr>
nnoremap <silent> scu :<c-u>CtrlPMRUFiles<cr>
nnoremap <silent> scm :<c-u>CtrlPMark<cr>
" nnoremap <silent> scl :<c-u>CtrlPLine<cr>
" nnoremap <silent> scg :<c-u>CtrlPChange<cr>
nnoremap <silent> scf :<c-u>CtrlPFiletype<cr>
nnoremap <silent> scc :<c-u>CtrlPLauncher<cr>
nnoremap <silent> sct :<c-u>packadd sonictemplate-vim \| CtrlPSonictemplate<cr>
" nnoremap <silent> sch :<c-u>CtrlPCmdHistory<cr>
nnoremap <silent> scs :<c-u>CtrlPSearchHistory<cr>
nnoremap <silent> sch :<c-u>CtrlPCommandLine<cr>
nnoremap <silent> scl :<c-u>CtrlPMemolist<cr>
nnoremap <silent> scr :<c-u>CtrlP ~/src<cr>
nnoremap <silent> scD :<c-u>CtrlP ~/.dotfiles<cr>
nnoremap <silent> scC :<c-u>CtrlP ~/.cache<cr>
nnoremap <silent> scG :<c-u>CtrlPGhq<cr>

command! CtrlPCommandLine silent! packadd vim-ctrlp-commandline | call ctrlp#init(ctrlp#commandline#id())
cnoremap <silent> <c-f> :<c-u>call ctrlp#init(ctrlp#commandline#id())<cr>

if executable('rg')
  let g:ctrlp_grep_command = 'rg -i --vimgrep --no-heading --hidden --no-ignore --regexp'
endif

" ctrlp-ghq
let g:ctrlp_ghq_cache_enabled = 1

if exists('matchfuzzy')
  " Use ctrlp-matchfuzzy.
  let g:ctrlp_match_func = {'match': 'ctrlp_matchfuzzy#matcher'}
else
  " Use fruzzy.
  let g:fruzzy#usenative = 1
  let g:ctrlp_match_func = {'match': 'fruzzy#ctrlp#matcher'}
endif

