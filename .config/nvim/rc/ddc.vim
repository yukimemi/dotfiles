if !g:plugin_use_ddc
	finish
endif

inoremap <silent><expr> <c-f> ddc#complete_common_string()

" let s:defult_sources = ['around', 'nextword', 'ddc-path', 'git-file', 'git-commit', 'git-branch', 'file']
let s:defult_sources = ['vim-lsp', 'around', 'nextword', 'file']
let s:defult_sources_nvim = ['treesitter'] + s:defult_sources
let s:defult_sources_vim = s:defult_sources

" let s:lsp_sources_nvim = ['nvim-lsp'] + s:defult_sources_nvim
" let s:lsp_sources_nvim = ['vim-lsp'] + s:defult_sources_nvim
" let s:lsp_sources_vim = ['vim-lsp'] + s:defult_sources_vim

let s:lsp_languages = ['typescript', 'ps1', 'vim', 'rust', 'go', 'json']

function! CommandlinePre(mode) abort
	" Note: It disables default command line completion!
	cnoremap <expr> <Tab>
	\ pum#visible() ? '<Cmd>call pum#map#insert_relative(+1)<CR>' :
	\ ddc#manual_complete()
	cnoremap <S-Tab> <Cmd>call pum#map#insert_relative(-1)<CR>
	set wildchar=<C-t>
	"set cmdheight=1

	" Overwrite sources
	let s:prev_buffer_config = ddc#custom#get_buffer()
	if a:mode ==# ':'
		call ddc#custom#patch_buffer('sources',
						\ ['cmdline', 'cmdline-history', 'file', 'nextword', 'around'])
		call ddc#custom#patch_buffer('keywordPattern', '[0-9a-zA-Z_:#]*')
	else
		call ddc#custom#patch_buffer('sources',
						\ ['around', 'line', 'nextword'])
	endif

	au MyAutoCmd User DDCCmdlineLeave ++once call CommandlinePost()

	" Enable command line completion
	call ddc#enable_cmdline_completion()
	call ddc#enable()
endfunction

function! CommandlinePost() abort
	" Restore sources
	call ddc#custom#set_buffer(s:prev_buffer_config)
	silent! cunmap <Tab>
	set wildchar=<Tab>

	"try
	"  set cmdheight=0
	"catch
	"  set cmdheight=1
	"endtry
endfunction

" Use pum.vim
call ddc#custom#patch_global('completionMenu', 'pum.vim')
call ddc#custom#patch_global('autoCompleteEvents', [
			\ 'InsertEnter', 'TextChangedI', 'TextChangedP',
			\ 'CmdlineEnter', 'CmdlineChanged',
			\ ])

call ddc#custom#patch_global(
      \ 'sources', has('nvim') ?
      \ s:defult_sources_nvim :
      \ s:defult_sources_vim,
      \ )
call ddc#custom#patch_global('sourceOptions', {
      \ '_': {
      \   'ignoreCase': v:true,
      \   'matchers': ['matcher_head'],
      \   'sorters': ['sorter_rank'],
			\   'converters': ['converter_remove_overlap']
      \ },
      \ 'treesitter': {
      \   'mark': 'T'
      \ },
      \ 'around': {
      \   'mark': 'A',
      \   'matchers': ['matcher_head', 'matcher_length'],
      \ },
      \ 'necovim': {
      \   'mark': 'vim'
      \ },
      \ 'cmdline': {
      \   'mark': 'cmdline',
      \   'forceCompletionPattern': '\S/\S*',
      \ },
      \ 'cmdline-history': {'mark': 'history'},
      \ 'shell-history': {'mark': 'shell'},
      \ 'zsh': {
      \   'mark': 'zsh',
      \   'isVolatile': v:true,
      \   'forceCompletionPattern': '\S/\S*'
      \ },
      \ 'nextword': {
      \   'mark': 'nextword',
      \   'minAutoCompleteLength': 2,
      \   'isVolatile': v:true,
      \ },
      \ 'nvim-lsp': {
      \   'mark': 'nlsp',
      \   'forceCompletionPattern': '\.\w*|:\w*|->\w*'
      \ },
      \ 'vim-lsp': {
      \   'mark': 'vlsp',
      \   'forceCompletionPattern': '\.\w*|:\w*|->\w*'
      \ },
      \ 'file': {
      \   'mark': 'F',
      \   'isVolatile': v:true,
      \   'forceCompletionPattern': '\S/\S*',
      \ },
			\ 'path': { 'mark': 'P',
			\   'cmd': ['fd', '--max-depth', '5']
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
" call ddc#custom#patch_filetype(
"      \ s:lsp_languages, 'sources', has('nvim') ?
"      \ s:lsp_sources_nvim :
"      \ s:lsp_sources_vim,
"      \ )

let s:vim_sources = s:defult_sources_nvim + ['necovim']
call ddc#custom#patch_filetype(
			\ ['vim'], 'sources',
			\ s:vim_sources,
			\ )

call ddc#custom#patch_filetype(['FineCmdlinePrompt'], {
			\ 'keywordPattern': '[0-9a-zA-Z_:#]*',
			\ 'sources': ['cmdline', 'cmdline-history', 'around'],
			\ 'specialBufferCompletion': v:true,
			\ })

" inoremap <silent><expr> <TAB>
"			\ pum#visible() ? '<Cmd>call pum#map#insert_relative(+1)<CR>' :
"			\ (col('.') <= 1 <Bar><Bar> getline('.')[col('.') - 2] =~# '\s') ?
"			\ '<TAB>' : ddc#manual_complete()
" inoremap <S-Tab> <Cmd>call pum#map#insert_relative(-1)<cr>
" inoremap <c-n>   <Cmd>call pum#map#select_relative(+1)<cr>
" inoremap <c-p>   <Cmd>call pum#map#select_relative(-1)<cr>
inoremap <c-n>   <Cmd>call pum#map#insert_relative(+1)<cr>
inoremap <c-p>   <Cmd>call pum#map#insert_relative(-1)<cr>
inoremap <tab>   <Cmd>call pum#map#confirm()<cr>
" inoremap <c-e>   <Cmd>call pum#map#cancel()<cr>
inoremap <silent><expr> <c-e> ddc#map#extend()

nnoremap : <Cmd>call CommandlinePre(':')<cr>:
nnoremap ? <Cmd>call CommandlinePre('/')<cr>?
nnoremap / <Cmd>call CommandlinePre('/')<cr>/

call ddc#enable()

