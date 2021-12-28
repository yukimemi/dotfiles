let g:bufpreview_open_browser_fn = expand('<SID>') . 'open_web_app'

function! s:open_web_app(url) abort
  if has('win32')
    execute '!start /B cmd.exe /C start chrome --app=' . shellescape(a:url, 1)
  elseif has('mac')
    execute '!open -na "Google Chrome" --args --app=' . shellescape(a:url, 1)
  endif
endfunction
