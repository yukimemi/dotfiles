" =============================================================================
" File        : init.vim / .vimrc
" Author      : yukimemi
" Last Change : 2022/10/16 19:39:26.
" =============================================================================

" Init:
set encoding=utf-8
scriptencoding utf-8

filetype off
filetype plugin indent off

language message C

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
set fileencodings=ucs-bom,utf-8,iso-2022-jp,euc-jp,cp932,latin1
set fileformats=unix,dos

" True color.
set termguicolors
if !has('nvim')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif

" Set mapleader.
let g:mapleader = "\<space>"
let g:maplocalleader = '\'

" Utility:
" Set path.
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
    if !has('nvim')
      exe printf("silent! !start \"%s\"", expand("%:p:h"))
    else
      exe printf("silent! !explorer \"%s\"", expand("%:p:h"))
    endif
  else
    exe printf("silent! !open \"%s\"", expand("%:p:h"))
  endif
endfunction

function! s:keymap(force_map, modes, ...) abort
  let arg = join(a:000, ' ')
  let cmd = (a:force_map || arg =~? '<Plug>') ? 'map' : 'noremap'
  for mode in split(a:modes, '.\zs')
    if index(split('nvsxoilct', '.\zs'), mode) < 0
      echoerr 'Invalid mode is detected: ' . mode
      continue
    endif
    execute mode . cmd arg
  endfor
endfunction

command! -nargs=+ -bang Keymap call <SID>keymap(<bang>0, <f-args>)


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
set signcolumn=number
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
set wildoptions=pum,tagfile
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
set shortmess+=c
set iminsert=0 imsearch=-1
set pumheight=20
set list listchars=tab:\¦\ ,trail:-,extends:»,precedes:«,nbsp:%
set completeopt-=noinsert
if executable('jvgrep')
  set grepprg=jvgrep
endif
if has('nvim')
  set pumblend=10
  set winblend=10
  set inccommand=split
  set laststatus=3
endif

" python
if g:is_windows
  let g:python3_host_prog = expand('$USERPROFILE') . '/AppData/Local/Programs/Python/Python310/python.exe'
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

" quickfix.
au MyAutoCmd FileType qf,quickfix setl cursorline

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

Keymap i  <silent> jj    <esc>
Keymap nx <silent> j     gj
Keymap nx <silent> k     gk
Keymap nx <silent> gj    j
Keymap nx <silent> gk    k
Keymap n  <silent> h     <Left>
Keymap n  <silent> l     <Right>
Keymap i  <silent> <c-l> <C-g>U<Right>

" Open folding in "l"
Keymap n <expr> l foldlevel(line('.')) ? "\<Right>zo" : "\<Right>"

Keymap nx <silent> gh ^
Keymap nx <silent> gl $
Keymap n  <silent> Y  y$

" For buffer.
" nnoremap <Tab> <cmd>bn<cr>
" nnoremap <S-Tab> <cmd>bp<cr>
Keymap nx <tab> %

" Useful save mappings.
Keymap n <silent> <leader><leader> <cmd>update<cr>

" Paste continuously.
Keymap x <c-p> "0p<cr>

" Change current directory.
" nnoremap <leader>cd <cmd>execute ":tcd " . expand("%:p:h")<cr>

" Like emacs.
Keymap c <c-b> <Left>
Keymap c <c-f> <Right>
Keymap c <c-a> <Home>
Keymap c <c-e> <End>
Keymap c <c-d> <Del>
Keymap c <c-y> <c-r>
Keymap c <c-p> <Up>
Keymap c <c-n> <Down>

" Vim-users.jp - Hack #74: http://vim-users.jp/2009/09/hack74/
Keymap n <silent> <leader>ev  <cmd>tabedit $MYVIMRC<cr>
Keymap n <silent> <leader>eg  <cmd>tabedit $MYGVIMRC<cr>
" Load .gvimrc after .vimrc edited at GVim.
Keymap n <silent> <leader>rv <cmd>source $MYVIMRC \| if has('gui_running') \| source $MYGVIMRC \| endif<cr>
Keymap n <silent> <leader>rg <cmd>source $MYGVIMRC<cr>

" nohlsearch.
Keymap n <silent> <esc><esc> <cmd>nohlsearch<cr>

" tab
" Keymap n <silent> <c-h> gT
" Keymap n <silent> <c-l> gt

