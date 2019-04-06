" =============================================================================
" File        : after.vim
" Author      : yukimemi
" Last Change : 2019/04/07 07:48:29.
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

" Clipboard. {{{2
set clipboard=unnamed,unnamedplus

" encode. {{{2
set fileencodings=ucs-bom,utf-8,cp932,utf-16le,iso-8859-15

" Hilight cursorline, cursorcolumn {{{2
" http://d.hatena.ne.jp/thinca/20090530/1243615055
au MyAutoCmd CursorMoved,CursorMovedI * call s:auto_cursorline('CursorMoved')
au MyAutoCmd CursorHold,CursorHoldI * call s:auto_cursorline('CursorHold')
au MyAutoCmd WinEnter,BufEnter,CmdwinLeave * call s:auto_cursorline('WinEnter,BufEnter,CmdwinLeave')
au MyAutoCmd WinLeave * call s:auto_cursorline('WinLeave')

let s:cursorline_lock = 0
function! s:auto_cursorline(event)
  if a:event ==# 'WinEnter,BufEnter,CmdwinLeave'
    setlocal cursorline
    setlocal cursorcolumn
    let s:cursorline_lock = 2
  elseif a:event ==# 'WinLeave'
    setlocal nocursorline
    setlocal nocursorcolumn
  elseif a:event ==# 'CursorMoved'
    if s:cursorline_lock
      if 1 < s:cursorline_lock
        let s:cursorline_lock = 1
      else
        setlocal nocursorline
        setlocal nocursorcolumn
        let s:cursorline_lock = 0
      endif
    endif
  elseif a:event ==# 'CursorHold'
    if &updatetime >= 4000
      setlocal cursorline
      setlocal cursorcolumn
    endif
    let s:cursorline_lock = 1
  endif
endfunction

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
source $SPACE_VIM/rc/coc.vim
source $SPACE_VIM/rc/clever-f.vim
source $SPACE_VIM/rc/ctrlp.vim
source $SPACE_VIM/rc/vim-ps1.vim

" FileType: {{{1
" xml {{{2
let g:xml_syntax_folding = 1
au MyAutoCmd BufNewFile,BufRead *.xml call <SID>filetype_xml()
function! s:filetype_xml() abort
  setl noexpandtab
  setl ts=4 sw=4 sts=0
  setl foldmethod=syntax
endfunction

" vim: fdm=marker expandtab fdc=3 ft=vim ts=2 sw=2 sts=2:
