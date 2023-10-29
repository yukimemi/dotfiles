let g:zeef_height = 30
let g:zeef_prompt = '» '

fun! s:zeef_files(...)
  let l:dir = (a:0 > 0 ? a:1 : '.')
  call zeef#open(systemlist(executable('rg') ? 'rg --files --hidden --no-ignore-vcs ' .. l:dir : 'find ' .. l:dir .. ' -type f'), 'zeef#set_arglist', 'Choose files')
endf

nnoremap szb :<c-u>call zeef#buffer({'unlisted': 0})<cr>
nnoremap szu :<c-u>call zeef#args(v:oldfiles)<cr>
nnoremap szc :<c-u>call zeef#colorscheme()<cr>
nnoremap szf :<c-u>call <SID>zeef_files()<cr>
nnoremap szd :<c-u>call <SID>zeef_files(expand('$HOME/.dotfiles'))<cr>
nnoremap szr :<c-u>call <SID>zeef_files(expand('$HOME/src'))<cr>
