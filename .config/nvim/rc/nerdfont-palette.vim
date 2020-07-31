" For nerdfont.vim
let g:nerdfont_palette#source = 'nerdfont'

" For vim-devicons
" let g:nerdfont_palette#source = 'devicons'

augroup my-nerdfont-palette
  au!
  au FileType fern call nerdfont_palette#apply()
  au FileType nerdtree call nerdfont_palette#apply()
  au FileType startify call nerdfont_palette#apply()
augroup END
