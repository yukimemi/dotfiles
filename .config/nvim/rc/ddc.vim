if !g:plugin_use_ddc
  finish
endif

" let s:default_sources = ['around', 'mocword', 'ddc-path', 'git-file', 'git-commit', 'git-branch', 'file']
" let s:default_sources = ['around', 'buffer', 'mocword', 'file']
let s:default_sources = ['around', 'buffer', 'nextword', 'file']
if g:plugin_use_vimlsp
  let s:default_sources = ['vim-lsp'] + s:default_sources
endif
if g:plugin_use_nvimlsp
  let s:default_sources = ['nvim-lsp'] + s:default_sources
endif

if !g:is_windows
  let s:default_sources = s:default_sources + ['rg']
endif

let s:defult_sources_nvim = ['treesitter'] + s:default_sources
let s:defult_sources_vim = s:default_sources

let s:lsp_languages = ['typescript', 'ps1', 'vim', 'rust', 'go', 'json']

call ddc#custom#patch_global(
\ 'sources', has('nvim') ?
\ s:defult_sources_nvim :
\ s:defult_sources_vim,
\ )

call ddc#custom#patch_global('cmdlineSources',
\ ['cmdline-history', 'input', 'file', 'around']
\ )

call ddc#custom#patch_global('sourceOptions', {
\ '_': {
\   'ignoreCase': v:true,
\   'matchers': ['matcher_head'],
\   'sorters': ['sorter_rank'],
\   'converters': ['converter_remove_overlap', 'converter_truncate_abbr'],
\ },
\ 'treesitter': {
\   'mark': 'T'
\ },
\ 'around': {
\   'mark': 'A',
\   'matchers': ['matcher_head', 'matcher_length'],
\ },
\ 'buffer': {
\   'mark': 'B'
\ },
\ 'necovim': {
\   'mark': 'vim'
\ },
\ 'cmdline': {
\   'mark': 'cmdline',
\   'forceCompletionPattern': '\S/\S*',
\ },
\ 'cmdline-history': {
\   'mark': 'history',
\   'sorters': [],
\ },
\ 'shell-history': {'mark': 'shell'},
\ 'zsh': {
\   'mark': 'zsh',
\   'isVolatile': v:true,
\   'forceCompletionPattern': '\S/\S*'
\ },
\ 'nextword': {
\   'mark': 'nextword',
\   'minAutoCompleteLength': 3,
\   'isVolatile': v:true,
\ },
\ 'mocword': {
\   'mark': 'mocword',
\   'minAutoCompleteLength': 3,
\   'isVolatile': v:true,
\ },
\ 'nvim-lsp': {
\   'mark': 'lsp',
\   'forceCompletionPattern': '\.\w*|:\w*|->\w*'
\ },
\ 'vim-lsp': {
\   'mark': 'lsp',
\   'forceCompletionPattern': '\.\w*|:\w*|->\w*'
\ },
\ 'file': {
\   'mark': 'F',
\   'isVolatile': v:true,
\   'minAutoCompleteLength': 1000,
\   'forceCompletionPattern': '\S/\S*'
\ },
\ 'path': {
\   'mark': 'P',
\   'cmd': ['fd', '--max-depth', '5']
\ },
\ 'look': {
\   'converters': ['loud', 'matcher_head'],
\   'matchers': [],
\   'mark': 'l',
\   'isVolatile': v:true
\ },
\ 'rg': {
\   'mark': 'rg',
\   'matchers': ['matcher_head', 'matcher_length'],
\   'minAutoCompleteLength': 4,
\ },
\ })

call ddc#custom#patch_global('sourceParams', {
\ 'buffer': {
\   'requireSameFiletype': v:false,
\   'limitBytes': 5000000,
\   'fromAltBuf': v:true,
\   'forceCollect': v:true,
\ },
\ 'look': {
\   'convertCase': v:true,
\   'dict': v:null,
\ },
\ })

