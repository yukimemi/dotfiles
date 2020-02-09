if !IsInstalled('autoload/fzf_preview.vim') || exists('g:loaded_fzf_preview_cfg')
  finish
endif
let g:loaded_fzf_preview_cfg = 1

nnoremap <silent> scf :<C-u>FzfPreviewProjectFiles<CR>
nnoremap <silent> scb :<C-u>FzfPreviewBuffers<CR>
nnoremap <silent> scd :<C-u>FzfPreviewDirectoryFiles<CR>
nnoremap <silent> scu :<C-u>FzfPreviewMruFiles<CR>
nnoremap <silent> scm :<C-u>FzfPreviewBookmarks<CR>

