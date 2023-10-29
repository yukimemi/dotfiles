let g:airline_experimental = 1
let g:airline_powerline_fonts = 1
let g:airline_detect_iminsert = 1
let g:airline_highlighting_cache = 1

" extensions
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#bookmark#enabled = 1
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#coc#enabled = 1
let g:airline#extensions#cursormode#enabled = 1
let g:airline#extensions#hunks#enabled = 1
let g:airline#extensions#keymap#enabled = 1
let g:airline#extensions#virtualenv#enabled = 1

" let g:airline#extensions#tabline#switch_buffers_and_tabs = 1
" let g:airline#extensions#whitespace#enabled = 1

let g:airline#extensions#tabline#buffer_idx_mode = 1
Keymap n <leader>1 <Plug>AirlineSelectTab1
Keymap n <leader>2 <Plug>AirlineSelectTab2
Keymap n <leader>3 <Plug>AirlineSelectTab3
Keymap n <leader>4 <Plug>AirlineSelectTab4
Keymap n <leader>5 <Plug>AirlineSelectTab5
Keymap n <leader>6 <Plug>AirlineSelectTab6
Keymap n <leader>7 <Plug>AirlineSelectTab7
Keymap n <leader>8 <Plug>AirlineSelectTab8
Keymap n <leader>9 <Plug>AirlineSelectTab9
Keymap n <leader>0 <Plug>AirlineSelectTab0
Keymap n <leader>- <Plug>AirlineSelectPrevTab
Keymap n <leader>+ <Plug>AirlineSelectNextTab

function! AirlineInit()
  let g:airline_section_b = airline#section#create_left(['hunks', 'branch', '%-0.30{getcwd()}'])
  let g:airline_section_x = airline#section#create_right(['%{dein#get_progress()}', '%{exists("g:colors_name") ? g:colors_name : ""}', 'tagbar', 'filetype'])
endfunction
au MyAutoCmd User AirlineAfterInit call AirlineInit()

