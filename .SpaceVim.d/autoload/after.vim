" =============================================================================
" File        : after.vim
" Author      : yukimemi
" Last Change : 2019/05/30 19:01:25.
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
" Options. {{{2
set cmdheight=2
set virtualedit+=block

" Clipboard. {{{2
set clipboard=unnamed,unnamedplus

" encode. {{{2
set fileencodings=ucs-bom,utf-8,cp932,utf-16le,iso-8859-15

" grep. {{{2
if executable("jvgrep")
  set grepprg=jvgrep
endif

" Mappings: {{{1
nnoremap <silent> ,, :<c-u>update<cr>

" For window.
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

" For tab.
nnoremap <silent><c-l> gt
nnoremap <silent><c-h> gT

" nohlsearch.
nnoremap <silent> <esc><esc> :<c-u>nohlsearch<cr>

" Open folding in "l"
nnoremap <expr> l foldlevel(line('.')) ? "\<Right>zo" : "\<Right>"

noremap <silent> gh ^
noremap <silent> gl $

nnoremap <silent> ,o :<c-u>call <SID>open_current_dir()<cr>
inoremap <silent> <esc> <esc>:set iminsert=0<cr>

cnoremap <c-p> <Up>
cnoremap <c-n> <Down>

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
au MyAutoCmd CmdwinEnter * nnoremap <silent><buffer><nowait> <esc> :q<cr>

" Escape E211.
au MyAutoCmd FileChangedShell * execute

" Auto open quickfix.
au MyAutoCmd QuickfixCmdPost make,grep,grepadd,vimgrep copen

" For all filetype.
au MyAutoCmd FileType * setlocal fo-=t fo-=c fo-=r fo-=o

" Plugins: {{{1
" source $SPACE_VIM/rc/ale.vim
" source $SPACE_VIM/rc/clever-f.vim
" source $SPACE_VIM/rc/vim-ps1.vim
source $SPACE_VIM/rc/coc.vim

" FileType: {{{1
" xml {{{2
let g:xml_syntax_folding = 1
au MyAutoCmd BufNewFile,BufRead *.xml call <SID>filetype_xml()
function! s:filetype_xml() abort
  setl noexpandtab
  setl ts=4 sw=4 sts=0
  setl foldmethod=syntax
endfunction

" markdown {{{2
let g:markdown_fenced_languages = [
      \  'coffee',
      \  'css',
      \  'erb=eruby',
      \  'javascript',
      \  'js=javascript',
      \  'json=javascript',
      \  'ruby',
      \  'sass',
      \  'xml',
      \ ]

" GUI: {{{1
let g:spacevim_guifont = "Cica:h10"

" vim: fdm=marker expandtab fdc=3 ft=vim ts=2 sw=2 sts=2:
