" =============================================================================
" File        : .vimrc
" Author      : yukimemi
" Last Change : 2016/05/30 07:07:11.
" =============================================================================

" Init: {{{1
set encoding=utf-8
scriptencoding utf-8

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
if has('nvim')
  let $VIM_PATH = expand('~/.config/nvim')
  let $MYVIMRC = expand('~/.config/nvim/init.vim')
else
  let $VIM_PATH = expand('~/.vim')
  let $MYVIMRC = expand('~/.vimrc')
  let $MYGVIMRC = expand('~/.gvimrc')
endif
let $CACHE = expand('~/.cache')
let $BACKUP_PATH = expand('$CACHE/vim/back')

" Add runtimepath for windows.
if g:is_windows
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
  9,$s/^/> /
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

" Plugin: {{{1
" Use dein.
let s:cache_home = empty($XDG_CACHE_HOME) ? expand('~/.cache') : $XDG_CACHE_HOME
let s:dein_dir = s:cache_home . '/dein'
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
if !isdirectory(s:dein_repo_dir)
  "execute '!git clone https://github.com/Shougo/dein.vim ' . shellescape(s:dein_repo_dir)
  execute '!git clone https://github.com/Shougo/dein.vim ' . s:dein_repo_dir
endif
execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')

let g:dein#install_max_processes = 16
let g:dein#install_progress_type = 'title'
let g:dein#enable_notification = 1
let s:toml_file = $VIM_PATH . '/dein.toml'
if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir, [$MYVIMRC, s:toml_file])
  call dein#load_toml(s:toml_file)
  call dein#end()
  call dein#save_state()
endif
" Check and install.
if has('vim_starting') && dein#check_install()
  call dein#install()
endif

if dein#tap('lightline.vim') "{{{2
  let g:lightline = {
        \ 'colorscheme': 'solarized',
        \ 'mode_map': {
        \   'n' : 'N',
        \   'i' : 'I',
        \   'R' : 'R',
        \   'v' : 'V',
        \   'V' : 'V-L',
        \   'c' : 'C',
        \   "\<C-v>": 'V-B',
        \   's' : 'S',
        \   'S' : 'S-L',
        \   "\<C-s>": 'S-B'
        \   },
        \ 'active': {
        \   'left': [ [ 'mode', 'paste' ], [ 'filename', 'anzu' ] ],
        \   'right': [ [ 'lineinfo' ], [ 'percent' ], [ 'fileformat', 'fileencoding', 'bomb', 'filetype' ],
        \              [ 'absolutepath', 'charcode' ] ]
        \ },
        \ 'component': {
        \   'charcode': '[%03.3b, 0x%02.2B]'
        \ },
        \ 'component_function': {
        \   'modified': 'MyModified',
        \   'readonly': 'MyReadonly',
        \   'fugitive': 'MyFugitive',
        \   'git_branch': 'MyGitBranch',
        \   'git_traffic': 'MyGitTraffic',
        \   'git_status': 'MyGitStatus',
        \   'filename': 'MyFilename',
        \   'fileformat': 'MyFileformat',
        \   'filetype': 'MyFiletype',
        \   'fileencoding': 'MyFileencoding',
        \   'bomb': 'MyBomb',
        \   'absolutepath': 'MyAbsolutePath',
        \   'mode': 'MyMode',
        \   'anzu': 'anzu#search_status',
        \ }
        \ }
        " \   'left': [ [ 'mode', 'paste' ], [ 'git_branch', 'git_traffic', 'git_status', 'filename', 'anzu' ] ],

  function! MyModified()
    return &ft =~ 'help\|vimfiler\|gundo' ? '' : &modified ? '+' : &modifiable ? '' : '-'
  endfunction

  function! MyReadonly()
    if g:is_windows
      return &ft !~? 'help\|vimfiler\|gundo' && &readonly ? 'R' : ''
    else
      return &ft !~? 'help\|vimfiler\|gundo' && &readonly ? '⭤' : ''
    endif
  endfunction

  function! MyFilename()
    return ('' != MyReadonly() ? MyReadonly() . ' ' : '') .
          \ (&ft == 'vimfiler' ? vimfiler#get_status_string() :
          \  &ft == 'unite' ? unite#get_status_string() :
          \  &ft == 'vimshell' ? vimshell#get_status_string() :
          \ '' != expand('%:t') ? expand('%:t') : '[No Name]') .
          \ ('' != MyModified() ? ' ' . MyModified() : '')
  endfunction

  function! MyGitBranch()
    return winwidth(0) > 70 ? gita#statusline#preset('branch_fancy') : ''
  endfunction
  function! MyGitTraffic()
    return winwidth(0) > 70 ? gita#statusline#preset('traffic_fancy') : ''
  endfunction
  function! MyGitStatus()
    return winwidth(0) > 70 ? gita#statusline#preset('status') : ''
  endfunction

  function! MyFugitive()
    if &ft !~? 'vimfiler\|gundo' && exists("*fugitive#head")
      let _ = fugitive#head()
      if g:is_windows
        return strlen(_) ? '| '._ : ''
      else
        return strlen(_) ? '⭠ '._ : ''
      endif
    endif
    return ''
  endfunction

  function! MyFileformat()
    return winwidth('.') > 70 ? &fileformat : ''
  endfunction

  function! MyFiletype()
    return winwidth('.') > 70 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
  endfunction

  function! MyFileencoding()
    return winwidth('.') > 70 ? (strlen(&fenc) ? &fenc : &enc) : ''
  endfunction

  function! MyBomb()
    return &bomb ? 'b' : 'nb'
  endfunction

  function! MyMode()
    return winwidth('.') > 60 ? lightline#mode() : ''
  endfunction

  function! MyAbsolutePath()
    return (winwidth('.') - strlen(expand('%:p')) > 90) ? expand('%:p') : ((winwidth('.') - strlen(expand('%')) > 70) ? expand('%') : '')
  endfunction
