silent! packadd echodoc.vim

let g:echodoc#type = has('nvim') ? 'floating' : 'popup'
call echodoc#enable()
