let g:ctrlp_map = '<nop>'
let g:ctrlp_use_caching = 1
let g:ctrlp_show_hidden = 1
let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_lazy_update = 200
let g:ctrlp_key_loop = 1
let g:ctrlp_match_window = 'bottom,order:btt,min:1,max:20,results:100'
let g:ctrlp_extensions = ['tag', 'buffertag', 'quickfix', 'dir', 'rtscript', 'undo', 'line', 'changes', 'mixed', 'bookmarkdir']
let g:ctrlp_line_prefix = '» '
let g:ctrlp_mruf_max = 100000
nnoremap <silent> scp :<C-u>CtrlP<CR>
nnoremap <silent> scb :<C-u>CtrlPBuffer<CR>
nnoremap <silent> scd :<C-u>CtrlPCurFile<CR>
nnoremap <silent> scu :<C-u>CtrlPMRU<CR>
nnoremap <silent> scm :<C-u>CtrlPMark<CR>
" nnoremap <silent> scl :<C-u>CtrlPLine<CR>
" nnoremap <silent> scg :<C-u>CtrlPChange<CR>
nnoremap <silent> scf :<C-u>CtrlPFiletype<CR>
nnoremap <silent> scc :<C-u>CtrlPLauncher<CR>
nnoremap <silent> sct :<C-u>packadd sonictemplate-vim \| CtrlPSonictemplate<CR>
nnoremap <silent> sch :<C-u>CtrlPCmdHistory<CR>
nnoremap <silent> scl :<C-u>CtrlPMemolist<CR>
nnoremap <silent> scg :<C-u>CtrlP ~/.ghq/src<CR>
nnoremap <silent> scG :<C-u>CtrlPGhq<CR>

if executable('files')
  let g:ctrlp_user_command = 'files -a %s'
endif

" if has('python') || has('python2') || has('python3')
"   let g:ctrlp_match_func = { 'match': 'pymatcher#PyMatch' }
" endif

" ctrlp-ghq
let g:ctrlp_ghq_cache_enabled = 1
