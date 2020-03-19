" =============================================================================
" File        : init.vim / .vimrc
" Author      : yukimemi
" Last Change : 2020/03/20 01:07:27.
" =============================================================================

" Init: {{{1
set encoding=utf-8
scriptencoding utf-8

if &compatible | set nocompatible | endif

" Release autogroup in MyAutoCmd.
augroup MyAutoCmd | autocmd! | augroup END

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

" Unload default plugins.
let g:no_gvimrc_example         = 1
let g:no_vimrc_example          = 1
let g:loaded_gzip               = 1
let g:loaded_tar                = 1
let g:loaded_tarPlugin          = 1
let g:loaded_zip                = 1
let g:loaded_zipPlugin          = 1
let g:loaded_rrhelper           = 1
let g:loaded_vimball            = 1
let g:loaded_vimballPlugin      = 1
let g:loaded_getscript          = 1
let g:loaded_getscriptPlugin    = 1
let g:loaded_netrw              = 1
let g:loaded_netrwPlugin        = 1
let g:loaded_netrwSettings      = 1
let g:loaded_netrwFileHandlers  = 1
let g:did_install_default_menus = 1
let g:skip_loading_mswin        = 1
let g:did_install_syntax_menu   = 1
let g:loaded_2html_plugin       = 1

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

function! s:open_current_dir() abort "{{{2
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
set fileformats=unix,dos,mac

" Clipboard.
if g:is_windows || g:is_darwin
  set clipboard=unnamed
else
  set clipboard=unnamed,unnamedplus
endif

" Indent.
set autoindent
set smartindent
set breakindent

set ambiwidth=double
set autoread
set backspace=indent,eol,start
set formatoptions& formatoptions+=mM
set hidden
set history=10000
set keywordprg=:help
set mouse=a
set nofixeol
set nrformats& nrformats-=octal
set pastetoggle=
set scrolloff=3
set shortmess=a
set shortmess+=c
" set switchbuf=useopen
set textwidth=0
set timeoutlen=3500
set virtualedit=block
set whichwrap=b,s,[,],<,>
set wildmenu
set wildmode=longest:full,full
" set splitbelow
set splitright
set lazyredraw
if !has('nvim')
  set ttyfast
endif

" Search.
set ignorecase
set smartcase
set infercase
set wrapscan
set incsearch
set hlsearch
if executable('jvgrep')
  set grepprg=jvgrep
endif

set noerrorbells
set novisualbell
set visualbell t_vb=
set number
set showmatch matchtime=1
set noshowmode

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
set pumheight=13
" set foldclose=all
" set t_Co=256

set viminfo='1000

" terminal {{{2

" Command: {{{1
" Diff original.
com! DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis | wincmd p | diffthis

" Save as root.
com! Wsu w !sudo tee > /dev/null %

" FileType: {{{1
au MyAutoCmd BufNewFile,BufRead *.eml setl ft=mail fenc=cp932 ff=dos
au MyAutoCmd BufNewFile,BufRead *.hash setl nowrap
au MyAutoCmd FileType csv,log setl nowrap

" xml {{{2
let g:xml_syntax_folding = 1
au MyAutoCmd BufNewFile,BufRead *.xml call <SID>filetype_xml()
function! s:filetype_xml() abort
  setl noexpandtab
  setl ts=4 sw=4 sts=0
  setl foldmethod=syntax
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

" JScript {{{2
function! s:addHeaderJScript(flg)
  setl fenc=cp932
  setl ff=dos
  let lines = []
  call add(lines, "@set @junk=1 /*")
  call add(lines, "@cscript //nologo //e:jscript \"%~f0\" %*")
  if a:flg == 0
    call add(lines, "@ping -n 30 localhost > nul")
  elseif a:flg == 2
    call add(lines, "@pause")
  endif
  call add(lines, "@exit /b %errorlevel%")
  call add(lines, "*/")
  call extend(lines, readfile(expand("%")))
  let i = 0
  for line in lines
    if len(lines) != (i + 1)
      let lines[i] .= "\r"
    endif
    let i += 1
  endfor
  " let l:baseDir = expand("%:p:h") . "/../cmd/"
  let l:baseDir = expand("%:p:h") . "/"
  let l:cmdFile = expand("%:p:t:r") . ".cmd"
  call Mkdir(l:baseDir)
  call writefile(lines,  l:baseDir . l:cmdFile, "b")
  echo "Write " . l:baseDir . expand("%:p:t:r") . ".cmd"
