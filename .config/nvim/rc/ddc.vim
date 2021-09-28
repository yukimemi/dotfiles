inoremap <silent><expr> <C-f> ddc#complete_common_string()
inoremap <silent><expr> <TAB>
      \ pumvisible() ? '<C-n>' :
      \ (col('.') <= 1 <Bar><Bar> getline('.')[col('.') - 2] =~# '\s') ?
      \ '<TAB>' : ddc#manual_complete()

let s:defult_sources = ['around', 'file', 'nextword']
let s:defult_sources_nvim = ['treesitter'] + s:defult_sources
let s:defult_sources_vim = s:defult_sources

let s:lsp_sources_nvim = ['nvim-lsp'] + s:defult_sources_nvim
let s:lsp_sources_vim = ['vim-lsp'] + s:defult_sources_vim

let s:lsp_languages = ['typescript', 'ps1', 'vim', 'rust', 'go']

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
      \   'converters': ['converter_remove_overlap'],
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
call ddc#custom#patch_filetype(
      \ s:lsp_languages, 'sources', has('nvim') ?
      \ s:lsp_sources_nvim :
      \ s:lsp_sources_vim,
      \ )
call ddc#enable()

