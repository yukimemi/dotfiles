" asyncomplete.vim {{{1
let g:asyncomplete_auto_popup = 1
let g:asyncomplete_smart_completion = 1
let g:asyncomplete_remove_duplicates = 1
let g:asyncomplete_force_refresh_on_context_changed = 1
imap <C-Space> <Plug>(asyncomplete_force_refresh)

" asyncomplete-buffer.vim {{{2
au MyAutoCmd User asyncomplete_setup silent! packadd asyncomplete-buffer.vim | call asyncomplete#register_source(asyncomplete#sources#buffer#get_source_options({
      \ 'name': 'buffer',
      \ 'whitelist': ['*'],
      \ 'priority': 1,
      \ 'completor': function('asyncomplete#sources#buffer#completor'),
      \ }))

" asyncomplete-file.vim {{{2
au MyAutoCmd User asyncomplete_setup silent! packadd asyncomplete-file.vim | call asyncomplete#register_source(asyncomplete#sources#file#get_source_options({
      \ 'name': 'file',
      \ 'whitelist': ['*'],
      \ 'priority': 1,
      \ 'completor': function('asyncomplete#sources#file#completor'),
      \ }))

" asyncomplete-emoji.vim {{{2
au MyAutoCmd User asyncomplete_setup silent! packadd asyncomplete-emoji.vim | call asyncomplete#register_source(asyncomplete#sources#emoji#get_source_options({
      \ 'name': 'emoji',
      \ 'whitelist': ['*'],
      \ 'blacklist': ['rust'],
      \ 'priority': 1,
      \ 'completor': function('asyncomplete#sources#emoji#completor'),
      \ }))

" asyncomplete-tags.vim {{{2
if executable('ctags')
  au MyAutoCmd User asyncomplete_setup silent! packadd asyncomplete-tags.vim | call asyncomplete#register_source(asyncomplete#sources#tags#get_source_options({
        \ 'name': 'tags',
        \ 'whitelist': ['*'],
        \ 'priority': 2,
        \ 'completor': function('asyncomplete#sources#tags#completor'),
        \ 'config': {
        \    'max_file_size': 20000000,
        \ }
        \ }))
endif

" asyncomplete-omni.vim {{{2
" au MyAutoCmd User asyncomplete_setup silent! packadd asyncomplete-omni.vim | call asyncomplete#register_source(asyncomplete#sources#omni#get_source_options({
"      \ 'name': 'omni',
"      \ 'whitelist': ['*'],
"      \ 'blacklist': ['go', 'rust'],
"      \ 'priority': 3,
"      \ 'completor': function('asyncomplete#sources#omni#completor')
"      \ }))

" asyncomplete-neosnippet.vim {{{2
au MyAutoCmd User asyncomplete_setup silent! packadd asyncomplete-neosnippet.vim | call asyncomplete#register_source(asyncomplete#sources#neosnippet#get_source_options({
      \ 'name': 'neosnippet',
      \ 'whitelist': ['*'],
      \ 'priority': 3,
      \ 'completor': function('asyncomplete#sources#neosnippet#completor'),
      \ }))

" asyncomplete-necosyntax.vim {{{2
au MyAutoCmd User asyncomplete_setup silent! packadd asyncomplete-necosyntax.vim | call asyncomplete#register_source(asyncomplete#sources#necosyntax#get_source_options({
      \ 'name': 'necosyntax',
      \ 'whitelist': ['*'],
      \ 'priority': 4,
      \ 'completor': function('asyncomplete#sources#necosyntax#completor'),
      \ }))

" asyncomplete-necovim.vim {{{2
au MyAutoCmd FileType vim call <SID>asyncomplete_necovim_aft()
function! s:asyncomplete_necovim_aft() abort
  silent! packadd asyncomplete-necovim.vim
  call asyncomplete#register_source(asyncomplete#sources#necovim#get_source_options({
        \ 'name': 'necovim',
        \ 'whitelist': ['vim'],
        \ 'priority': 4,
        \ 'completor': function('asyncomplete#sources#necovim#completor'),
        \ }))
endfunction

" asyncomplete-racer.vim {{{2
if !executable('rls')
  au MyAutoCmd FileType rust call <SID>asyncomplete_racer_aft()