endif

if dein#tap('vim-automatic') "{{{2
  nnoremap <silent> <Plug>(quit) :<C-u>q<CR>
  function! s:my_automatic(config, context)
    silent! nmap <buffer> <C-[> <Plug>(quit)
  endfunction

  let g:automatic_default_match_config = {
        \   'is_open_other_window': 1
        \ }
  let g:automatic_default_set_config = {
        \   'height': '40%',
        \   'move': "bottom",
        \   'apply': function('s:my_automatic')
        \ }
  let g:automatic_config = [
        \   {'match': {'buftype': 'help'}},
        \   {'match': {'bufname': 'MacDict.*'}},
        \   {
        \     'match': {
        \       'autocmd_history_pattern' : 'BufWinEnterFileType$',
        \       'filetype' : 'unite'
        \     },
        \     'set': {
        \       'unsettings': ['move', 'resize']
        \     }
        \   },
        \   {
        \     'match': {
        \       'filetype': 'qf',
        \       'autocmds': ['FileType']
        \     },
        \     'set': {
        \       'height': 8
        \     }
        \   },
        \   {
        \     'match': {
        \       'filetype': '\v^ref-.+',
        \       'autocmds': ['FileType']
        \     }
        \   },
        \   {
        \     'match': {
        \       'bufname': '\[quickrun output\]'
        \     },
        \     'set': {
        \       'height': 8
        \     }
        \   },
        \   {
        \     'match': {
        \       'autocmds': ['CmdwinEnter']
        \     },
        \     'set': {
        \       'is_close_focus_out': 1,
        \       'unsettings': ['move', 'resize']
        \     }
        \   }
        \ ]
endif

" After dein
filetype plugin indent on
syntax enable

" Basic: {{{1

" Use vimproc for system.
let s:system = exists('g:loaded_vimproc') ? 'vimproc#system_bg' : 'system'

" ctags.
set tags& tags-=tags tags+=./tags;

" undo, swap.
call Mkdir($BACKUP_PATH)
set undofile
set undodir=$BACKUP_PATH
set backupdir=$BACKUP_PATH
set directory=$BACKUP_PATH

" Encodings.
set fileencodings=utf-8,cp932,utf-16le,utf-16
set fileformat=unix
set fileformats=unix,dos,mac

" Clipboard.
if has('unnamedplus')
  set clipboard=unnamedplus,autoselect
else
  set clipboard& clipboard+=unnamed
endif

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
set showcmd
set display=lastline
set foldmethod=marker
" set foldclose=all
set t_Co=256

" Color: {{{1
set background=dark
colorscheme japanesque

" hilight cursorline, cursorcolumn {{{2
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
" au MyAutoCmd BufNewFile,BufRead *.toml setl ft=toml


" Mapping: {{{1
" Use verymagic.
" nnoremap / /\v
" inoremap %s/ %s/\v

" Use space.
nmap <Space> [Space]
nnoremap [Space] <Nop>

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

" For tab.
nnoremap <C-l> gt
nnoremap <C-h> gT

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
au MyAutoCmd BufWritePre * call s:auto_mkdir(expand('<afile>:p:h'), v:cmdbang)

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

" cmdwin.
nnoremap : q:i
vnoremap : q:A

" Delete other line.
nnoremap [Space]d :<C-u>call <SID>deleteOtherLine()<CR>

" dein update.
nnoremap [Space]du :<C-u>call dein#update()<CR>

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
nnoremap sn gt
nnoremap sp gT
nnoremap sr <C-w>r
nnoremap s= <C-w>=
nnoremap sw <C-w>w
nnoremap so <C-w>_<C-w>|
nnoremap s0 :<C-u>only<CR>
nnoremap sO :<C-u>tabonly<CR>
nnoremap sN :<C-u>bn<CR>
nnoremap sP :<C-u>bp<CR>
nnoremap st :<C-u>tabnew<CR>
nnoremap ss :<C-u>sp<CR>
nnoremap sv :<C-u>vs<CR>
nnoremap sq :<C-u>q<CR>
nnoremap sQ :<C-u>bd<CR>
nnoremap sbk :<C-u>bd!<CR>
nnoremap sbq :<C-u>q!<CR>

"  for git mergetool {{{2
if &diff
  nnoremap <buffer> <Leader>1 :diffget LOCAL<CR>
  nnoremap <buffer> <Leader>2 :diffget BASE<CR>
  nnoremap <buffer> <Leader>3 :diffget REMOTE<CR>
  nnoremap <buffer> <Leader>u :<C-u>diffupdate<CR>
  nnoremap <buffer> u u:<C-u>diffupdate<CR>
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
" nnoremap [Space]f :<C-u>call <SID>format()<CR>

" Autocmd: {{{1
au MyAutoCmd WinEnter,CursorHold * checktime
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
autocmd FileType * setlocal formatoptions-=ro

au MyAutoCmd BufWritePost * call <SID>removeFileIf0Byte()

" Restore last cursor position when open a file.
au MyAutoCmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif

" For swap.
" http://itchyny.hatenablog.com/entry/2014/12/25/090000
au MyAutoCmd SwapExists * let v:swapchoice = 'o'

" vim:fdm=marker expandtab fdc=3 ft=vim ts=2 sw=2 sts=2:
