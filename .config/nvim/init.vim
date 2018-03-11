" =============================================================================
" File        : init.vim / .vimrc
" Author      : yukimemi
" Last Change : 2018/03/11 18:12:17.
" =============================================================================

" Init: {{{1
set encoding=utf-8
scriptencoding utf-8

if &compatible | set nocompatible | endif

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

" True color.
set termguicolors
if !has('nvim')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif

" Set mapleader.
let g:mapleader = ','
let g:maplocalleader = ','

" Utility: {{{1
" Judge os type. {{{2
let g:is_windows = has('win16') || has('win32') || has('win64')
let g:is_cygwin = has('win32unix')
let g:is_darwin = has('mac') || has('macunix') || has('gui_macvim')
let g:is_linux = !g:is_windows && !g:is_cygwin && !g:is_darwin

" Set path. {{{2
set shellslash
let $CACHE = expand('~/.cache')
if has('nvim')
  let $CACHE_HOME = expand('$CACHE/nvim')
  let $VIM_PATH = expand('~/.config/nvim')
  let $MYVIMRC = expand('~/.config/nvim/init.vim')
  let $BACKUP_PATH = expand('$CACHE/nvim/back')
else
  let $CACHE_HOME = expand('$CACHE/vim')
  let $VIM_PATH = expand('~/.vim')
  let $MYVIMRC = expand('~/.vimrc')
  let $MYGVIMRC = expand('~/.gvimrc')
  let $BACKUP_PATH = expand('$CACHE/vim/back')
endif

" Add runtimepath for windows.
if g:is_windows
  execute 'set runtimepath+=' . $VIM_PATH
  execute 'set runtimepath+=' . $VIM_PATH . '/after'
endif

" Functions: {{{1
function! Mkdir(dir) "{{{2
  if !isdirectory(a:dir)
    call mkdir(a:dir, "p")
  endif
endfunction

function! s:str2byte(str) "{{{2
  return map(range(len(a:str)), 'char2nr(a:str[v:val])')
endfunction

function! s:byte2hex(bytes) "{{{2
  return join(map(copy(a:bytes), 'printf("%02X", v:val)'), '')
endfunction

function! s:auto_mkdir(dir, force) "{{{2
  " Hack #202: http://vim-users.jp/2011/02/hack202/
  if !isdirectory(a:dir) && (a:force ||
        \ input(printf('"%s" does not exist. Create? [y/N]', a:dir)) =~? '^y\%[es]$')
    call mkdir(iconv(a:dir, &encoding, &termencoding), 'p')
  endif
endfunction

function! s:format() "{{{2
  " auto indent format
  let save_view = winsaveview()
  normal gg=G
  call winrestview(save_view)
endfunction

function! s:addQuote() "{{{2
  normal gg2dd
  20,$s/^/> /
  normal gg
endfunction

function! s:cd_buffer_dir() "{{{2
  let filetype = getbufvar(bufnr('%'), '&filetype')
  if filetype ==# 'vimfiler'
    let dir = getbufvar(bufnr('%'), 'vimfiler').current_dir
  elseif filetype ==# 'vimshell'
    let dir = getbufvar(bufnr('%'), 'vimshell').save_dir
  else
    let dir = isdirectory(bufname('%')) ? bufname('%') : fnamemodify(bufname('%'), ':p:h')
  endif

  cd `=dir`
endfunction

function! s:removeFileIf0Byte() "{{{2
  " Remove file if 0 byte.
  " http://qiita.com/hykw/items/6dbb43bdcd8874a0daf7
  let filename = expand('%:p')
  if getfsize(filename) > 0
    " do nothing
    return
  endif

  let msg = printf("\n%s is empty, remove?(y/N)", filename)
  if input(msg) == 'y'
    call delete(filename)
    bdelete
  endif
endfunction

function! s:deleteOtherLine() "{{{2
" Delete other line
  %g!//d
endfunction

function! s:updateColorScheme() "{{{2
  if &readonly && &buftype ==# ""
    colorscheme github
  endif
endfunction

function! s:open_current_dir() abort
  if g:is_windows
    setl noshellslash
    exe printf("!start \"%s\"", expand("%:h"))
    setl shellslash
  else
    exe printf("!open \"%s\"", expand("%:h"))
  endif
endfunction

