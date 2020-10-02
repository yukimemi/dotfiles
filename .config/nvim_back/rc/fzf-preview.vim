if !IsInstalled('autoload/fzf_preview.vim') || exists('g:loaded_fzf_preview_cfg')
  finish
endif
let g:loaded_fzf_preview_cfg = 1

nnoremap <silent> scf :<c-u>FzfPreviewProjectFiles<cr>
nnoremap <silent> scb :<c-u>FzfPreviewBuffers<cr>
nnoremap <silent> scd :<c-u>FzfPreviewDirectoryFiles<cr>
nnoremap <silent> scu :<c-u>FzfPreviewMruFiles<cr>
nnoremap <silent> scm :<c-u>FzfPreviewBookmarks<cr>

