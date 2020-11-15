" =============================================================================
" File        : init.vim / .vimrc
" Author      : yukimemi
" Last Change : 2020/11/15 23:36:18.
" =============================================================================

" Init: {{{1
set encoding=utf-8
scriptencoding utf-8

filetype off
filetype plugin indent off

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
let g:mapleader = "\<space>"
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
  if g:is_windows
    let $VIM_PATH = expand('~/vimfiles')
    let $MYVIMRC = expand('~/_vimrc')
    let $MYGVIMRC = expand('~/_gvimrc')
  else
    let $VIM_PATH = expand('~/.vim')
    let $MYVIMRC = expand('~/.vimrc')
    let $MYGVIMRC = expand('~/.gvimrc')
  endif
  let $BACKUP_PATH = expand('$CACHE/vim/back')
endif

" Functions: {{{1
function! s:auto_mkdir(dir, force) "{{{2
  " Hack #202: http://vim-users.jp/2011/02/hack202/
  if !isdirectory(a:dir) && (a:force ||
        \ input(printf('"%s" does not exist. Create? [y/N]', a:dir)) =~? '^y\%[es]$')
    call mkdir(iconv(a:dir, &encoding, &termencoding), 'p')
  endif
endfunction

function! s:open_current_dir() abort "{{{2
  if g:is_windows
    if !has('nvim')
      setl noshellslash
      exe printf("!start \"%s\"", expand("%:h"))
      setl shellslash
    else
      exe printf("!explorer \"%s\"", expand("%:h"))
    endif
  else
    exe printf("!open \"%s\"", expand("%:h"))
  endif
endfunction

" Basic: {{{1
" undo, swap.
let s:undo_dir = $BACKUP_PATH . '/undo'
let s:backup_dir = $BACKUP_PATH . '/back'
let s:directory = $BACKUP_PATH . '/dir'
let s:view_dir = $BACKUP_PATH . '/view'
silent! call mkdir(s:undo_dir, 'p')
silent! call mkdir(s:backup_dir, 'p')
silent! call mkdir(s:directory, 'p')
silent! call mkdir(s:view_dir, 'p')

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

set number
set signcolumn=yes
" set ambiwidth=double
set history=10000
set nofixeol
set hidden autoread
set viminfo='10000
set cmdheight=2
set scrolloff=5
set laststatus=2
set backspace=indent,eol,start
set wildmenu wildignorecase wildmode=longest:full,full
set autoindent smartindent breakindent
set incsearch hlsearch wrapscan
set ignorecase smartcase infercase
set showmatch matchtime=1
set belloff=all
set noerrorbells novisualbell t_vb=
set noshowmode
set virtualedit=block
set synmaxcol=500
set smarttab
set shortmess-=S
set iminsert=0 imsearch=-1
set list listchars=tab:\¦\ ,trail:-,extends:»,precedes:«,nbsp:%
if executable('jvgrep')
  set grepprg=jvgrep
endif
if has('nvim')
  set pumblend=10
  set winblend=10
  set inccommand=split
endif

" python
if g:is_windows && !has('nvim')
  let g:python3_host_prog = expand('$USERPROFILE') . '/scoop/apps/python/current/python.exe'
endif

" terminal {{{2
if !has('nvim')
  set termwinkey=<c-i>
endif

" Filetype: {{{1
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
  silent! call mkdir(l:baseDir, 'p')
  call writefile(lines,  l:baseDir . l:cmdFile, "b")
  echo "Write " . l:baseDir . expand("%:p:t:r") . ".cmd"
endfunction
au MyAutoCmd FileType javascript nnoremap <buffer> <expr><localleader>b <SID>addHeaderJScript(0)
au MyAutoCmd FileType javascript nnoremap <buffer> <expr><localleader>m <SID>addHeaderJScript(1)
au MyAutoCmd FileType javascript nnoremap <buffer> <expr><localleader>p <SID>addHeaderJScript(2)

" PowerShell {{{2
function! s:addHeaderPs1(pattern, verb)
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
    let l:line = l:line . "\"$s=[scriptblock]::create((gc -enc utf8 \\\"%~f0\\\"|?{$_.readcount -gt 7})-join\\\"`n\\\");&$s\" %*"
  else
    let l:line = l:line . "\"$s=[scriptblock]::create((gc -enc utf8 \\\"%~f0\\\"|?{$_.readcount -gt 2})-join\\\"`n\\\");&$s\" %*"
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
  silent! call mkdir(l:baseDir, 'p')
  call writefile(l:lines,  l:baseDir . l:cmdFile, "b")
  echo "Write " . l:baseDir . l:cmdFile