function! MakeVimproc(info) abort "{{{2
  if a:info.status == 'updated' && g:is_windows && !has('kaoriya')
    let g:vimproc#download_windows_dll = 1
  endif
  if !g:is_windows
    !make
  endif
endfunction


" Plugin: {{{1
let s:use_dein = 1
let s:use_vimplug = 0
let s:use_minpac = 0

if s:use_dein
  runtime! dein.vim
elseif s:use_vimplug
  runtime! vimplug.vim
elseif s:use_minpac
  runtime! minpac.vim
else
  echom "No use plugin manager !"
endif

" Basic: {{{1

" ctags.
set tags& tags-=tags tags+=./tags;

" undo, swap.
let s:undo_dir = $BACKUP_PATH . '/undo'
let s:backup_dir = $BACKUP_PATH . '/back'
let s:directory = $BACKUP_PATH . '/dir'
let s:view_dir = $BACKUP_PATH . '/view'
call Mkdir(s:undo_dir)
call Mkdir(s:backup_dir)
call Mkdir(s:directory)
call Mkdir(s:view_dir)

set undofile
exe 'set undodir=' . s:undo_dir
exe 'set backupdir=' . s:backup_dir
exe 'set directory=' . s:directory
exe 'set viewdir=' . s:view_dir

" Encodings.
set fileencodings=utf-8,cp932,utf-16le,utf-16
set fileformat=unix
set fileformats=unix,dos,mac

" Clipboard.
set clipboard+=unnamed

" Indent.
set autoindent
set smartindent
set breakindent

set pastetoggle=
set switchbuf=useopen
set nrformats& nrformats-=octal
set timeoutlen=3500
set hidden
set history=10000
set formatoptions& formatoptions+=mM
set textwidth=0
set virtualedit=block
set whichwrap=b,s,[,],<,>
set backspace=indent,eol,start
set ambiwidth=double
set wildmenu
set wildmode=longest:full,full
set scrolloff=3
set mouse=a
set keywordprg=:help
set autoread

" Search.
set ignorecase
set smartcase
set infercase
set wrapscan
set incsearch
set hlsearch
set grepprg=jvgrep

set noerrorbells
set novisualbell
set visualbell t_vb=
set number
set showmatch matchtime=1
set noshowmode
if has('nvim')
  set inccommand=split
endif

" Tab.
set tabstop=2
set shiftwidth=2
set softtabstop=0
set expandtab

set list
if g:is_windows
  set listchars=tab:\|\ ,trail:-,extends:>,precedes:<
else
  set listchars=tab:\¦\ ,trail:-,extends:»,precedes:«,nbsp:%
endif
set smarttab
set iminsert=0
set imsearch=-1
set cinoptions& cinoptions+=:0
set title
set cmdheight=2
set laststatus=2
set synmaxcol=500
set showcmd
set display=lastline
set foldmethod=marker
" set foldclose=all
" set t_Co=256

" Color: {{{1
syntax enable
set background=dark
colorscheme imas

if has('gui_running')
  if g:is_windows
    nnoremap [Space]r :<C-u>simalt ~r<CR>
    nnoremap [Space]x :<C-u>simalt ~x<CR>
  elseif g:is_mac
    set macmeta
    set transparency=10
  endif
elseif !has('nvim')
  let &t_ti .= "\e[1 q"
  let &t_SI .= "\e[5 q"
  let &t_EI .= "\e[1 q"
  let &t_te .= "\e[0 q"
  let &t_SR .= "\e[3 q"
endif

" Highlight VCS conflict markers {{{2
match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'

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

" Markdown fenced {{{2
let g:markdown_fenced_languages = [
      \ 'css',
      \ 'erb=eruby',
      \ 'javascript',
      \ 'js=javascript',
      \ 'json=javascript',
      \ 'ruby',
      \ 'sass',
      \ 'xml',
      \ 'vim',
      \ ]


" Command: {{{1
" Diff original.
com! DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis | wincmd p | diffthis

" Save as root.
com! Wsu w !sudo tee > /dev/null %

" FileType: {{{1
au MyAutoCmd BufNewFile,BufRead *.eml setl ft=mail
au MyAutoCmd BufNewFile,BufRead *.toml setl ft=toml
au MyAutoCmd BufNewFile,BufRead *.log setl ft=log
au MyAutoCmd FileType csv setl nowrap


