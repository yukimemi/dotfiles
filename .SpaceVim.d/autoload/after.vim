" =============================================================================
" File        : after.vim
" Author      : yukimemi
" Last Change : 2019/03/29 09:05:39.
" =============================================================================

" Functions: {{{1
function! s:open_current_dir() abort "{{{2
  if g:is_windows
    setl noshellslash
    silent! exe printf("!start \"%s\"", expand("%:h"))
    setl shellslash
  else
    silent! exe printf("!open \"%s\"", expand("%:h"))
  endif
endfunction


" Basic: {{{1
" Clipboard. {{{2
set clipboard=unnamed,unnamedplus

" encode. {{{2
set fileencodings=ucs-bom,utf-8,utf-16le,cp932,iso-8859-15

" Mappings: {{{1
nnoremap <silent> <Leader><Leader> :<C-u>update<CR>

" For window.
nnoremap <silent> sj <C-w>j
nnoremap <silent> sk <C-w>k
nnoremap <silent> sl <C-w>l
nnoremap <silent> sh <C-w>h
nnoremap <silent> sJ <C-w>J
nnoremap <silent> sK <C-w>K
nnoremap <silent> sL <C-w>L
nnoremap <silent> sH <C-w>H
nnoremap <silent> sr <C-w>r
nnoremap <silent> s= <C-w>=
nnoremap <silent> sw <C-w>w
nnoremap <silent> so <C-w>_<C-w>|
nnoremap <silent> s0 :<C-u>only<CR>
nnoremap <silent> sO :<C-u>tabonly<CR>
nnoremap <silent> sn :<C-u>bn<CR>
nnoremap <silent> sp :<C-u>bp<CR>
nnoremap <silent> st :<C-u>tabnew<CR>
nnoremap <silent> ss :<C-u>sp<CR>
nnoremap <silent> sv :<C-u>vs<CR>
nnoremap <silent> sq :<C-u>q<CR>
nnoremap <silent> sQ :<C-u>qa<CR>
nnoremap <silent> sbk :<C-u>bd!<CR>
nnoremap <silent> sbq :<C-u>q!<CR>

" For tab.
nnoremap <silent><C-l> gt
nnoremap <silent><C-h> gT

" nohlsearch.
nnoremap <silent> <ESC><ESC> :<C-u>nohlsearch<CR>

" Open folding in "l"
nnoremap <expr> l foldlevel(line('.')) ? "\<Right>zo" : "\<Right>"

noremap <silent> gh ^
noremap <silent> gl $

nnoremap <silent> <Leader>o :<C-u>call <SID>open_current_dir()<CR>
inoremap <silent> <ESC> <ESC>:set iminsert=0<CR>

" Autocmd: {{{1
" https://lambdalisue.hatenablog.com/entry/2017/12/24/165759
au MyAutoCmd BufWritePost *
      \ if &filetype ==# '' && exists('b:ftdetect') |
      \   unlet! b:ftdetect |
      \   filetype detect |
      \ endif

" For swap.
" http://itchyny.hatenablog.com/entry/2014/12/25/090000
au MyAutoCmd SwapExists * let v:swapchoice = 'o'

" Escape cmd win.
au MyAutoCmd CmdwinEnter * nnoremap <silent><buffer><nowait> <ESC> :q<CR>

" Escape E211.
au MyAutoCmd FileChangedShell * execute

" Plugins: {{{1
source $SPACE_VIM/rc/ale.vim
source $SPACE_VIM/rc/clever-f.vim
source $SPACE_VIM/rc/ctrlp.vim
source $SPACE_VIM/rc/vim-airline.vim

" vim: fdm=marker expandtab fdc=3 ft=vim ts=2 sw=2 sts=2:
