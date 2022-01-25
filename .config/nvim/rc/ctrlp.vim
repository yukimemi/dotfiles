if !g:plugin_use_ctrlp
  finish
endif

" let g:ctrlp_map = '<nop>'
let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_key_loop = 1
let g:ctrlp_lazy_update = 200
let g:ctrlp_line_prefix = '» '
let g:ctrlp_match_current_file = 1
" let g:ctrlp_match_window = 'bottom,order:btt,min:1,max:20,results:100'
let g:ctrlp_mruf_max = 100000
let g:ctrlp_show_hidden = 1
let g:ctrlp_use_caching = 1
let g:ctrlp_user_command_async = 1
nnoremap <silent> <leader>cp <cmd>CtrlP<cr>
nnoremap <silent> <leader>cb <cmd>CtrlPBuffer<cr>
nnoremap <silent> <leader>cd <cmd>CtrlPCurFile<cr>
" nnoremap <silent> <leader>cu <cmd>CtrlPMRUFiles<cr>
nnoremap <silent> <leader>cu <cmd>CtrlPMRMru<cr>
nnoremap <silent> <leader>cw <cmd>CtrlPMRMrw<cr>
nnoremap <silent> <leader>cr <cmd>CtrlPMRMrr<cr>
nnoremap <silent> <leader>cm <cmd>CtrlPMark<cr>
" nnoremap <silent> <leader>cl <cmd>CtrlPLine<cr>
" nnoremap <silent> <leader>cg <cmd>CtrlPChange<cr>
nnoremap <silent> <leader>cf <cmd>CtrlPFiletype<cr>
nnoremap <silent> <leader>cc <cmd>CtrlPLauncher<cr>
nnoremap <silent> <leader>ct <cmd>packadd sonictemplate-vim \| CtrlPSonictemplate<cr>
" nnoremap <silent> <leader>ch <cmd>CtrlPCmdHistory<cr>
nnoremap <silent> <leader>cS <cmd>CtrlPSearchHistory<cr>
nnoremap <silent> <leader>ch <cmd>CtrlPCommandLine<cr>
nnoremap <silent> <leader>cl <cmd>CtrlPMemolist<cr>
nnoremap <silent> <leader>cs <cmd>CtrlP ~/src<cr>
nnoremap <silent> <leader>cD <cmd>CtrlP ~/.dotfiles<cr>
nnoremap <silent> <leader>cC <cmd>CtrlP ~/.cache<cr>
nnoremap <silent> <leader>cG <cmd>CtrlPGhq<cr>

" Extensions
let g:ctrlp_extensions = get(g:, 'ctrlp_extensions', [])
let g:ctrlp_extensions += ['mr/mru', 'mr/mrw', 'mr/mrr']

command! CtrlPCommandLine silent! packadd vim-ctrlp-commandline | call ctrlp#init(ctrlp#commandline#id())

if executable('rg')
  let g:ctrlp_grep_command = 'rg -i --vimgrep --no-heading --hidden --no-ignore --regexp'
endif

" ctrlp-ghq
let g:ctrlp_ghq_cache_enabled = 1

if exists('*matchfuzzy')
  let g:ctrlp_match_func = {'match': 'ctrlp_matchfuzzy#matcher'}
endif

