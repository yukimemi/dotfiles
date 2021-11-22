if !has('nvim')
  finish
endif

function! IsInstalled(name) abort
  return !empty(globpath(&pp, "pack/packer/*/" . a:name))
endfunction

" set shellslash
exe "lua require('plugins')"
" set shellslash
au MyAutoCmd BufWritePost plugins.lua silent! PackerCompile

