" =============================================================================
" File        : myspacevim.vim
" Author      : yukimemi
" Last Change : 2019/05/30 19:01:25.
" =============================================================================

function! myspacevim#before() abort
  " Init:
  " Release autogroup in MyAutoCmd.
  augroup MyAutoCmd
    autocmd!
  augroup END

  " Echo startup time on start.
  if has('vim_starting') && has('reltime')
    let s:startuptime = reltime()
    au MyAutoCmd VimEnter * let s:startuptime = reltime(s:startuptime) | redraw
          \ | echomsg 'startuptime: ' . reltimestr(s:startuptime)
  endif

  let g:mapleader = ','

  " PATH.
  let $SPACE_VIM = expand("~/.SpaceVim.d")

  " Utility:
  " Judge os type.
  let g:is_windows = has("win16") || has("win32") || has("win64")
  let g:is_cygwin = has("win32unix")
  let g:is_darwin = has("mac") || has("macunix") || has("gui_macvim")
  let g:is_linux = !g:is_windows && !g:is_cygwin && !g:is_darwin

  " Functions:
  function! Mkdir(dir) "{{{2
    if !isdirectory(a:dir)
      call mkdir(a:dir, "p")
    endif
  endfunction

endfunction

function! myspacevim#after() abort
  " Functions:
  function! s:open_current_dir() abort "{{{2
    if g:is_windows
      setl noshellslash
      silent! exe printf("!start \"%s\"", expand("%:h"))
      setl shellslash
    else
      silent! exe printf("!open \"%s\"", expand("%:h"))
    endif
  endfunction


  " Basic:
  " Options.
  set cmdheight=2
  set virtualedit+=block

  " Clipboard.
  set clipboard=unnamed,unnamedplus

  " encode.
  set fileencodings=ucs-bom,utf-8,cp932,utf-16le,iso-8859-15

  " grep.
  if executable("jvgrep")
    set grepprg=jvgrep
  endif

  " Mappings:
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

  " Autocmd:
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

  " Hilight cursorline, cursorcolumn {{{2
  " https://github.com/mopp/dotfiles/blob/14fc5fba2429a1d70aac2b904e46c5c2930063ae/.vimrc#L468-L472
  let s:cur_f = 0
  au MyAutoCmd WinEnter,BufEnter,CmdwinLeave * setlocal cursorline cursorcolumn | let s:cur_f = 1
  au MyAutoCmd WinLeave * setlocal nocursorline nocursorcolumn | let s:cur_f = 0
  au MyAutoCmd CursorHold,CursorHoldI * setlocal cursorline cursorcolumn | let s:cur_f = 1
  au MyAutoCmd CursorMoved,CursorMovedI * if s:cur_f | setlocal nocursorline nocursorcolumn | let s:cur_f = 0 | endif

  " Plugins:
  " source $SPACE_VIM/rc/ale.vim
  " source $SPACE_VIM/rc/clever-f.vim
  source $SPACE_VIM/rc/vim-operator-replace.vim

  if g:is_windows
    " source $SPACE_VIM/rc/asyncomplete.vim
  else
    " source $SPACE_VIM/rc/coc.vim
  endif

  " FileType:
  " xml
  let g:xml_syntax_folding = 1
  au MyAutoCmd BufNewFile,BufRead *.xml call <SID>filetype_xml()
  function! s:filetype_xml() abort
    setl noexpandtab
    setl ts=4 sw=4 sts=0
    setl foldmethod=syntax
  endfunction

  " markdow
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

  " GUI:
  let g:spacevim_guifont = "Cica:h10"

endfunction

