nmap <space>/ <Plug>(hopping-start)

" Keymapping
let g:hopping#keymapping = {
      \	"\<c-n>" : "<Over>(hopping-next)",
      \	"\<c-p>" : "<Over>(hopping-prev)",
      \	"\<c-u>" : "<Over>(scroll-u)",
      \	"\<c-d>" : "<Over>(scroll-d)",
      \ }

au MyAutoCmd FileType qf,quickfix HoppingStart
