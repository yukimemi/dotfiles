let g:echodoc_enable_at_startup = 1

if has('nvim')
  let g:echodoc#type = 'floating'
  " highlight link EchoDocFloat Pmenu
else
  let g:echodoc#type = 'popup'
  " highlight link EchoDocPopup Pmenu
endif

