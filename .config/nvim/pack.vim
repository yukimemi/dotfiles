set runtimepath^=$VIM_CONFIG_PATH
set packpath^=$VIM_CONFIG_PATH

function! IsInstalled(name) abort
  return !empty(globpath(&pp, "pack/default/*/*/" . a:name))
endfunction