endfunction
au MyAutoCmd FileType javascript nnoremap <buffer> <expr><Leader>b <SID>addHeaderJScript(0)
au MyAutoCmd FileType javascript nnoremap <buffer> <expr><Leader>m <SID>addHeaderJScript(1)
au MyAutoCmd FileType javascript nnoremap <buffer> <expr><Leader>p <SID>addHeaderJScript(2)

" PowerShell {{{2
function! s:addHeaderPs1(pattern, verb)
  setl fenc=cp932
  setl ff=dos
  let l:lines = []
  if a:verb == 1
    call add(l:lines, "@openfiles > nul 2>&1")
    call add(l:lines, "@if %errorlevel% equ 0 goto :ALREADY_ADMIN_PRIVILEGE")
    call add(l:lines, "@powershell.exe -Command Start-Process \"%~f0\" %* -verb runas")
    call add(l:lines, "@exit /b %errorlevel%")
    call add(l:lines, ":ALREADY_ADMIN_PRIVILEGE")
  endif

  let l:line = "@set __SCRIPTPATH=%~f0&@powershell -NoProfile -ExecutionPolicy ByPass -InputFormat None "
  if a:verb == 1
    let l:line = l:line . "\"$s=[scriptblock]::create((gc \\\"%~f0\\\"|?{$_.readcount -gt 7})-join\\\"`n\\\");&$s\" %*"
  else
    let l:line = l:line . "\"$s=[scriptblock]::create((gc \\\"%~f0\\\"|?{$_.readcount -gt 2})-join\\\"`n\\\");&$s\" %*"
  endif
  if a:pattern == 1
  elseif a:pattern == 2
    let l:line = l:line . "&@pause"
  else
    let l:line = l:line . "&@ping -n 30 localhost>nul"
  endif
  call add(l:lines, l:line)
  call add(l:lines, "@exit /b %errorlevel%")
  call extend(l:lines, readfile(expand("%")))
  let i = 0
  for line in l:lines
    if len(l:lines) != (i + 1)
      let l:lines[i] .= "\r"
    endif
    let i += 1
  endfor
  let l:baseDir = expand("%:p:h") . "/"
  let l:cmdFile = expand("%:p:t:r") . ".cmd"
  call Mkdir(l:baseDir)
  call writefile(l:lines,  l:baseDir . l:cmdFile, "b")
  echo "Write " . l:baseDir . l:cmdFile
endfunction
au MyAutoCmd FileType ps1 nnoremap <buffer> <expr><Leader>b <SID>addHeaderPs1(0, 0)
au MyAutoCmd FileType ps1 nnoremap <buffer> <expr><Leader>m <SID>addHeaderPs1(1, 0)
au MyAutoCmd FileType ps1 nnoremap <buffer> <expr><Leader>p <SID>addHeaderPs1(2, 0)
au MyAutoCmd FileType ps1 nnoremap <buffer> <expr><Leader>ab <SID>addHeaderPs1(0, 1)
au MyAutoCmd FileType ps1 nnoremap <buffer> <expr><Leader>am <SID>addHeaderPs1(1, 1)
au MyAutoCmd FileType ps1 nnoremap <buffer> <expr><Leader>ap <SID>addHeaderPs1(2, 1)
au MyAutoCmd BufNew,BufRead *.ps1 setl fdm=syntax

" dosbatch {{{2
function! s:addHeaderBat(pattern, verb)
  setl fenc=cp932
  setl ff=dos
  let l:lines = []
  if a:verb == 1
    call add(l:lines, "@openfiles > nul 2>&1")
    call add(l:lines, "@if %errorlevel% equ 0 goto :ALREADY_ADMIN_PRIVILEGE")
    call add(l:lines, "@powershell.exe -Command Start-Process \"%~f0\" %* -verb runas")
    call add(l:lines, "@exit /b %errorlevel%")
    call add(l:lines, ":ALREADY_ADMIN_PRIVILEGE")
  endif
  call extend(l:lines, readfile(expand("%")))
  let i = 0
  for line in l:lines
    if len(l:lines) != (i + 1)
      let l:lines[i] .= "\r"
    endif
    let i += 1
  endfor
  let l:baseDir = expand("%:p:h") . "/"
  let l:cmdFile = expand("%:p:t:r") . "_admin." . expand("%:e")
  call Mkdir(l:baseDir)
  call writefile(l:lines,  l:baseDir . l:cmdFile, "b")
  echo "Write " . l:baseDir . l:cmdFile
endfunction
au MyAutoCmd FileType dosbatch nnoremap <buffer> <expr><Leader>a <SID>addHeaderBat(0, 1)


