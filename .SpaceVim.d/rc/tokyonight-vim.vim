if !IsInstalled("tokyonight-vim.vim")
  finish
endif

let g:tokyonight_style = 'storm'
let g:tokyonight_enable_italic = 1
let g:tokyonight_disable_italic_comment = 0
let g:tokyonight_transparent_background  1

au MyAutoCmd VimEnter * hi Comment ctermfg=DarkGray guifg=DarkGray


