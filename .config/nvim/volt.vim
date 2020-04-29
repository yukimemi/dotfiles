function! IsInstalled(name) abort
  return !empty(globpath($VOLTPATH, "repos/*/*/" . a:name))
endfunction
