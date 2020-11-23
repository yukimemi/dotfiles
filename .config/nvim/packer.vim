if !has('nvim')
  finish
endif

function! IsInstalled(name) abort
  return !empty(globpath(&pp, "pack/packer/*/" . a:name))
endfunction

exe "lua require('plugins')"
au MyAutoCmd BufWritePost plugins.lua PackerCompile

