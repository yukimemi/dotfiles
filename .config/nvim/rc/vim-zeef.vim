let g:zeef_height = 30
let g:zeef_prompt = '» '

nnoremap szb :<c-u>call zeef#buffer({'unlisted': 0})<cr>
nnoremap szf :<c-u>call zeef#files()<cr>
nnoremap szu :<c-u>call zeef#args(v:oldfiles)<cr>
nnoremap szc :<c-u>call zeef#colorscheme()<cr>
