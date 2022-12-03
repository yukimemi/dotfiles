if !has('nvim')
  finish
endif

function! IsInstalled(name) abort
  return !empty(globpath(&pp, "pack/packer/*/" . a:name))
endfunction

command! PackerInstall packadd packer.nvim | lua require('plugins').install()
command! PackerUpdate packadd packer.nvim | lua require('plugins').update()
command! PackerSync packadd packer.nvim | lua require('plugins').sync()
command! PackerClean packadd packer.nvim | lua require('plugins').clean()
command! PackerCompile packadd packer.nvim | echom 'PackerCompile !' | lua require('plugins').compile()

exe "lua require('bootstrap')"
