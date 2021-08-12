inoremap <silent><expr> <c-f> ddc#complete_common_string()
inoremap <silent><expr> <tab>
			\ pumvisible() ? "\<c-n>" :
			\ <SID>check_back_space() ? "\<tab>" :
			\ ""
function! s:check_back_space() abort
	let col = col('.') - 1
	return !col || getline('.')[col - 1]  =~# '\s'
endfunction

if has('nvim')
	call ddc#custom#patch_global({
				\ 'sources': ['around', 'nextword', 'nvimlsp'],
				\ 'autoCompleteDelay': 200,
				\ 'smartCase': v:true,
				\ })
	call ddc#custom#patch_global('sourceOptions', {
				\ '_': {
					\   'matchers': ['matcher_head'],
					\   'sorters': ['sorter_rank'],
					\ },
					\ 'around': {'mark': 'A'},
					\ 'necovim': {'mark': 'vim'},
					\ 'nextword': {'mark': 'nextword', 'minAutoCompleteLength': 3},
					\ 'nvimlsp': {'mark': 'lsp', 'forceCompletionPattern': '\.|:|->'},
					\ })
else
	call ddc#custom#patch_global({
				\ 'sources': ['around', 'nextword', 'ddc-vim-lsp'],
				\ 'autoCompleteDelay': 200,
				\ 'smartCase': v:true,
				\ })
	call ddc#custom#patch_global('sourceOptions', {
				\ '_': {
					\   'matchers': ['matcher_head'],
					\   'sorters': ['sorter_rank'],
					\ },
					\ 'around': {'mark': 'A'},
					\ 'necovim': {'mark': 'vim'},
					\ 'nextword': {'mark': 'nextword', 'minAutoCompleteLength': 3},
					\ 'ddc-vim-lsp': {'mark': 'lsp', 'forceCompletionPattern': '\.|:|->'},
					\ })
endif
call ddc#custom#patch_filetype(
			\ ['vim', 'toml'], 'sources', ['necovim', 'around']
			\ )
call ddc#enable()

