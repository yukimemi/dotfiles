let g:ctrlp_map = '<nop>'
let g:ctrlp_use_caching = 1
let g:ctrlp_show_hidden = 1
let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_lazy_update = 1
let g:ctrlp_extensions = ['line', 'changes', 'bookmarkdir', 'memolist']
nnoremap scp :<C-u>CtrlP<CR>
nnoremap scb :<C-u>CtrlPBuffer<CR>
nnoremap scd :<C-u>CtrlPCurWD<CR>
nnoremap scu :<C-u>CtrlPMRU<CR>
nnoremap scm :<C-u>CtrlPMark<CR>
" nnoremap scl :<C-u>CtrlPLine<CR>
nnoremap scg :<C-u>CtrlPChange<CR>
nnoremap scf :<C-u>CtrlPFiletype<CR>
" nnoremap scl :<C-u>CtrlPLauncher<CR>
nnoremap sct :<C-u>CtrlPSonictemplate<CR>
nnoremap sch :<C-u>CtrlPCmdHistory<CR>

nnoremap scl :<C-u>CtrlPMemolist<CR>

if executable('rg')
  let g:ctrlp_user_command ='rg -F --files %s'
endif