" Mapping: {{{1
" Use verymagic.
" nnoremap / /\v
" inoremap %s/ %s/\v

inoremap <silent> jj <ESC>
nnoremap <silent> j gj
nnoremap <silent> k gk
xnoremap <silent> j gj
xnoremap <silent> k gk
nnoremap <silent> <Down> gj
nnoremap <silent> <Up>   gk
nnoremap <silent> h <Left>
nnoremap <silent> l <Right>
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

" Benri scroll.
" http://itchyny.hatenablog.com/entry/2016/02/02/210000
" noremap <expr> <c-b> max([winheight(0) - 2, 1]) . "\<c-u>" . (line('.') < 1         + winheight(0) ? 'H' : 'L')
" noremap <expr> <c-f> max([winheight(0) - 2, 1]) . "\<c-d>" . (line('.') > line('$') - winheight(0) ? 'L' : 'H')
noremap <expr> <c-y> (line('w0') <= 1         ? 'k' : "\<c-y>")
noremap <expr> <c-e> (line('w$') >= line('$') ? 'j' : "\<c-e>")

" Useful save mappings.
nnoremap <silent> <Leader><Leader> :<c-u>update<cr>

" Paste continuously.
vnoremap <c-p> "0p<cr>

" Change current directory.
nnoremap <space>cd :<c-u>call <SID>cd_buffer_dir()<cr>

" Like emacs.
cnoremap <c-b> <Left>
cnoremap <c-f> <Right>
cnoremap <c-a> <Home>
cnoremap <c-e> <End>
cnoremap <c-d> <Del>
cnoremap <c-y> <c-r>
cnoremap <c-p> <Up>
cnoremap <c-n> <Down>

" Vim-users.jp - Hack #74: http://vim-users.jp/2009/09/hack74/
nnoremap <silent> <space>ev  :<c-u>tabedit $MYVIMRC<cr>
nnoremap <silent> <space>eg  :<c-u>tabedit $MYGVIMRC<cr>

" Cmdwin.
nnoremap <silent> : q:i
vnoremap <silent> : q:A

" Delete other line.
nnoremap <space>d :<c-u>call <SID>deleteOtherLine()<cr>

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

nnoremap <Leader>o :<c-u>call <SID>open_current_dir()<cr>

" terminal
tnoremap <Esc> <c-\><c-n>


"  for git mergetool {{{2
if &diff
  nnoremap <Leader>1 :diffget LOCAL<cr>
  nnoremap <Leader>2 :diffget BASE<cr>
  nnoremap <Leader>3 :diffget REMOTE<cr>
  nnoremap <Leader>u :<c-u>diffupdate<cr>
endif

" hilight over 100 column {{{2
" http://blog.remora.cx/2013/06/source-in-80-columns-2.html
noremap <Plug>(ToggleColorColumn)
      \ :<c-u>let &colorcolumn = len(&colorcolumn) > 0 ? '' :
      \   join(range(101, 9999), ',')<cr>

nmap <silent> cc <Plug>(ToggleColorColumn)

" http://postd.cc/how-to-boost-your-vim-productivity/
vnoremap <silent> s //e<c-r>=&selection=='exclusive'?'+1':''<cr><cr>
      \:<c-u>call histdel('search',-1)<Bar>let @/=histget('search',-1)<cr>gv
omap s :normal vs<cr>

inoremap <silent> <ESC> <ESC>:set iminsert=0<cr>

" Format.
nnoremap <space>f :<c-u>call <SID>format()<cr>

" Autocmd: {{{1
" Auto mkdir.
au MyAutoCmd BufWritePre * call <SID>auto_mkdir(expand('<afile>:p:h'), v:cmdbang)

" au MyAutoCmd WinEnter,WinLeave,BufEnter * checktime
" au MyAutoCmd CursorHold * setl nohlsearch
au MyAutoCmd CmdwinEnter * :silent! 1,$-50 delete _ | call cursor("$", 1)

" Reload .vimrc automatically.
au MyAutoCmd BufWritePost $MYVIMRC silent! nested source $MYVIMRC | redraw
au MyAutoCmd BufWritePost $MYGVIMRC silent! nested source $MYGVIMRC | redraw
au MyAutoCmd BufWritePost *.vim silent! nested source $MYVIMRC | redraw

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

au MyAutoCmd FileType mail nnoremap <silent><buffer> <space>q :<c-u>silent! call <SID>addQuote()<cr>

"au MyAutoCmd BufWrite * call <SID>format()

