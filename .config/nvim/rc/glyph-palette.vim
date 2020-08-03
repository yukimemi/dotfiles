if !IsInstalled("glyph-palette.vim")
  finish
endif

augroup my-glyph-palette
  au!
  au FileType fern call glyph_palette#apply()
  au FileType nerdtree,startify call glyph_palette#apply()
augroup END
