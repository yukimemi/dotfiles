if !IsInstalled("vim-macrobatics")
  finish
endif

" Use <nowait> to override the default bindings which wait for another key press
nmap <nowait> q <plug>(Mac_Play)
nmap <nowait> gq <plug>(Mac_RecordNew)

nmap <leader>md :<c-u>DisplayMacroHistory<cr>

nmap [m <plug>(Mac_RotateBack)
nmap ]m <plug>(Mac_RotateForward)

nmap <leader>ma <plug>(Mac_Append)
nmap <leader>mp <plug>(Mac_Prepend)

" me = macro execute named
nmap <leader>me <plug>(Mac_SearchForNamedMacroAndPlay)

nmap <leader>ms <plug>(Mac_SearchForNamedMacroAndSelect)

nmap <leader>mng <plug>(Mac_NameCurrentMacro)
nmap <leader>mnf <plug>(Mac_NameCurrentMacroForFileType)

let g:Mac_DefaultRegister = 'm'
let g:Mac_MaxItems = 50
let g:Mac_SavePersistently = 1
" let g:Mac_DisplayMacroMaxWidth = 80
" let g:Mac_NamedMacroFileExtension = '.bin'
let g:Mac_NamedMacroFuzzySearcher = 'clap'
let g:Mac_NamedMacrosDirectory = "~/.cache/macrobatics"
" let g:Mac_NamedMacroParameters = {}
" let g:Mac_NamedMacroParametersByFileType = {}