" Mapping: {{{1
" Use verymagic.
" nnoremap / /\v
" inoremap %s/ %s/\v

" Use space.
map <Space> [Space]
noremap [Space] <Nop>

inoremap <silent> jj <ESC>
nnoremap j gj
nnoremap k gk
xnoremap j gj
xnoremap k gk
nnoremap <Down> gj
nnoremap <Up>   gk
nnoremap h <Left>
nnoremap l <Right>
" Open folding in "l"
nnoremap <expr> l foldlevel(line('.')) ? "\<Right>zo" : "\<Right>"

noremap gh ^
noremap gl $

" For buffer.
nnoremap <Tab> :<C-u>bn<CR>
nnoremap <S-Tab> :<C-u>bp<CR>

" For tab.
nnoremap <silent><C-l> gt
nnoremap <silent><C-h> gT

" Benri scroll.
" http://itchyny.hatenablog.com/entry/2016/02/02/210000
noremap <expr> <C-b> max([winheight(0) - 2, 1]) . "\<C-u>" . (line('.') < 1         + winheight(0) ? 'H' : 'L')
noremap <expr> <C-f> max([winheight(0) - 2, 1]) . "\<C-d>" . (line('.') > line('$') - winheight(0) ? 'L' : 'H')
noremap <expr> <C-y> (line('w0') <= 1         ? 'k' : "\<C-y>")
noremap <expr> <C-e> (line('w$') >= line('$') ? 'j' : "\<C-e>")

" Useful save mappings.
nnoremap <silent> <Leader><Leader> :<C-u>update<CR>
" Paste continuously.
vnoremap <C-p> "0p<CR>

" Change current directory.
nnoremap [Space]cd :<C-u>call <SID>cd_buffer_dir()<CR>

" Auto mkdir.
au MyAutoCmd BufWritePre * call <SID>auto_mkdir(expand('<afile>:p:h'), v:cmdbang)

" Like emacs.
cnoremap <C-b> <Left>
cnoremap <C-f> <Right>
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
cnoremap <C-d> <Del>
cnoremap <C-y> <C-r>
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>

" Vim-users.jp - Hack #74: http://vim-users.jp/2009/09/hack74/
nnoremap <silent> [Space]ev  :<C-u>tabedit $MYVIMRC<CR>
nnoremap <silent> [Space]eg  :<C-u>tabedit $MYGVIMRC<CR>

" Cmdwin.
nnoremap : q:i
vnoremap : q:A

" Delete other line.
nnoremap [Space]d :<C-u>call <SID>deleteOtherLine()<CR>

" Update plugin.
nnoremap [Space]pu :<C-u>PlugUpdate \| PlugUpgrade<CR>
nnoremap [Space]du :<C-u>call dein#update() \| Dein log<CR>
nnoremap [Space]mu :<C-u>PackUpdate<CR>

" nohlsearch.
nnoremap <silent> <ESC><ESC> :<C-u>nohlsearch<CR>

" Use prefix s.
nnoremap s <Nop>
nnoremap sj <C-w>j
nnoremap sk <C-w>k
nnoremap sl <C-w>l
nnoremap sh <C-w>h
nnoremap sJ <C-w>J
nnoremap sK <C-w>K
nnoremap sL <C-w>L
nnoremap sH <C-w>H
nnoremap sr <C-w>r
nnoremap s= <C-w>=
nnoremap sw <C-w>w
nnoremap so <C-w>_<C-w>|
nnoremap s0 :<C-u>only<CR>
nnoremap sO :<C-u>tabonly<CR>
nnoremap sn :<C-u>bn<CR>
nnoremap sp :<C-u>bp<CR>
nnoremap st :<C-u>tabnew<CR>
nnoremap ss :<C-u>sp<CR>
nnoremap sv :<C-u>vs<CR>
nnoremap sq :<C-u>q<CR>
nnoremap sQ :<C-u>qa<CR>
nnoremap sbk :<C-u>bd!<CR>
nnoremap sbq :<C-u>q!<CR>

nnoremap <Leader>o :<C-u>call <SID>open_current_dir()<CR>

"  for git mergetool {{{2
if &diff
  nnoremap <Leader>1 :diffget LOCAL<CR>
  nnoremap <Leader>2 :diffget BASE<CR>
  nnoremap <Leader>3 :diffget REMOTE<CR>
  nnoremap <Leader>u :<C-u>diffupdate<CR>
