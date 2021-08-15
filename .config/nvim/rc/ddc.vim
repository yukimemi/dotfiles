inoremap <silent><expr> <C-f> ddc#complete_common_string()
inoremap <silent><expr> <TAB>
			\ pumvisible() ? "\<C-n>" :
			\ (col('.') <= 1 <Bar><Bar> getline('.')[col('.') - 2] =~# '\s') ?
			\ "\<TAB>" : ddc#manual_complete()

if has('nvim')
  call ddc#custom#patch_global('sourceOptions', {
        \ '_': {
        \   'matchers': ['matcher_head'],
        \   'sorters': ['sorter_rank'],
        \   'converters': ['converter_remove_overlap'],
        \ },
        \ })
else
  call ddc#custom#patch_global('sourceOptions', {
        \ '_': {
        \   'matchers': ['matcher_head'],
        \   'sorters': ['sorter_rank'],
        \ },
        \ })
endif

call ddc#custom#patch_global('sourceOptions', {
			\ 'around': {'mark': 'A'},
			\ 'necovim': {'mark': 'vim'},
			\ 'deoppet': {'mark': 'dp'},
			\ 'nextword': {
			\   'mark': 'nextword',
			\   'isVolatile': v:true,
			\ },
			\ })

if has('nvim') && !g:plugin_use_vimlsp
	call ddc#custom#patch_global({
				\ 'sources': ['around', 'nextword', 'nvimlsp'],
				\ })
	call ddc#custom#patch_global('sourceOptions', {
				\ 'nvimlsp': {'mark': 'lsp', 'forceCompletionPattern': '\\.|:|->'},
				\ })
else
	call ddc#custom#patch_global({
				\ 'sources': ['around', 'nextword', 'ddc-vim-lsp'],
				\ })
	call ddc#custom#patch_global('sourceOptions', {
				\ 'ddc-vim-lsp': {'mark': 'lsp', 'forceCompletionPattern': '\\.|:|->'},
				\ })
endif

call ddc#enable()

