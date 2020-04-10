let g:translator_target_lang = 'ja'
let g:translator_default_engines = ['google', 'bing']

" Echo translation in the cmdline
nmap <silent> <Leader>t <Plug>Translate
vmap <silent> <Leader>t <Plug>TranslateV
" Display translation in a window
nmap <silent> <Leader>w <Plug>TranslateW
vmap <silent> <Leader>w <Plug>TranslateWV
" Replace the text with translation
nmap <silent> <Leader>r <Plug>TranslateR
vmap <silent> <Leader>r <Plug>TranslateRV