au MyAutoCmd BufWritePost * call <SID>removeFileIf0Byte()

" Restore last cursor position when open a file.
au MyAutoCmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif

" Save and load fold settings.
" http://vim-jp.org/vim-users-jp/2009/10/08/Hack-84.html
" au MyAutoCmd BufWritePost * if expand('%') != '' && &buftype !~ 'nofile' | mkview! | endif
" au MyAutoCmd BufRead * if expand('%') != '' && &buftype !~ 'nofile' | silent! loadview | endif
" set viewoptions=cursor,folds

" For swap.
" http://itchyny.hatenablog.com/entry/2014/12/25/090000
au MyAutoCmd SwapExists * let v:swapchoice = 'o'

" Escape cmd win.
au MyAutoCmd CmdwinEnter * nnoremap <silent><buffer><nowait> <ESC> :q<cr>

" For git commit.
au MyAutoCmd VimEnter COMMIT_EDITMSG setl spell

" Change colorscheme for readonly.
" au MyAutoCmd BufReadPost,BufEnter * call s:updateColorScheme()

" base16-shell.
if filereadable(expand("~/.vimrc_background"))
  " let base16colorspace=256
  " source ~/.vimrc_background
endif

if has('gui_running')
  if g:is_windows
    nnoremap <space>r :<c-u>simalt ~r<cr>
    nnoremap <space>x :<c-u>simalt ~x<cr>
  elseif g:is_darwin
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

" Color: {{{1
silent! syntax enable

" au MyAutoCmd ColorScheme * hi LineNr guifg=#777777
" au MyAutoCmd ColorScheme * hi CursorLineNr guibg=#5507FF guifg=#AAAAAA

" Highlight VCS conflict markers {{{2
" match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'

" Hilight cursorline, cursorcolumn {{{2
" https://github.com/mopp/dotfiles/blob/14fc5fba2429a1d70aac2b904e46c5c2930063ae/.vimrc#L468-L472
" let s:cur_f = 0
" au MyAutoCmd WinEnter,BufEnter,CmdwinLeave * setlocal cursorline cursorcolumn | let s:cur_f = 1
" au MyAutoCmd WinLeave * setlocal nocursorline nocursorcolumn | let s:cur_f = 0
" au MyAutoCmd CursorHold,CursorHoldI * setlocal cursorline cursorcolumn | let s:cur_f = 1
" au MyAutoCmd CursorMoved,CursorMovedI * if s:cur_f | setlocal nocursorline nocursorcolumn | let s:cur_f = 0 | endif

" reload filetype on save. {{{2
" https://lambdalisue.hatenablog.com/entry/2017/12/24/165759
au MyAutoCmd BufWritePost *
      \ if &filetype ==# '' && exists('b:ftdetect') |
      \   unlet! b:ftdetect |
      \   filetype detect |
      \ endif

" Load settings for each location. {{{2
" http://vim-jp.org/vim-users-jp/2009/12/27/Hack-112.html
" au MyAutoCmd BufNewFile,BufReadPost * call <SID>vimrc_local(expand('<afile>:p:h'))
"
" function! s:vimrc_local(loc)
"   let files = findfile('.vimrc.local', escape(a:loc, ' ') . ';', -1)
"   for i in reverse(filter(files, 'filereadable(v:val)'))
"     source `=i`
"   endfor
" endfunction

" if windows no plugins for git.
if $HOME != $USERPROFILE && $GIT_EXEC_PATH != ''
  finish
end

" Plugin: {{{1
let s:use_dein = 0
let s:use_vimplug = 0
let s:use_minpac = 1
let s:use_packager = 0
let s:use_volt = 0
let s:use_pack = 0

function! IsInstalled(name) abort
  if s:use_dein
    return !dein#check_install(a:name)
  elseif s:use_minpac
    return !empty(globpath(&pp, "pack/minpac/*/" . a:name))
  endif
endfunction

if s:use_dein
  runtime! dein.vim
elseif s:use_vimplug
  runtime! vimplug.vim
elseif s:use_minpac
  runtime! minpac.vim
elseif s:use_packager
  runtime! packager.vim
elseif s:use_volt
  runtime! volt.vim
elseif s:use_pack
  runtime! pack.vim
else
  echom "No use plugin manager !"
endif

" Colorscheme: {{{1
set background=dark
" silent! colorscheme PaperColor
silent! colorscheme gruvbox-material

" vim:fdm=marker expandtab fdc=3 ft=vim ts=2 sw=2 sts=2:
