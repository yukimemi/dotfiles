" au MyAutoCmd VimEnter * call singleton#enable()
silent! packadd vim-singleton

if dein#is_sourced('singleton')
  call singleton#enable()
endif

