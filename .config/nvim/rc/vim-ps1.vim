function! s:addHeaderPs1(flg)
  setl fenc=cp932
  setl ff=dos
  let lines = []
  if a:flg == 1
    call add(lines, "@set __SCRIPTPATH=%~f0&@powershell -NoProfile -ExecutionPolicy ByPass -InputFormat None \"$s=[scriptblock]::create((gc \\\"%~f0\\\"|?{$_.readcount -gt 2})-join\\\"`n\\\");&$s\" %*")
  elseif a:flg == 2
    call add(lines, "@set __SCRIPTPATH=%~f0&@powershell -NoProfile -ExecutionPolicy ByPass -InputFormat None \"$s=[scriptblock]::create((gc \\\"%~f0\\\"|?{$_.readcount -gt 2})-join\\\"`n\\\");&$s\" %*&@pause")
  else
    call add(lines, "@set __SCRIPTPATH=%~f0&@powershell -NoProfile -ExecutionPolicy ByPass -InputFormat None \"$s=[scriptblock]::create((gc \\\"%~f0\\\"|?{$_.readcount -gt 2})-join\\\"`n\\\");&$s\" %*&@ping -n 30 localhost>nul")
  endif
  call add(lines, "@exit /b %errorlevel%")
  call extend(lines, readfile(expand("%")))
  let i = 0
  for line in lines
    if len(lines) != (i + 1)
      let lines[i] .= "\r"
    endif
    let i += 1
  endfor
  " let s:basedir = expand("%:p:h") . "/../cmd/"
  let s:basedir = expand("%:p:h") . "/"
  let s:cmdFile = expand("%:p:t:r") . ".cmd"
  call Mkdir(s:basedir)
  call writefile(lines,  s:basedir . s:cmdFile, "b")
  echo "Write " . s:basedir . expand("%:p:t:r") . ".cmd"
endfunction
" au MyAutoCmd BufWritePost *.ps1 call <SID>addHeaderPs1(0)
au MyAutoCmd FileType ps1 nnoremap <buffer> <expr><Leader>b <SID>addHeaderPs1(0)
au MyAutoCmd FileType ps1 nnoremap <buffer> <expr><Leader>m <SID>addHeaderPs1(1)
au MyAutoCmd FileType ps1 nnoremap <buffer> <expr><Leader>p <SID>addHeaderPs1(2)
au MyAutoCmd BufNew,BufRead *.ps1 setl fdm=syntax

