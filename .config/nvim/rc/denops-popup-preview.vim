if !g:plugin_use_ddc
  finish
endif

let g:popup_preview_config = {
      \ 'delay': 50,
      \ 'border': v:true,
      \ 'supportVsnip': v:false,
      \ }

call popup_preview#enable()

" au MyAutoCmd FileType ps1,vim call popup_preview#disable()

