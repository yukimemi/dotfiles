if !IsInstalled("nvim-visual-eof.lua")
  finish
endif

au MyAutoCmd VimEnter * lua require'visual-eof'.setup()
