if !IsInstalled("transparency.vim")
  finish
endif

let g:transparency_config = {
      \ 'active'  : 90,
      \ 'inactive': 70
      \ }

let g:transparency_ctermbg_none = 1
