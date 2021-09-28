" =============================================================================
" File        : init.vim / .vimrc
" Author      : yukimemi
" Last Change : 2021/09/28 10:57:15.
" =============================================================================

" Init:
set encoding=utf-8
scriptencoding utf-8

filetype off
filetype plugin indent off

" Release autogroup in MyAutoCmd.
augroup MyAutoCmd | autocmd! | augroup END

" Echo startup time on start.
if !v:vim_did_enter && has('reltime')
  let s:startuptime = reltime()
  au MyAutoCmd VimEnter * ++once let s:startuptime = reltime(s:startuptime) | redraw
        \ | echomsg 'startuptime: ' .. reltimestr(s:startuptime)
endif

" Judge os type.
let g:is_windows = has('win16') || has('win32') || has('win64')
let g:is_cygwin = has('win32unix')
let g:is_darwin = has('mac') || has('macunix') || has('gui_macvim')
let g:is_linux = !g:is_windows && !g:is_cygwin && !g:is_darwin

" Encodings.
if has('guess_encode')
  set fileencodings=ucs-bom,utf-8,iso-2022-jp,guess,euc-jp,cp932,latin1
else
  set fileencodings=ucs-bom,utf-8,iso-2022-jp,euc-jp,cp932,latin1
endif
if g:is_windows
  set fileformats=dos,unix
else
  set fileformats=unix,dos
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

" Utility:
" Set path.
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

" finish on VsCode Neovim.
if exists('g:vscode')
  source $HOME/.config/nvim/vscode-neovim.vim
  finish
endif

" Functions:
function! s:auto_mkdir(dir, force)
  " Hack #202: http://vim-users.jp/2011/02/hack202/
  if !isdirectory(a:dir) && (a:force ||
        \ input(printf('"%s" does not exist. Create? [y/N]', a:dir)) =~? '^y\%[es]$')
    call mkdir(iconv(a:dir, &encoding, &termencoding), 'p')
  endif
endfunction

function! s:open_current_dir() abort
  if g:is_windows
    let s:save_shellslash = &shellslash
    set noshellslash
    if !has('nvim')
      exe printf("silent! !start \"%s\"", expand("%:p:h"))
    else
      exe printf("silent! !explorer \"%s\"", expand("%:p:h"))
    endif
    let &shellslash = s:save_shellslash
    unlet s:save_shellslash
  else
    exe printf("silent! !open \"%s\"", expand("%:p:h"))
  endif
endfunction

" Basic:
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

" Clipboard.
if g:is_windows || g:is_darwin
  set clipboard=unnamed
else
  set clipboard=unnamed,unnamedplus
endif

set number
set relativenumber
set signcolumn=yes
if has('gui')
  set ambiwidth=double
endif
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
set concealcursor=nc
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
if g:is_windows && has('nvim')
  let g:python3_host_prog = expand('$USERPROFILE') . '/scoop/apps/python/current/python.exe'
endif

" terminal
if !has('nvim')
  set termwinkey=<c-i>
endif

" Filetype:
" xml
let g:xml_syntax_folding = 1
au MyAutoCmd BufNewFile,BufRead *.xml call <SID>filetype_xml()
function! s:filetype_xml() abort
  setl noexpandtab
  setl ts=4 sw=4 sts=0
  setl foldmethod=syntax
endfunction

" Markdown fenced
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

" lua syntax.
let g:vimsyn_embed = 'lPr'

" vim
au MyAutoCmd FileType vim setl expandtab ts=2 sw=2 sts=0
" markdown
au MyAutoCmd FileType markdown setl expandtab ts=2 sw=2 sts=0

" log
au MyAutoCmd FileType log setl nowrap

" mail
au MyAutoCmd FileType mail setl fenc=cp932 ff=dos expandtab

" Commands:
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

" Mapping:
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
inoremap <silent> <c-l> <C-g>U<Right>

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

" Shortcut enc and ff.
" https://github.com/thinca/config/blob/master/dotfiles/dot.vim/vimrc#L1300-L1308
cnoreabbrev ++u ++enc=utf8
cnoreabbrev ++c ++enc=cp932
cnoreabbrev ++s ++enc=cp932
cnoreabbrev ++e ++enc=euc-jp
cnoreabbrev ++j ++enc=iso-2022-jp
cnoreabbrev ++x ++ff=unix
cnoreabbrev ++d ++ff=dos
cnoreabbrev ++m ++ff=mac

