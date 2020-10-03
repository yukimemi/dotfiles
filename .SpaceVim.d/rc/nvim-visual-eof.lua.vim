if !IsInstalled("nvim-visual-eof.lua")
  finish
endif

au MyAutoCmd CursorHold * ++once lua require'visual-eof'.setup()

