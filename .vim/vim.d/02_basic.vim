" backup directory
let $MY_BACKUP_DIR = $CACHE . '/vim/back'
call Mkdir($MY_BACKUP_DIR)

" ctags
" set tags+=tags;
" set tag file. don't search tags in pwd and search upward
set tags& tags-=tags tags+=./tags;

" use vimproc for system
let s:system = exists('g:loaded_vimproc') ? 'vimproc#system_bg' : 'system'

set undofile
set undodir=$MY_BACKUP_DIR
set backupdir=$MY_BACKUP_DIR
set directory=$MY_BACKUP_DIR
set encoding=utf-8
set fileencodings=utf-8,cp932,utf-16le,utf-16
set fileformat=unix
set fileformats=unix,dos,mac
" Use clipboard register.
if has('unnamedplus')
  set clipboard=unnamedplus,autoselect
else
  set clipboard& clipboard+=unnamed
endif
if exists('+breakindent')
  set breakindent
endif
set pastetoggle=
set switchbuf=useopen
set nrformats-=octal
set timeoutlen=3500
set hidden
set history=10000
set formatoptions+=mM
set textwidth=0
set virtualedit=block
set whichwrap=b,s,[,],<,>
set backspace=indent,eol,start
set ambiwidth=double
set wildmenu
set wildmode=longest:full,full
set scrolloff=3
if has('mouse')
  set mouse=a
endif
set keywordprg=:help
set autoread
au MyAutoCmd WinEnter,CursorHold * checktime
au MyAutoCmd BufNewFile,BufRead *.csv,*.log setl nowrap
au MyAutoCmd WinEnter,BufEnter * set formatoptions-=ro
au MyAutoCmd CursorHold * setl nohlsearch
" http://sangoukan.xrea.jp/cgi-bin/tDiary/?date=20120313
" au MyAutoCmd FileType * :inoremap # X#
" http://d.hatena.ne.jp/osyo-manga/20140210/1392036881
au MyAutoCmd CmdwinEnter * :silent! 1,$-20 delete _ | call cursor("$", 1)
" Reload .vimrc automatically.
" au MyAutoCmd BufWritePost *vimrc source $MYVIMRC | redraw
" au MyAutoCmd BufWritePost *gvimrc if has('gui_running') source $MYGVIMRC
au MyAutoCmd BufWritePost .vimrc,vimrc,*.vim,neobundle*.toml NeoBundleClearCache

set ignorecase
set smartcase
set wrapscan
set incsearch
set infercase
set hlsearch
set grepprg=jvgrep
" https://sites.google.com/site/hymd3a/vim/vimgrep
au MyAutoCmd QuickfixCmdPost make,grep,vimgrep if len(getqflist()) != 0 | copen | endif
" use verymagic
nnoremap / /\v
inoremap %s/ %s/\v

set noerrorbells
set novisualbell
set visualbell t_vb=
set shellslash
set number
set showmatch matchtime=1
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
set autoindent
set smartindent
set smarttab
set iminsert=0
set imsearch=-1
set cinoptions+=:0
set title
set cmdheight=2
set laststatus=2
set showcmd
set display=lastline
set foldmethod=marker
" set foldclose=all
set t_Co=256

" color
set background=dark
colorscheme solarized

highlight Search ctermbg=88
highlight Normal ctermbg=none

" hilight cursorline, cursorcolumn "{{{
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
"}}}

" http://mattn.kaoriya.net/software/vim/20140523124903.htm
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

" For binary
au MyAutoCmd BufReadPre  *.bin,*.dat let &bin=1
au MyAutoCmd BufReadPost *.bin,*.dat if &bin | %!xxd
au MyAutoCmd BufReadPost *.bin,*.dat set ft=xxd | endif
au MyAutoCmd BufWritePre *.bin,*.dat if &bin | %!xxd -r
au MyAutoCmd BufWritePre *.bin,*.dat endif
au MyAutoCmd BufWritePost *.bin,*.dat if &bin | %!xxd
au MyAutoCmd BufWritePost *.bin,*.dat set nomod | endif