" Use prefix s.
" Keymap n <silent> sh <c-w>h
" Keymap n <silent> sj <c-w>j
" Keymap n <silent> sk <c-w>k
" Keymap n <silent> sl <c-w>l
Keymap n <silent> <c-h> <c-w>h
Keymap n <silent> <c-j> <c-w>j
Keymap n <silent> <c-k> <c-w>k
Keymap n <silent> <c-l> <c-w>l
Keymap n <silent> s <Nop>
Keymap n <silent> s0 <cmd>only<cr>
Keymap n <silent> s= <c-w>=
Keymap n <silent> sH <c-w>H
Keymap n <silent> sJ <c-w>J
Keymap n <silent> sK <c-w>K
Keymap n <silent> sL <c-w>L
Keymap n <silent> sO <cmd>tabonly<cr>
Keymap n <silent> sQ <cmd>qa<cr>
Keymap n <silent> sbk <cmd>bd!<cr>
Keymap n <silent> sbq <cmd>q!<cr>
Keymap n <silent> sn <cmd>bn<cr>
Keymap n <silent> so <c-w>_<c-w>|
Keymap n <silent> sp <cmd>bp<cr>
Keymap n <silent> sq <cmd>q<cr>
Keymap n <silent> sr <c-w>r
Keymap n <silent> ss <cmd>sp<cr>
Keymap n <silent> st <cmd>tabnew<cr>
Keymap n <silent> sv <cmd>vs<cr>
Keymap n <silent> sw <c-w>w

Keymap n <leader>o <cmd>call <SID>open_current_dir()<cr>

" Change background color
Keymap n <leader>bg :let &background = ( &background == "dark"? "light" : "dark" )<cr>

"  for git mergetool
if &diff
  Keymap n <localleader>1 :diffget LOCAL<cr>
  Keymap n <localleader>2 :diffget BASE<cr>
  Keymap n <localleader>3 :diffget REMOTE<cr>
  Keymap n <localleader>u <cmd>diffupdate<cr>
endif

" hilight over 100 column
" http://blog.remora.cx/2013/06/source-in-80-columns-2.html
noremap <Plug>(ToggleColorColumn)
      \ <cmd>let &colorcolumn = len(&colorcolumn) > 0 ? '' :
      \   join(range(101, 9999), ',')<cr>

Keymap n <silent> cc <Plug>(ToggleColorColumn)

Keymap i <silent> <esc> <esc>:set iminsert=0<cr>


" Autocmd:
" Auto mkdir.
au MyAutoCmd BufWritePre * call <SID>auto_mkdir(expand('<afile>:p:h'), v:cmdbang)

" Reload .vimrc automatically.
au MyAutoCmd BufWritePost $MYVIMRC silent! nested source $MYVIMRC | redraw
au MyAutoCmd BufWritePost $MYGVIMRC silent! nested source $MYGVIMRC | redraw
au MyAutoCmd BufWritePost *.vim silent! nested source $MYVIMRC | redraw

" Auto open cwindow.
au MyAutoCmd QuickfixCmdPost make,grep,vimgrep,qf if len(getqflist()) != 0 | copen | endif

" Restore last cursor position when open a file.
au MyAutoCmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif

" For swap.
" http://itchyny.hatenablog.com/entry/2014/12/25/090000
au MyAutoCmd SwapExists * let v:swapchoice = 'o'

" Escape cmd win.
au MyAutoCmd CmdwinEnter * nnoremap <silent><buffer><nowait> <esc> <cmd>q<cr>

" For git commit.
au MyAutoCmd VimEnter COMMIT_EDITMSG setl spell

" Automatic reload from disk
" Triger `autoread` when files changes on disk
" https://unix.stackexchange.com/questions/149209/refresh-changed-content-of-file-opened-in-vim/383044#383044
" https://vi.stackexchange.com/questions/13692/prevent-focusgained-autocmd-running-in-command-line-editing-mode
" au MyAutoCmd FocusGained,BufEnter,CursorHold,CursorHoldI * if mode() !~ '\v(c|r.?|!|t)' && getcmdwintype() == '' | checktime | endif

" Notification after file change
" https://vi.stackexchange.com/questions/13091/autocmd-event-for-autoread
" au MyAutoCmd FileChangedShellPost * echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None

if has('gui_running')
  if g:is_windows
    nnoremap <leader>r <cmd>simalt ~r<cr>
    nnoremap <leader>x <cmd>simalt ~x<cr>
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
let g:plugin_use_dein = 1
let g:plugin_use_vimplug = 0
let g:plugin_use_minpac = 0
let g:plugin_use_packager = 0
let g:plugin_use_volt = 0
let g:plugin_use_pack = 0
let g:plugin_use_packer = 0
let g:plugin_use_jetpack = 0

let g:plugin_use_lightline = 1
let g:plugin_use_airline = 0
let g:plugin_use_barow = 0
let g:plugin_use_neoline = 0 && has('nvim')
let g:plugin_use_lualine = 0 && has('nvim')
let g:plugin_use_staline = 0 && has('nvim')
let g:plugin_use_galaxyline = 0 && has('nvim')
let g:plugin_use_incline = 1 && has('nvim')

let g:plugin_use_indent_blankline = 1
let g:plugin_use_dps_indent_line = 0

