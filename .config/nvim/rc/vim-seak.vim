highlight link SeakChar Visual
let g:seak_enabled = v:true
au MyAutoCmd CmdlineEnter /,\? cmap <buffer> / <Cmd>call seak#select({ 'nohlsearch': v:true })<CR>
au MyAutoCmd CmdlineLeave /,\? cunmap <buffer> /