call ddc#custom#patch_global('filterParams', {
\ 'converter_fuzzy': {
\   'hlGroup': 'SpellBad'
\ }
\ })

call ddc#custom#patch_filetype(
\ ['ps1', 'dosbatch', 'autohotkey', 'registry'], {
\ 'sourceOptions': {
\   'file': {
\     'forceCompletionPattern': '\S\\\S*',
\   },
\ },
\ 'sourceParams': {
\   'file': {
\     'mode': 'win32',
\   },
\ }})

if has('nvim')
  let s:vim_sources = s:defult_sources_nvim + ['necovim']
else
  let s:vim_sources = s:defult_sources_vim + ['necovim']
endif
call ddc#custom#patch_filetype(
\ ['vim'], 'sources',
\ s:vim_sources,
\ )

call ddc#custom#patch_filetype(['FineCmdlinePrompt'], {
\ 'keywordPattern': '[0-9a-zA-Z_:#]*',
\ 'sources': ['cmdline', 'cmdline-history', 'around'],
\ 'specialBufferCompletion': v:true,
\ })

" Use pum.vim
call ddc#custom#patch_global('autoCompleteEvents', [
\ 'InsertEnter', 'TextChangedI', 'TextChangedP',
\ 'CmdlineEnter', 'CmdlineChanged',
\ ])
call ddc#custom#patch_global('completionMenu', 'pum.vim')

function! CommandlinePre(mode) abort
  " Note: It disables default command line completion!
  set wildchar=<C-t>

  " Overwrite sources
  if !exists('b:prev_buffer_config')
    let b:prev_buffer_config = ddc#custom#get_buffer()
  endif
  if a:mode ==# ':'
    call ddc#custom#patch_buffer('cmdlineSources', ['cmdline', 'cmdline-history', 'file', 'buffer', 'around'])
    call ddc#custom#patch_buffer('keywordPattern', '[0-9a-zA-Z_:#]*')
  else
    " call ddc#custom#patch_buffer('cmdlineSources', ['around', 'buffer', 'line', 'mocword'])
    call ddc#custom#patch_buffer('cmdlineSources', ['around', 'buffer', 'line', 'nextword'])
  endif

  au MyAutoCmd User DDCCmdlineLeave ++once call CommandlinePost()
  au MyAutoCmd InsertEnter <buffer> ++once call CommandlinePost()

  " Enable command line completion
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

  set wildchar=<Tab>
endfunction

" For insert mode completion
Keymap i <silent><expr> <c-f>      ddc#complete_common_string()
Keymap i <silent><expr> <c-space>  ddc#manual_complete()
Keymap i <silent><expr> <c-x><c-f> ddc#manual_complete('path')
Keymap i <silent>       <c-n>      <cmd>call pum#map#insert_relative(+1)<cr>
Keymap i <silent>       <c-p>      <cmd>call pum#map#insert_relative(-1)<cr>
Keymap i <silent><expr> <c-e>      ddc#map#extend()

Keymap n : <cmd>call CommandlinePre(':')<cr>:
Keymap n / <cmd>call CommandlinePre('/')<cr>/
Keymap n ? <cmd>call CommandlinePre('?')<cr>?

" For command line mode completion
Keymap c <expr> <Tab> pum#visible() ? '<Cmd>call pum#map#insert_relative(+1)<CR>' : exists('b:ddc_cmdline_completion') ? ddc#manual_complete() : "\<Tab>"
Keymap c <S-Tab> <cmd>call pum#map#insert_relative(-1)<CR>
Keymap c <C-c>   <cmd>call pum#map#cancel()<CR>
Keymap c <C-j>   <cmd>call pum#map#select_relative(+1)<CR>
Keymap c <C-k>   <cmd>call pum#map#select_relative(-1)<CR>
Keymap c <C-o>   <cmd>call pum#map#confirm()<CR>

call ddc#enable()

