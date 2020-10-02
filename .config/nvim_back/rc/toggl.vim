if !IsInstalled("toggl.vim")
  finish
endif

nnoremap <leader>Tt :TogglStop<cr>
vnoremap <leader>Tt :TogglSelectStart<cr>
nnoremap <leader>Tl :TogglTask<cr>