endfunction
au MyAutoCmd FileType ps1 nnoremap <buffer> <expr><localleader>b <SID>addHeaderPs1(0, 0)
au MyAutoCmd FileType ps1 nnoremap <buffer> <expr><localleader>m <SID>addHeaderPs1(1, 0)
au MyAutoCmd FileType ps1 nnoremap <buffer> <expr><localleader>p <SID>addHeaderPs1(2, 0)
au MyAutoCmd FileType ps1 nnoremap <buffer> <expr><localleader>ab <SID>addHeaderPs1(0, 1)
au MyAutoCmd FileType ps1 nnoremap <buffer> <expr><localleader>am <SID>addHeaderPs1(1, 1)
au MyAutoCmd FileType ps1 nnoremap <buffer> <expr><localleader>ap <SID>addHeaderPs1(2, 1)
au MyAutoCmd FileType ps1 setl expandtab ts=2 sw=2 sts=0 foldmethod=syntax ff=dos

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
  silent! call mkdir(l:baseDir, 'p')
  call writefile(l:lines,  l:baseDir . l:cmdFile, "b")
  echo "Write " . l:baseDir . l:cmdFile
endfunction
au MyAutoCmd FileType dosbatch nnoremap <buffer> <expr><localleader>a <SID>addHeaderBat(0, 1)

" vim {{{2
au MyAutoCmd FileType vim setl expandtab ts=2 sw=2 sts=0
" markdown {{{2
au MyAutoCmd FileType markdown setl expandtab ts=2 sw=2 sts=0

" log {{{2
au MyAutoCmd FileType log setl nowrap

" mail {{{2
au MyAutoCmd FileType mail setl fenc=cp932 ff=dos

" Commands: {{{1
" VimShowHlGroup: Show highlight group name under a cursor
" https://rcmdnk.com/blog/2013/12/01/computer-vim/
command! VimShowHlGroup echo synIDattr(synIDtrans(synID(line('.'), col('.'), 1)), 'name')
" VimShowHlItem: Show highlight item name under a cursor
command! VimShowHlItem echo synIDattr(synID(line("."), col("."), 1), "name")

