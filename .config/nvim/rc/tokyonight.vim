if !IsInstalled("tokyonight.vim")
  finish
endif

let g:tokyonight_style = 'storm'
let g:tokyonight_enable_italic = 1
let g:tokyonight_disable_italic_comment = 0

au MyAutoCmd VimEnter * hi Comment ctermfg=DarkGray guifg=DarkGray


