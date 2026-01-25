let g:translator_target_lang = 'ja'
let g:translator_default_engines = ['google', 'bing']

" Echo translation in the cmdline
nmap <silent> <localleader>t <Plug>Translate
vmap <silent> <localleader>t <Plug>TranslateV
" Display translation in a window
nmap <silent> <localleader>w <Plug>TranslateW
vmap <silent> <localleader>w <Plug>TranslateWV
" Replace the text with translation
nmap <silent> <localleader>r <Plug>TranslateR
vmap <silent> <localleader>r <Plug>TranslateRV