" Vim-users.jp - Hack #74: http://vim-users.jp/2009/09/hack74/
nnoremap <silent> <leader>ev  :<c-u>tabedit $MYVIMRC<cr>
nnoremap <silent> <leader>eg  :<c-u>tabedit $MYGVIMRC<cr>
" Load .gvimrc after .vimrc edited at GVim.
nnoremap <silent> <leader>rv :<C-u>source $MYVIMRC \| if has('gui_running') \| source $MYGVIMRC \| endif<cr>
nnoremap <silent> <leader>rg :<C-u>source $MYGVIMRC<cr>

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

"  for git mergetool
if &diff
  nnoremap <localleader>1 :diffget LOCAL<cr>
  nnoremap <localleader>2 :diffget BASE<cr>
  nnoremap <localleader>3 :diffget REMOTE<cr>
  nnoremap <localleader>u :<c-u>diffupdate<cr>
endif

" hilight over 100 column
" http://blog.remora.cx/2013/06/source-in-80-columns-2.html
noremap <Plug>(ToggleColorColumn)
      \ :<c-u>let &colorcolumn = len(&colorcolumn) > 0 ? '' :
      \   join(range(101, 9999), ',')<cr>

nmap <silent> cc <Plug>(ToggleColorColumn)

inoremap <silent> <ESC> <ESC>:set iminsert=0<cr>


" Autocmd:
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

" Update filetype.
autocmd MyAutoCmd BufWritePost * nested
\ if &l:filetype ==# '' || exists('b:ftdetect')
\ |   unlet! b:ftdetect
\ |   filetype detect
\ | endif

au MyAutoCmd FileType * setlocal formatoptions-=r formatoptions-=o concealcursor=nc

" nosmartcase on cmdline.
" [vim-jp » vim-jp.slack.com log - #question - 2021年03月](https://vim-jp.org/slacklog/CJMV3MSLR/2021/03/#ts-1614946023.402700)
set wildcharm=<tab>
cnoremap <expr> <tab> '<cmd>set nosmartcase<cr><tab><cmd>let &smartcase = ' .. &smartcase .. '<cr>'

" Plugin:
let s:use_dein = v:true
let s:use_vimplug = v:false
let s:use_minpac = v:false
let s:use_packager = v:false
let s:use_volt = v:false
let s:use_pack = v:false
let s:use_packer = v:false

let g:plugin_use_lightline = v:false
let g:plugin_use_airline = v:false
let g:plugin_use_neoline = v:false
let g:plugin_use_lualine = v:false
let g:plugin_use_barow = v:true
let g:plugin_use_staline = v:false

let g:plugin_use_coc = v:false
let g:plugin_use_asyncomplete = v:false
let g:plugin_use_deoplete = v:false
let g:plugin_use_ddc = v:true
let g:plugin_use_vimlsp = v:false

let g:plugin_use_ale = v:false

let g:plugin_use_ctrlp = v:true
let g:plugin_use_clap = v:false
let g:plugin_use_fzf = v:false
let g:plugin_use_cocfzf = v:false
let g:plugin_use_fz = v:false
let g:plugin_use_denite = v:true
let g:plugin_use_quickpick = v:false
let g:plugin_use_telescope = v:false && has('nvim')

" let g:plugin_use_fern = !has('nvim')
" let g:plugin_use_defx = has('nvim')
let g:plugin_use_fern = v:true
let g:plugin_use_defx = v:false
let g:plugin_use_molder = v:false
let g:plugin_use_vaffle = v:false
let g:plugin_use_viler = v:false
let g:plugin_use_coc_explorer = v:false

let g:plugin_use_quickrun = v:true
let g:plugin_use_asyncrun = v:false

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
  elseif s:use_packer
    runtime! packer.vim
  else
    echom "No use plugin manager !"
  endif
endif

" Color:
silent! syntax enable

" set cursorline cursorcolumn
" au MyAutoCmd ColorScheme * hi LineNr guifg=#777777
au MyAutoCmd ColorScheme * hi CursorLineNr guibg=#5507FF guifg=#AAAAAA

" Highlight VCS conflict markers
match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'

set background=dark
silent! colorscheme nvcode

" Neovide:
let g:neovide_transparency = 0.9
" let g:neovide_fullscreen  = v:true
let g:neovide_cursor_vfx_mode = "railgun"
" set guifont=Cica
" set guifontwide=Cica

" Nvy:
let g:nvy = get(g:, 'nvy', 0)
if g:nvy
  set gfn=Cica:h10
  set gfw=Cica:h10
endif

" lua:
let g:vimsyn_embed = 'l'
if has('nvim')
  exe "lua require('init')"
endif

filetype plugin indent on