endif

" hilight over 100 column {{{2
" http://blog.remora.cx/2013/06/source-in-80-columns-2.html
noremap <Plug>(ToggleColorColumn)
      \ :<c-u>let &colorcolumn = len(&colorcolumn) > 0 ? '' :
      \   join(range(101, 9999), ',')<CR>

nmap <silent> cc <Plug>(ToggleColorColumn)

" http://postd.cc/how-to-boost-your-vim-productivity/
vnoremap <silent> s //e<C-r>=&selection=='exclusive'?'+1':''<CR><CR>
      \:<C-u>call histdel('search',-1)<Bar>let @/=histget('search',-1)<CR>gv
omap s :normal vs<CR>

inoremap <silent> <ESC> <ESC>:set iminsert=0<CR>

" Format.
nnoremap [Space]f :<C-u>call <SID>format()<CR>

" Autocmd: {{{1
au MyAutoCmd WinEnter,WinLeave,BufEnter * checktime
" au MyAutoCmd CursorHold * setl nohlsearch
au MyAutoCmd CmdwinEnter * :silent! 1,$-50 delete _ | call cursor("$", 1)

" Reload .vimrc automatically.
au MyAutoCmd BufWritePost $MYVIMRC silent! nested source $MYVIMRC | redraw
au MyAutoCmd BufWritePost $MYGVIMRC silent! nested source $MYGVIMRC | redraw

" Auto open cwindow.
au MyAutoCmd QuickfixCmdPost make,grep,vimgrep if len(getqflist()) != 0 | copen | endif

" Auto change dir.
" au MyAutoCmd BufEnter * execute ":silent! lcd " . escape(expand("%:p:h"), ' ')

" For binary.
au MyAutoCmd BufReadPre  *.bin,*.dat let &bin=1
au MyAutoCmd BufReadPost *.bin,*.dat if &bin | %!xxd
au MyAutoCmd BufReadPost *.bin,*.dat set ft=xxd | endif
au MyAutoCmd BufWritePre *.bin,*.dat if &bin | %!xxd -r
au MyAutoCmd BufWritePre *.bin,*.dat endif
au MyAutoCmd BufWritePost *.bin,*.dat if &bin | %!xxd
au MyAutoCmd BufWritePost *.bin,*.dat set nomod | endif

au MyAutoCmd FileType mail nnoremap <silent><buffer> [Space]q :<C-u>silent! call <SID>addQuote()<CR>

"au MyAutoCmd BufWrite * call <SID>format()

au MyAutoCmd BufWritePost * call <SID>removeFileIf0Byte()

" Restore last cursor position when open a file.
au MyAutoCmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif

" Save and load fold settings.
" http://vim-jp.org/vim-users-jp/2009/10/08/Hack-84.html
" au MyAutoCmd BufWritePost * if expand('%') != '' && &buftype !~ 'nofile' | mkview! | endif
" au MyAutoCmd BufRead * if expand('%') != '' && &buftype !~ 'nofile' | silent! loadview | endif
set viewoptions=cursor,folds

" For swap.
" http://itchyny.hatenablog.com/entry/2014/12/25/090000
au MyAutoCmd SwapExists * let v:swapchoice = 'o'

" Escape cmd win.
au MyAutoCmd CmdwinEnter * nnoremap <silent><buffer><nowait> <ESC> :q<CR>

" For git commit.
au MyAutoCmd VimEnter COMMIT_EDITMSG setl spell

" Change colorscheme for readonly.
" au MyAutoCmd BufReadPost,BufEnter * call s:updateColorScheme()

" Load settings for each location. {{{2
" http://vim-jp.org/vim-users-jp/2009/12/27/Hack-112.html
au MyAutoCmd BufNewFile,BufReadPost * call <SID>vimrc_local(expand('<afile>:p:h'))

function! s:vimrc_local(loc)
  let files = findfile('.vimrc.local', escape(a:loc, ' ') . ';', -1)
  for i in reverse(filter(files, 'filereadable(v:val)'))
    source `=i`
  endfor
endfunction

filetype plugin indent on

" vim:fdm=marker expandtab fdc=3 ft=vim ts=2 sw=2 sts=2:
