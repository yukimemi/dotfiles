" Show line numbers in search rusults
let g:any_jump_list_numbers = 0

" Auto search references
let g:any_jump_references_enabled = 1

" Auto group results by filename
let g:any_jump_grouping_enabled = 1

" Amount of preview lines for each search result
let g:any_jump_preview_lines_count = 5

" Max search results, other results can be opened via [a]
let g:any_jump_max_search_results = 10

" Prefered search engine: rg or ag
let g:any_jump_search_prefered_engine = 'rg'

" Search results list styles:
" - 'filename_first'
" - 'filename_last'
let g:any_jump_results_ui_style = 'filename_first'

" Any-jump window size & position options
" let g:any_jump_window_width_ratio  = 0.6
" let g:any_jump_window_height_ratio = 0.6
" let g:any_jump_window_top_offset   = 4


" Disable default any-jump keybindings (default: 0)
let g:any_jump_disable_default_keybindings = 0

" Remove comments line from search results (default: 1)
let g:any_jump_remove_comments_from_results = 1

" Custom ignore files
" default is: ['*.tmp', '*.temp']
let g:any_jump_ignored_files = ['*.tmp', '*.temp']

" Search references only for current file type
" (default: false, so will find keyword in all filetypes)
let g:any_jump_references_only_for_current_filetype = 0

" Disable search engine ignore vcs untracked files
" (default: false, search engine will ignore vcs untracked files)
let g:any_jump_disable_vcs_ignore = 0

nnoremap <leader>j  :AnyJump<cr>
xnoremap <leader>j  :AnyJumpVisual<cr>
nnoremap <leader>ab :AnyJumpBack<cr>
nnoremap <leader>al :AnyJumpLastResults<cr>
