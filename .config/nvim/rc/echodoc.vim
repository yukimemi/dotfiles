silent! packadd echodoc.vim

call echodoc#enable()
let g:echodoc#type = has('nvim') ? 'floating' : 'popup'
let g:echodoc#events = ['PumCompleteDone', 'TextChangedP', 'PumCompleteChanged']