let g:plugin_use_coc = 1
let g:plugin_use_ddc = 0
let g:plugin_use_vimlsp = 1 && !has('nvim') && !g:plugin_use_coc
let g:plugin_use_nvimlsp = 1 && has('nvim') && !g:plugin_use_coc

let g:plugin_use_ale = 0

let g:plugin_use_lexima = 0 && !g:plugin_use_coc
let g:plugin_use_lexiv = 0 && !g:plugin_use_coc

let g:plugin_use_quickscope = 1
let g:plugin_use_cleverf = 0
let g:plugin_use_shotf = 0

let g:plugin_use_smoothie = 0

let g:plugin_use_ctrlp = 1
let g:plugin_use_fzf = 0
let g:plugin_use_cocfzf = 0
let g:plugin_use_coclist = 0
let g:plugin_use_fz = 0
let g:plugin_use_ddu = 1
let g:plugin_use_telescope = 0 && has('nvim')
let g:plugin_use_linearf = 0 && has('nvim')

let g:plugin_use_fern = 0
let g:plugin_use_ddu_filer = 0
let g:plugin_use_vfiler = 0
let g:plugin_use_molder = 0
let g:plugin_use_vaffle = 0
let g:plugin_use_viler = 0
let g:plugin_use_coc_explorer = 1

let g:plugin_use_quickrun = 1
let g:plugin_use_asyncrun = 0

let g:plugin_use_gina = 1
let g:plugin_use_gin = 0

let g:plugin_use_gitsign = 1
let g:plugin_use_signify = 0

let g:plugin_use_bufpreview = 0
let g:plugin_use_glance = 0
let g:plugin_use_markdownpreview = 1

let g:plugin_use_neoterm = 0
let g:plugin_use_toggleterm = 0
let g:plugin_use_floaterm = 1

let g:plugin_use_beacon = 1
let g:plugin_use_columnskip = 0
let g:plugin_use_edgemotion = 1

let g:plugin_use_treesitter = 1

let g:no_plugin = get(g:, 'no_plugin', 0)
" let g:no_plugin = 1
if !g:no_plugin
  if g:plugin_use_dein
    runtime! dein.vim
  elseif g:plugin_use_vimplug
    runtime! vimplug.vim
  elseif g:plugin_use_minpac
    runtime! minpac.vim
  elseif g:plugin_use_packager
    runtime! packager.vim
  elseif g:plugin_use_volt
    runtime! volt.vim
  elseif g:plugin_use_pack
    runtime! pack.vim
  elseif g:plugin_use_packer
    runtime! packer.vim
  elseif g:plugin_use_jetpack
    runtime! jetpack.vim
  else
    echom "No use plugin manager !"
  endif
endif

" Color:
silent! syntax enable

" set cursorline cursorcolumn
au MyAutoCmd ColorScheme * hi LineNr guifg=#777777
au MyAutoCmd ColorScheme * hi CursorLineNr guibg=#5507FF guifg=#AAAAAA

" Highlight VCS conflict markers
match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'

silent! colorscheme pinkmare
set background=dark

" Neovide:
let g:neovide_transparency = 0.8
" let g:neovide_fullscreen  = 1
let g:neovide_remember_window_size = v:true
let g:neovide_profiler = v:false
let g:neovide_input_use_logo = v:true
let g:neovide_cursor_vfx_mode = "railgun"
" let g:neovide_cursor_vfx_mode = "torpedo"
" let g:neovide_cursor_vfx_mode = "pixiedust"
" let g:neovide_cursor_vfx_mode = "sonicboom"
" let g:neovide_cursor_vfx_mode = "ripple"
" let g:neovide_cursor_vfx_mode = "wireframe"
set guifont=Cica
set guifontwide=Cica

" Nvy:
let g:nvy = get(g:, 'nvy', 0)
if g:nvy
  set gfn=Cica:h12
  set gfw=Cica:h12
endif

" nvui:
if exists('g:nvui')
  set guifont=Cica:h12
  " General.
  NvuiOpacity 0.9
  NvuiCaretExtendTop 200
  NvuiCaretExtendBottom 200
  " MultiGrid.
  NvuiAnimationsEnabled 1
  NvuiScrollScaler fast-start
  NvuiScrollAnimationDuration 0.2
  NvuiMoveScaler fast-start
  NvuiMoveAnimationDuration 0.2
  " Cursor.
  NvuiCursorScaler fast-start
  NvuiCursorAnimationDuration 0.2
  " au MyAutoCmd InsertEnter * NvuiIMEEnable
  " au MyAutoCmd InsertLeave * NvuiIMEDisable
endif

" lua:
let g:vimsyn_embed = 'l'
if has('nvim')
  exe "lua require('init')"
endif

filetype plugin indent on

