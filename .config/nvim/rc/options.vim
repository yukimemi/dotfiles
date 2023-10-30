"---------------------------------------------------------------------------
" Base:
"

set fileencodings=ucs-bom,utf-8,iso-2022-jp-3,euc-jp,cp932
set iminsert=0 imsearch=0

set packpath=

"---------------------------------------------------------------------------
" Search:
"

set ignorecase
set smartcase
set incsearch
set nohlsearch
set wrapscan

"---------------------------------------------------------------------------
" Edit:
"

set smarttab
set expandtab
set shiftwidth=2
set shiftround
set autoindent smartindent
set modelines=2
set nomodeline
set backspace=indent,eol,nostop
set matchpairs+=<:>
set hidden
set nofoldenable
set foldmethod=manual
if has('nvim')
  set foldcolumn=auto:1
else
  set foldcolumn=1
endif
set fillchars=vert:\|
set commentstring=%s

set isfname-==
set isfname+=@-@

" Better for <C-w> deletion
autocmd MyAutoCmd CmdlineEnter *
      \ : let s:save_iskeyword = &l:iskeyword
      \ | setlocal iskeyword+=.
      \ | setlocal iskeyword+=-
autocmd MyAutoCmd CmdlineLeave *
      \ let &l:iskeyword = s:save_iskeyword

set timeout timeoutlen=500 ttimeoutlen=100
set updatetime=1000
set directory-=.
set undofile
let &g:undodir = &directory
set virtualedit=block
set keywordprg=:help

set clipboard=unnamedplus

autocmd MyAutoCmd InsertLeave *
      \ : if &paste
      \ |   setlocal nopaste
      \ |   echo 'nopaste'
      \ | endif
      \ | if &l:diff
      \ |   diffupdate
      \ | endif

autocmd MyAutoCmd InsertLeave *
      \ : if &l:diff
      \ |   diffupdate
      \ | endif

set diffopt=internal,algorithm:patience,indent-heuristic

autocmd MyAutoCmd BufWritePre *
      \ call s:mkdir_as_necessary('<afile>:p:h'->expand(), v:cmdbang)
function s:mkdir_as_necessary(dir, force) abort
  if a:dir->isdirectory() || &l:buftype !=# ''
    return
  endif

  const message = printf('"%s" does not exist. Create? [y/N] ', a:dir)
  if a:force || message->input() =~? '^y\%[es]$'
    call mkdir(a:dir->iconv(&encoding, &termencoding), 'p')
  endif
endfunction

set helplang& helplang=en,ja
set fileformat=unix
set fileformats=unix,dos,mac
let g:editorconfig = v:false

"---------------------------------------------------------------------------
" View:
"

if has('gui_running')
  set guioptions=Mc
endif

set list
if has('win32')
   set listchars=tab:>-,trail:-,precedes:<
else
   set listchars=tab:▸\ ,trail:-,precedes:«,nbsp:%
endif

set report=1000

set number
set relativenumber
set nowrap
set linebreak
set showbreak=\
set breakat=\ \	;:,!?
set whichwrap+=h,l,<,>,[,],b,s,~
set breakindent
set termguicolors

set nowritebackup
set nobackup
set noswapfile
set backupdir-=.

set t_vb=
set novisualbell
set belloff=all

set showfulltag
set wildchar=<C-t>
set wildcharm=<C-t>
set wildignorecase
set wildmenu
set wildmode=full
set wildmode=list:longest,full
set wildoptions+=fuzzy,tagfile

set history=200

set completeopt=menu,preview

set pumheight=30
set pumwidth=0
set completeslash=slash
set omnifunc=v:lua.vim.lsp.omnifunc

set nostartofline
set splitbelow
set splitright
set winwidth=30
set winheight=1
set cmdwinheight=5
set noequalalways
if '+splitscroll'->exists()
  set nosplitscroll
endif

set previewheight=8
set helpheight=12

set ttyfast

set display=lastline
set display+=uhex

set conceallevel=2
set colorcolumn=100

if '+previewpopup'->exists()
  set previewpopup=height:10,width:60
endif

set signcolumn=yes

exe "set cedit=\<C-s>"
set redrawtime=0

if '+termwinkey'->exists()
  set termwinkey=<C-L>
endif

if '+smoothscroll'->exists()
  set smoothscroll
endif

set nomore