endif
function! s:asyncomplete_racer_aft() abort
  silent! packadd asyncomplete-racer.vim
  call asyncomplete#register_source(asyncomplete#sources#racer#get_source_options({
        \ 'priority': 4,
        \ }))
endfunction

" asyncomplete-gocode.vim {{{2
if !executable('gopls') && executable('gocode')
  au MyAutoCmd FileType go call <SID>asyncomplete_gocode_aft()
endif
function! s:asyncomplete_gocode_aft() abort
  silent! packadd asyncomplete-gocode.vim
  call asyncomplete#register_source(asyncomplete#sources#gocode#get_source_options({
        \ 'name': 'gocode',
        \ 'whitelist': ['go'],
        \ 'priority': 4,
        \ 'completor': function('asyncomplete#sources#gocode#completor'),
        \ }))
endfunction

" vim-lsp. {{{2
" let g:lsp_signs_enabled = 1
let g:lsp_auto_enable = 1
let g:lsp_insert_text_enabled = 1
let g:lsp_async_completion = 1
let g:lsp_diagnostics_enabled = 1
let g:lsp_diagnostics_echo_cursor = 1

au MyAutoCmd FileType go,rust,python,typescript,javascript call <SID>lsp_settings()

function! s:lsp_settings() abort
  nmap <silent> gd <plug>(lsp-definition)
  nmap <silent> gp <plug>(lsp-hover)
  nmap <silent> gr <plug>(lsp-references)
  nmap <silent> gi <plug>(lsp-implementation)
  nmap <silent> <Leader>s :<C-u>split \| :LspDefinition<CR>
  nmap <silent> <Leader>v :<C-u>vsplit \| :LspDefinition<CR>
  setl omnifunc=lsp#complete
  setl completeopt+=preview
endfunction

" Docker. {{{3
if executable('docker-langserver')
  au MyAutoCmd User lsp_setup call lsp#register_server({
        \ 'name': 'docker-langserver',
        \ 'cmd': {server_info->[&shell, &shellcmdflag, 'docker-langserver --stdio']},
        \ 'whitelist': ['dockerfile'],
        \ })
endif

" go. {{{3
if executable('gopls')
  au MyAutoCmd User lsp_setup call lsp#register_server({
        \ 'name': 'gopls',
        \ 'cmd': {server_info->['gopls', '-mode', 'stdio']},
        \ 'whitelist': ['go'],
        \ })
elseif executable('go-langserver')
  au MyAutoCmd User lsp_setup call lsp#register_server({
        \ 'name': 'go-langserver',
        \ 'cmd': {server_info->['go-langserver', '-gocodecompletion']},
        \ 'whitelist': ['go'],
        \ })
elseif executable('bingo')
  au MyAutoCmd User lsp_setup call lsp#register_server({
        \ 'name': 'bingo',
        \ 'cmd': {server_info->['bingo', '-mode', 'stdio']},
        \ 'whitelist': ['go'],
        \ })
endif

" python. {{{3
if executable('pyls')
  au MyAutoCmd User lsp_setup call lsp#register_server({
        \ 'name': 'pyls',
        \ 'cmd': {server_info->['pyls']},
        \ 'whitelist': ['python'],
        \ })
endif

" rust. {{{3
if executable('rls')
  au MyAutoCmd User lsp_setup call lsp#register_server({
        \ 'name': 'rls',
        \ 'cmd': {server_info->['rustup', 'run', 'stable', 'rls']},
        \ 'root_uri':{server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), 'Cargo.toml'))},
        \ 'whitelist': ['rust'],
        \ })
endif

" typescript. {{{3
if executable('typescript-language-server')
  au MyAutoCmd User lsp_setup call lsp#register_server({
        \ 'name': 'typescript-language-server',
        \ 'cmd': { server_info->[&shell, &shellcmdflag, 'typescript-language-server --stdio']},
        \ 'root_uri': { server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_directory(lsp#utils#get_buffer_path(), '.git/..'))},
        \ 'whitelist': ['typescript', 'javascript', 'javascript.jsx']
        \ })
endif


" debug. {{{1
if 0
  call Mkdir(expand('~/.log/vim'))
  let g:lsp_log_verbose = 1
  let g:lsp_log_file = expand('~/.log/vim/vim-lsp.log')

  " for asyncomplete.vim log
  let g:asyncomplete_log_file = expand('~/.log/vim/asyncomplete.log')
endif

