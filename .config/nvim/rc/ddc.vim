inoremap <silent><expr> <C-f> ddc#complete_common_string()
inoremap <silent><expr> <TAB>
			\ pumvisible() ? '<C-n>' :
			\ (col('.') <= 1 <Bar><Bar> getline('.')[col('.') - 2] =~# '\s') ?
			\ '<TAB>' : ddc#manual_complete()

call ddc#custom#patch_global(
			\ 'sources', has('nvim') ?
			\ ['nvim-lsp', 'treesitter', 'around', 'file'] :
			\ ['vim-lsp', 'around', 'file'],
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
			\   'mark': 'lsp',
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

call ddc#enable()

