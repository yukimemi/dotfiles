if !g:plugin_use_ctrlp
  finish
endif

" let g:ctrlp_map = '<nop>'
" let g:ctrlp_match_window = 'bottom,order:btt,min:1,max:20,results:100'
let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_key_loop = 1
let g:ctrlp_lazy_update = 200
let g:ctrlp_line_prefix = '» '
let g:ctrlp_match_current_file = 1
let g:ctrlp_mruf_max = 100000
let g:ctrlp_show_hidden = 1
let g:ctrlp_use_caching = 1
let g:ctrlp_user_command_async = 1

" Keymap n <silent> <leader>cg <cmd>CtrlPChange<cr>
" Keymap n <silent> <leader>ch <cmd>CtrlPCmdHistory<cr>
" Keymap n <silent> <leader>cl <cmd>CtrlPLine<cr>
" Keymap n <silent> <leader>cu <cmd>CtrlPMRUFiles<cr>
Keymap n <silent> <leader>cC <cmd>CtrlP ~/.cache<cr>
Keymap n <silent> <leader>cD <cmd>CtrlP ~/.dotfiles<cr>
Keymap n <silent> <leader>cG <cmd>CtrlPGhq<cr>
Keymap n <silent> <leader>cS <cmd>CtrlPSearchHistory<cr>
Keymap n <silent> <leader>cb <cmd>CtrlPBuffer<cr>
Keymap n <silent> <leader>cc <cmd>CtrlPLauncher<cr>
Keymap n <silent> <leader>cd <cmd>CtrlPCurFile<cr>
Keymap n <silent> <leader>cf <cmd>CtrlPFiletype<cr>
Keymap n <silent> <leader>ch <cmd>CtrlPCommandLine<cr>
Keymap n <silent> <leader>cm <cmd>CtrlPMemolist<cr>
Keymap n <silent> <leader>cM <cmd>CtrlPMark<cr>
Keymap n <silent> <leader>cp <cmd>CtrlP<cr>
Keymap n <silent> <leader>cr <cmd>CtrlPMRMrr<cr>
Keymap n <silent> <leader>cs <cmd>CtrlP ~/src<cr>
Keymap n <silent> <leader>ct <cmd>packadd vim-sonictemplate \| CtrlPSonictemplate<cr>
Keymap n <silent> <leader>cu <cmd>CtrlPMRMru<cr>
Keymap n <silent> <leader>cw <cmd>CtrlPMRMrw<cr>

" Extensions
let g:ctrlp_extensions = get(g:, 'ctrlp_extensions', [])
let g:ctrlp_extensions += ['mr/mru', 'mr/mrw', 'mr/mrr']

command! CtrlPCommandLine silent! packadd vim-ctrlp-commandline | call ctrlp#init(ctrlp#commandline#id())

" ctrlp-grep
if executable('rg')
  let g:ctrlp_grep_command_definition = "rg -i --no-heading --regexp '{query}'"
endif

if executable('rg')
  let g:ctrlp_grep_command = 'rg -i --vimgrep --no-heading --hidden --no-ignore --regexp'
endif

" ctrlp-ghq
let g:ctrlp_ghq_cache_enabled = 1

if exists('*matchfuzzy')
  let g:ctrlp_match_func = {'match': 'ctrlp_matchfuzzy#matcher'}
endif

