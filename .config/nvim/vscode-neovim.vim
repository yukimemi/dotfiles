" Release autogroup in MyAutoCmd.
augroup MyAutoCmd | autocmd! | augroup END

" Echo startup time on start.
if has('vim_starting') && has('reltime')
  let s:startuptime = reltime()
  au MyAutoCmd VimEnter * let s:startuptime = reltime(s:startuptime) | redraw
        \ | echomsg 'startuptime: ' . reltimestr(s:startuptime)
endif

" Set mapleader.
let g:mapleader = "\<space>"
let g:maplocalleader = ','

" Judge os type.
let g:is_windows = has('win16') || has('win32') || has('win64')
let g:is_cygwin = has('win32unix')
let g:is_darwin = has('mac') || has('macunix') || has('gui_macvim')
let g:is_linux = !g:is_windows && !g:is_cygwin && !g:is_darwin

" mappings.
inoremap <silent> jj <ESC>
nnoremap <silent> j gj
nnoremap <silent> k gk
xnoremap <silent> j gj
xnoremap <silent> k gk
nnoremap <silent> <Down> gj
nnoremap <silent> <Up>   gk
nnoremap <silent> h <Left>
nnoremap <silent> l <Right>
inoremap <silent> <C-l> <C-g>U<Right>
" Open folding in "l"
nnoremap <expr> l foldlevel(line('.')) ? "\<Right>zo" : "\<Right>"

noremap <silent> gh ^
noremap <silent> gl $
nnoremap <silent> Y y$

" For buffer.
nnoremap <Tab> :<c-u>bn<cr>
nnoremap <S-Tab> :<c-u>bp<cr>

" For tab.
nnoremap <silent><c-l> gt
nnoremap <silent><c-h> gT

" Useful save mappings.
nnoremap <silent> <localleader><localleader> :<c-u>update<cr>

" nohlsearch.
nnoremap <silent> <ESC><ESC> :<c-u>nohlsearch<cr>

" Use prefix s.
nnoremap <silent> s <Nop>
nnoremap <silent> sj <c-w>j
nnoremap <silent> sk <c-w>k
nnoremap <silent> sl <c-w>l
nnoremap <silent> sh <c-w>h
nnoremap <silent> sJ <c-w>J
nnoremap <silent> sK <c-w>K
nnoremap <silent> sL <c-w>L
nnoremap <silent> sH <c-w>H
nnoremap <silent> sr <c-w>r
nnoremap <silent> s= <c-w>=
nnoremap <silent> sw <c-w>w
nnoremap <silent> so <c-w>_<c-w>|
nnoremap <silent> s0 :<c-u>only<cr>
nnoremap <silent> sO :<c-u>tabonly<cr>
nnoremap <silent> sn :<c-u>bn<cr>
nnoremap <silent> sp :<c-u>bp<cr>
nnoremap <silent> st :<c-u>tabnew<cr>
nnoremap <silent> ss :<c-u>sp<cr>
nnoremap <silent> sv :<c-u>vs<cr>
nnoremap <silent> sq :<c-u>q<cr>
nnoremap <silent> sQ :<c-u>qa<cr>
nnoremap <silent> sbk :<c-u>bd!<cr>
nnoremap <silent> sbq :<c-u>q!<cr>
