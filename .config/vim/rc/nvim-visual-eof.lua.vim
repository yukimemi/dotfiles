if !has('nvim')
  finish
endif

au MyAutoCmd CursorHold * ++once lua require'visual-eof'.setup()

