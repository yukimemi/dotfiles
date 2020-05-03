let g:translator_target_lang = 'ja'
let g:translator_default_engines = ['google', 'bing']

" Echo translation in the cmdline
nmap <silent> <leader>t <Plug>Translate
vmap <silent> <leader>t <Plug>TranslateV
" Display translation in a window
nmap <silent> <leader>w <Plug>TranslateW
vmap <silent> <leader>w <Plug>TranslateWV
" Replace the text with translation
nmap <silent> <leader>r <Plug>TranslateR
vmap <silent> <leader>r <Plug>TranslateRV