" https://qiita.com/1000k/items/6d4953d2dd52fdd86556
command! RemoveAnsi %s/<1b>\[[0-9;]*m//g

" https://daisuzu.hatenablog.com/entry/2018/12/13/012608
command! -bar ToScratch
      \ setlocal buftype=nofile bufhidden=hide noswapfile

command! -nargs=1 -complete=command L
      \ <mods> new | ToScratch |
      \ call setline(1, split(execute(<q-args>), '\n'))

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

" Benri scroll.
" http://itchyny.hatenablog.com/entry/2016/02/02/210000
" noremap <expr> <c-b> max([winheight(0) - 2, 1]) . "\<c-u>" . (line('.') < 1         + winheight(0) ? 'H' : 'L')
" noremap <expr> <c-f> max([winheight(0) - 2, 1]) . "\<c-d>" . (line('.') > line('$') - winheight(0) ? 'L' : 'H')
" noremap <expr> <c-y> (line('w0') <= 1         ? 'k' : "\<c-y>")
" noremap <expr> <c-e> (line('w$') >= line('$') ? 'j' : "\<c-e>")

" Useful save mappings.
nnoremap <silent> <localleader><localleader> :<c-u>update<cr>

" Paste continuously.
vnoremap <c-p> "0p<cr>

" Change current directory.
nnoremap <leader>cd :<c-u>execute ":tcd " . expand("%:p:h")<cr>

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
nnoremap <silent> <leader>ev  :<c-u>tabedit $MYVIMRC<cr>
nnoremap <silent> <leader>eg  :<c-u>tabedit $MYGVIMRC<cr>

" Cmdwin.
" nnoremap <silent> : q:i
" vnoremap <silent> : q:A

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

nnoremap <localleader>o :<c-u>call <SID>open_current_dir()<cr>

" Change background color
nnoremap <leader>bg :let &background = ( &background == "dark"? "light" : "dark" )<cr>

"  for git mergetool {{{2
if &diff
  nnoremap <localleader>1 :diffget LOCAL<cr>
  nnoremap <localleader>2 :diffget BASE<cr>
  nnoremap <localleader>3 :diffget REMOTE<cr>
  nnoremap <localleader>u :<c-u>diffupdate<cr>
endif

" hilight over 100 column {{{2
" http://blog.remora.cx/2013/06/source-in-80-columns-2.html
noremap <Plug>(ToggleColorColumn)
      \ :<c-u>let &colorcolumn = len(&colorcolumn) > 0 ? '' :
      \   join(range(101, 9999), ',')<cr>

nmap <silent> cc <Plug>(ToggleColorColumn)

inoremap <silent> <ESC> <ESC>:set iminsert=0<cr>


" Autocmd: {{{1
" Auto mkdir.
au MyAutoCmd BufWritePre * call <SID>auto_mkdir(expand('<afile>:p:h'), v:cmdbang)

" au MyAutoCmd WinEnter,WinLeave,BufEnter * checktime
" au MyAutoCmd CursorHold * setl nohlsearch
" au MyAutoCmd CmdwinEnter * :silent! 1,$-50 delete _ | call cursor("$", 1)

" Reload .vimrc automatically.
au MyAutoCmd BufWritePost $MYVIMRC silent! nested source $MYVIMRC | redraw
au MyAutoCmd BufWritePost $MYGVIMRC silent! nested source $MYGVIMRC | redraw
au MyAutoCmd BufWritePost *.vim silent! nested source $MYVIMRC | redraw

" Auto open cwindow.
" au MyAutoCmd QuickfixCmdPost make,grep,vimgrep,qf if len(getqflist()) != 0 | copen | endif

" Restore last cursor position when open a file.
au MyAutoCmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif

" For swap.
" http://itchyny.hatenablog.com/entry/2014/12/25/090000
au MyAutoCmd SwapExists * let v:swapchoice = 'o'

" Escape cmd win.
au MyAutoCmd CmdwinEnter * nnoremap <silent><buffer><nowait> <ESC> :q<cr>

" For git commit.
au MyAutoCmd VimEnter COMMIT_EDITMSG setl spell

if has('gui_running')
  if g:is_windows
    nnoremap <leader>r :<c-u>simalt ~r<cr>
    nnoremap <leader>x :<c-u>simalt ~x<cr>
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

set cursorline cursorcolumn
" au MyAutoCmd ColorScheme * hi LineNr guifg=#777777
au MyAutoCmd ColorScheme * hi CursorLineNr guibg=#5507FF guifg=#AAAAAA

" Highlight VCS conflict markers {{{2
match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'

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

" Plugin: {{{1
let s:use_dein = 0
let s:use_vimplug = 0
let s:use_minpac = 1
let s:use_packager = 0
let s:use_volt = 0
let s:use_pack = 0

let g:plugin_use_lightline = 1
let g:plugin_use_airline = 0
let g:plugin_use_neoline = 0

let g:plugin_use_coc = 1
let g:plugin_use_asyncomplete = 0
let g:plugin_use_deoplete = 0

let g:plugin_use_ctrlp = 1
let g:plugin_use_clap = 0
let g:plugin_use_fzf = 0
let g:plugin_use_cocfzf = 0
let g:plugin_use_fz = 0
let g:plugin_use_denite = 1
let g:plugin_use_quickpick = 1

" let g:plugin_use_fern = !has('nvim')
" let g:plugin_use_defx = has('nvim')
let g:plugin_use_fern = 0
let g:plugin_use_defx = 1
let g:plugin_use_molder = 0
let g:plugin_use_vaffle = 0
let g:plugin_use_viler = 0
let g:plugin_use_coc_explorer = 0

let g:no_plugin = get(g:, 'no_plugin', 0)
" let g:no_plugin = 1
if !g:no_plugin
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
endif

" Colorscheme: {{{1
set background=dark
silent! packadd oceanic-next-vim
if has('nvim')
  silent! colorscheme oceanicnext
else
  silent! colorscheme oceanicnext
endif

" Neovide: {{{1
let g:neovide_transparency = 0.9
" let g:neovide_fullscreen  = v:true
let g:neovide_cursor_vfx_mode = "railgun"
" set guifont=Cica
" set guifontwide=Cica

" Nvy: {{{1
let g:nvy = get(g:, 'nvy', 0)
if g:nvy
  set gfn=Cica:h10
  set gfw=Cica:h10
endif

" lua: {{{1
if has('nvim')
  exe "lua require('init')"
endif

filetype plugin indent on

" vim:fdm=marker expandtab fdc=3 ft=vim ts=2 sw=2 sts=2:
