if !g:plugin_use_ddc
  finish
endif

let s:patch_global = {}
let s:sources = ['file', 'around', 'vsnip', 'buffer']
let s:sourceOptions = {}
let s:sourceParams = {}
let s:cmdlineSources = ['cmdline-history', 'input', 'file', 'around']
let s:filterParams = {}

if g:plugin_use_vimlsp
  call extend(['vim-lsp'], s:sources)
endif

if g:plugin_use_nvimlsp
  call extend(['nvim-lsp'], s:sources)
endif

if !g:is_windows
  call extend(['tmux'], s:sources)
endif

let s:sourceOptions._ = {
      \ 'ignoreCase': v:true,
      \ 'matchers': ['matcher_fuzzy'],
      \ 'sorters': ['sorter_fuzzy'],
      \ 'converters': [
      \   'converter_remove_overlap',
      \   'converter_truncate',
      \   'converter_fuzzy',
      \ ],
      \ }
let s:sourceOptions.around = {
      \ 'mark': '[ard]',
      \ 'isVolatile': v:true,
      \ }
let s:sourceOptions.file = {
      \ 'mark': '[file]',
      \ 'minAutoCompleteLength': 30,
      \ 'isVolatile': v:true,
      \ 'forceCompletionPattern': '[\w@:~._-]/[\w@:~._-]*',
      \ }
let s:sourceOptions['vim-lsp'] = {
      \ 'mark': '[lsp]',
      \ 'isVolatile': v:true,
      \ 'forceCompletionPattern': '\.|:\s*|->\s*',
      \ }
let s:sourceOptions['nvim-lsp'] = {
      \ 'mark': '[lsp]',
      \ 'isVolatile': v:true,
      \ 'forceCompletionPattern': '\.|:\s*|->\s*',
      \ }
let s:sourceOptions.necovim = {
      \ 'mark': '[vim]',
      \ 'isVolatile': v:true,
      \ }
let s:sourceOptions.emoji = {
      \ 'mark': '[emoji]',
      \ 'matchers': ['emoji'],
      \ 'sorters': [],
      \ }
let s:sourceOptions['cmdline-history'] = {
      \ 'mark': '[hist]',
      \ 'sorters': [],
      \ }
let s:sourceOptions.vsnip = {
      \ 'mark': '[snip]',
      \ 'dup': v:true,
      \ }
let s:sourceOptions.zsh = {
      \ 'mark': '[zsh]',
      \ 'isVolatile': v:true,
      \ 'forceCompletionPattern': '[\w@:~._-]/[\w@:~._-]*',
      \ }
let s:sourceOptions.mocword = {
      \ 'mark': '[word]',
      \ 'minAutoCompleteLength': 3,
      \ 'isVolatile': v:true,
      \ }
let s:sourceOptions.github_issue = {
      \ 'mark': '[issue]',
      \ 'forceCompletionPattern': '#\d*',
      \ }
let s:sourceOptions.github_pull_request = {
      \ 'mark': '[PR]',
      \ 'forceCompletionPattern': '#\d*',
      \ }
let s:sourceOptions.cmdline = {
      \ 'mark': '[cmd]',
      \ 'isVolatile': v:true,
      \ }
let s:sourceOptions.buffer = {'mark': '[buf]'}
let s:sourceOptions.tmux = {'mark': '[tmux]'}
let s:sourceOptions.omni = {'mark': '[omni]'}
let s:sourceOptions.line = {'mark': '[line]'}

let s:sourceParams.around = {'maxSize': 500}
let s:sourceParams.buffer = {
      \ 'requireSameFiletype': v:false,
      \ 'fromAltBuf': v:true,
      \ 'bufNameStyle': 'basename',
      \ }
let s:sourceParams.file = {
      \ 'trailingSlash': v:true,
      \ 'followSymlinks': v:true,
      \ }
let s:sourceParams['cmdline-history'] = {'maxSize': 100}
let s:sourceParams.tmux = {
      \ 'currentWinOnly': v:true,
      \ 'excludeCurrentPane': v:true,
      \ 'kindFormat': '#{pane_index}.#{pane_current_command}',
      \ }
let s:sourceParams['vim-lsp'] = {
      \ 'ignoreCompleteProvider': v:true,
      \ }

" let s:filterParams.converter_truncate = {
"      \ 'maxAbbrWidth': 40,
"      \ 'maxInfoWidth': 40,
"      \ 'maxKindWidth': 20,
"      \ 'maxMenuWidth': 20,
"      \ 'ellipsis': '..',
"      \ }

call ddc#custom#patch_filetype(
      \ ['vim', 'toml'], {
      \ 'sources': extend(['necovim'], s:sources),
      \ })
call ddc#custom#patch_filetype(
      \ ['toml'], {
      \ 'sourceOptions': {
      \   'vim-lsp': {'forceCompletionPattern': '\.|[={[,"]\s*'},
      \ }})
call ddc#custom#patch_filetype(
      \ ['markdown', 'gitcommit'], {
      \ 'sources': extend([
      \   'nextword',
      \   'github_issue', 'github_pull_request',
      \ ], s:sources),
      \ 'keywordPattern': '[a-zA-Z_:#]\k*',
      \ })
call ddc#custom#patch_filetype(
      \ ['ps1', 'dosbatch', 'autohotkey', 'registry'], {
      \ 'sourcesOptions': {
      \   'file': {'forceCompletionPattern': '[\w@:~._-]\\[\w@:~._-*'},
      \ },
      \ 'sourceParams': {
      \   'file': {'mode': 'win32'},
      \ }})
call ddc#custom#patch_filetype(
      \ ['ddu-ff-filter'], {
      \ 'sources': [],
      \ })
call ddc#custom#patch_filetype(
      \ ['sh', 'zsh'], {
      \ 'sources': extend(['zsh'], s:sources),
      \ })

call ddc#custom#patch_filetype(['FineCmdlinePrompt'], {
      \ 'keywordPattern': '[0-9a-zA-Z_:#]*',
      \ 'sources': ['cmdline-history', 'cmdline', 'around'],
      \ 'specialBufferCompletion': v:true,
      \ })


let s:patch_global.sources = s:sources
let s:patch_global.sourceOptions = s:sourceOptions
let s:patch_global.sourceParams = s:sourceParams
let s:patch_global.cmdlineSources = s:cmdlineSources
let s:patch_global.filterParams = s:filterParams
let s:patch_global.backspaceCompletion = v:true
let s:patch_global.specialBufferCompletion = v:true
let s:patch_global.overwriteCompleteopt = v:false

" Use pum.vim
let s:patch_global.ui = 'pum'
let s:patch_global.autoCompleteEvents = [
      \ 'InsertEnter', 'TextChangedI', 'TextChangedP',
      \ 'CmdlineEnter', 'CmdlineChanged', 'TextChangedT',
      \ ]

call ddc#custom#patch_global(s:patch_global)

" keymappings
" For insert mode completion
inoremap <silent><expr> <TAB>
      \ pum#visible() ? '<Cmd>call pum#map#insert_relative(+1)<CR>' :
      \ (col('.') <= 1 <Bar><Bar> getline('.')[col('.') - 2] =~# '\s') ?
      \ '<TAB>' : ddc#manual_complete()
inoremap <silent><expr> <C-n>
      \ pum#visible() ? '<Cmd>call pum#map#insert_relative(+1)<CR>' : ddc#manual_complete()
inoremap <S-Tab> <Cmd>call pum#map#insert_relative(-1)<CR>
" inoremap <C-n>   <Cmd>call pum#map#insert_relative(+1)<CR>
inoremap <C-p>   <Cmd>call pum#map#insert_relative(-1)<CR>
inoremap <C-y>   <Cmd>call pum#map#confirm()<CR>
inoremap <C-e>   <Cmd>call pum#map#cancel()<CR>
" inoremap <silent><expr> <C-l>   ddc#map#extend()
inoremap <silent><expr> <C-x><C-f> ddc#manual_complete('path')

" For command line mode completion
cnoremap <expr> <Tab>
      \ pum#visible() ? '<Cmd>call pum#map#insert_relative(+1)<CR>' :
      \ exists('b:ddc_cmdline_completion') ?
      \ ddc#manual_complete() : nr2char(&wildcharm)
cnoremap <S-Tab> <Cmd>call pum#map#insert_relative(-1)<CR>
cnoremap <C-c>   <Cmd>call pum#map#cancel()<CR>
cnoremap <C-o>   <Cmd>call pum#map#confirm()<CR>

nnoremap :       <Cmd>call CommandlinePre(':')<CR>:
nnoremap /       <Cmd>call CommandlinePre('/')<CR>/
nnoremap ?       <Cmd>call CommandlinePre('/')<CR>?

function! CommandlinePre(mode) abort
  " Note: It disables default command line completion!
  set wildchar=<C-t>
  set wildcharm=<C-t>

  cnoremap <expr><buffer> <Tab>
        \ pum#visible() ? '<Cmd>call pum#map#insert_relative(+1)<CR>' :
        \ exists('b:ddc_cmdline_completion') ? ddc#manual_complete() : "\<C-t>"

  " Overwrite sources
  if !exists('b:prev_buffer_config')
    let b:prev_buffer_config = ddc#custom#get_buffer()
  endif
  if a:mode ==# ':'
    call ddc#custom#patch_buffer('cmdlineSources',
          \ ['cmdline-history', 'cmdline', 'around'])
    call ddc#custom#patch_buffer('keywordPattern', '[0-9a-zA-Z_:#]*')
  else
    call ddc#custom#patch_buffer('cmdlineSources',
          \ ['around', 'line'])
  endif

  autocmd MyAutoCmd User DDCCmdlineLeave ++once call CommandlinePost()
  autocmd MyAutoCmd InsertEnter <buffer> ++once call CommandlinePost()

  call ddc#enable_cmdline_completion()
endfunction
function! CommandlinePost() abort
  silent! cunmap <buffer> <Tab>

  " Restore sources
  if exists('b:prev_buffer_config')
    call ddc#custom#set_buffer(b:prev_buffer_config)
    unlet b:prev_buffer_config
  else
    call ddc#custom#set_buffer({})
  endif

  set wildcharm=<Tab>
endfunction

call ddc#enable()

