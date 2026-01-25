" highlighting mark
noremap <expr> <c-m> operator#sequence#map("\<Plug>(operator-swap-marking)", "\<Plug>(operator-highlighter)")
noremap <expr> <c-s> operator#sequence#map("\<Plug>(operator-swap)", "\<Plug>(operator-highlighter-clear)")
