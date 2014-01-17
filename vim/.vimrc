"{{{ ========== Basics ================================================================
set nocompatible
scriptencoding utf-8

" vim config path"{{{
if isdirectory($HOME . '/.vim')
    let $MY_VIMRUNTIME = $HOME . '/.vim'
elseif isdirectory($HOME . '\vimfiles')
    let $MY_VIMRUNTIME = $HOME . '\vimfiles'
elseif isdirectory($VIM . '\vimfiles')
    let $MY_VIMRUNTIME = $VIM . '\vimfiles'
endif"}}}

" judge os type"{{{
let s:is_windows = has('win16') || has('win32') || has('win64')
let s:is_cygwin = has('win32unix')
let s:is_darwin = has('mac') || has('macunix') || has('gui_macvim')
let s:is_linux = !s:is_windows && !s:is_cygwin && !s:is_darwin"}}}

" release autogroup in MyAutoCmd"{{{
augroup MyAutoCmd
    autocmd!
augroup END"}}}

" Echo startup time on start"{{{
if has('vim_starting') && has('reltime')
    let g:startuptime = reltime()
    augroup MyAutoCmd
        autocmd! VimEnter * let g:startuptime = reltime(g:startuptime) | redraw
                    \ | echomsg 'startuptime: ' . reltimestr(g:startuptime)
    augroup END
endif"}}}
"===================================================================================}}}

"{{{ ========== Plugins ===============================================================
" neobundle.vim

" clone neobundle"{{{
function! s:clone_neobundle()
    let s:bundle_dir = $HOME . "/.bundle"
    let s:neobundle_dir = s:bundle_dir . "/neobundle.vim"
    call s:mkdir(s:bundle_dir)
    if !isdirectory(s:neobundle_dir)
        echom "cloning neobundle ..."
        let s:com = "git clone git://github.com/Shougo/neobundle.vim " . s:neobundle_dir
        echom s:com
        call system(s:com)
    endif
endfunction"}}}

if has('vim_starting')
    set runtimepath+=~/.bundle/neobundle.vim
    call neobundle#rc(expand('~/.bundle'))
endif

" Let NeoBundle manage NeoBundle
NeoBundleFetch 'Shougo/neobundle.vim'

" plugin list {{{
NeoBundle 'Shougo/vimproc.vim', {
            \ 'build': {
            \   'windows' : 'c:\MinGW\bin\mingw32-make -f make_mingw32.mak',
            \   'cygwin'  : 'make -f make_cygwin.mak',
            \   'mac'     : 'make -f make_mac.mak',
            \   'unix'    : 'make -f make_unix.mak',
            \ }}
NeoBundle 'CmdlineCompl.vim'
NeoBundle 'LeafCage/foldCC'
NeoBundle 'LeafCage/yankround.vim', {'depends': 'kien/ctrlp.vim'}
NeoBundle 'The-NERD-Commenter'
"NeoBundle 'airblade/vim-gitgutter'
NeoBundle 'altercation/vim-colors-solarized'
NeoBundle 'banyan/recognize_charcode.vim'
NeoBundle 'cocopon/lightline-hybrid.vim', {'depends': 'itchyny/lightline.vim'}
NeoBundle 'fuenor/qfixgrep'
"NeoBundle 'fuenor/qfixhowm'
NeoBundle 'goldfeld/vim-seek'
NeoBundle 'itchyny/landscape.vim'
NeoBundle 'itchyny/lightline.vim'
NeoBundle 'jceb/vim-hier'
NeoBundle 'kana/vim-textobj-entire', {'depends': 'kana/vim-textobj-user'}
NeoBundle 'kana/vim-textobj-function', {'depends': 'kana/vim-textobj-user'}
NeoBundle 'kana/vim-textobj-indent', {'depends': 'kana/vim-textobj-user'}
NeoBundle 'kana/vim-textobj-fold', {'depends': 'kana/vim-textobj-user'}
NeoBundle 'kana/vim-textobj-user'
NeoBundle 'mattn/sonictemplate-vim'
NeoBundle 'mattn/webapi-vim'
"NeoBundle 'nathanaelkane/vim-indent-guides'
NeoBundle 'Yggdroot/indentLine'
NeoBundle 'osyo-manga/vim-anzu'
NeoBundle 'osyo-manga/vim-automatic', {'depends': ['osyo-manga/vim-gift', 'osyo-manga/vim-reunions']}
NeoBundle 'osyo-manga/vim-textobj-multitextobj', {'depends': 'kana/vim-textobj-user'}
NeoBundle 'kana/vim-operator-replace', {'depends': 'kana/vim-operator-user'}
NeoBundle 'tyru/operator-star.vim', {'depends': ['kana/vim-operator-user', 'thinca/vim-visualstar']}
NeoBundle 'szw/vim-tags', {'build': {'mac': 'brew install ctags'}}
NeoBundle 'thinca/vim-submode'
NeoBundle 'tomasr/molokai'
NeoBundle 'tpope/vim-fugitive'
"NeoBundle 'tpope/vim-surround'
NeoBundle 'vim-jp/vimdoc-ja'
NeoBundle 'w0ng/vim-hybrid'
NeoBundle 'osyo-manga/shabadou.vim', {'depends': 'thinca/vim-quickrun'}
NeoBundle 'scrooloose/syntastic'
NeoBundle 'jiangmiao/auto-pairs'
NeoBundle 'osyo-manga/vim-precious', {'depends': 'Shougo/context_filetype.vim'}
NeoBundleLazy 'mattn/unite-vim_advent-calendar', {'depends': ['Shougo/unite.vim', 'mattn/webapi-vim']}
NeoBundleLazy 'mattn/unite-advent_calendar', {'depends': ['Shougo/unite.vim', 'mattn/webapi-vim']}
NeoBundleLazy 'itchyny/thumbnail.vim'
NeoBundleLazy 'itchyny/calendar.vim'
NeoBundleLazy 'superbrothers/vim-vimperator'
NeoBundleLazy 'gregsexton/gitv', {'depends': 'tpope/vim-fugitive'}
"NeoBundleLazy 'pekepeke/titanium-vim'
NeoBundleLazy 'rhysd/vim-textobj-ruby', {'depends': 'kana/vim-textobj-user'}
NeoBundleLazy 'osyo-manga/vim-textobj-multiblock', {'depends': 'kana/vim-textobj-user'}
NeoBundleLazy 'osyo-manga/vim-operator-search', {'depends': 'kana/vim-operator-user'}
NeoBundleLazy 'thinca/vim-visualstar'
NeoBundleLazy 'osyo-manga/unite-qfixhowm', {'depends': 'fuenor/qfixhowm'}
NeoBundleLazy 'tyru/restart.vim'
NeoBundleLazy 'tyru/capture.vim'
"NeoBundleLazy 'thinca/vim-ft-clojure'
NeoBundleLazy 'kana/vim-filetype-haskell'
NeoBundleLazy 'AndrewRadev/splitjoin.vim'
NeoBundleLazy 'AndrewRadev/linediff.vim'
NeoBundleLazy 'DrawIt'
NeoBundleLazy 'pangloss/vim-javascript'
"NeoBundleLazy 'jelera/vim-javascript-syntax'
"NeoBundleLazy 'jiangmiao/simple-javascript-indenter'
NeoBundleLazy 'LeafCage/nebula.vim'
NeoBundleLazy 'PProvost/vim-ps1'
NeoBundleLazy 'SQLUtilities'
NeoBundleLazy 'Shougo/echodoc.vim'
NeoBundleLazy 'Shougo/junkfile.vim'
NeoBundleLazy 'Shougo/neosnippet.vim', {'depends': 'Shougo/neosnippet-snippets'}
NeoBundleLazy 'Shougo/unite.vim', {'depends': 'Shougo/vimproc.vim'}
NeoBundleLazy 'Shougo/vim-vcs'
NeoBundleLazy 'Shougo/vimfiler.vim', {'depends': 'Shougo/unite.vim'}
NeoBundleLazy 'Shougo/vimshell.vim', {'depends': 'Shougo/vimproc.vim'}
NeoBundleLazy 'Shougo/vinarise.vim'
"NeoBundleLazy 'adogear/vim-blockdiag-series'
NeoBundleLazy 'aklt/plantuml-syntax'
NeoBundleLazy 'alpaca-tc/alpaca_tags', {'depends': 'Shougo/vimproc.vim'}
NeoBundleLazy 'basyura/J6uil.vim', {'depends': ['Shougo/vimproc.vim', 'mattn/webapi-vim']}
NeoBundleLazy 'basyura/unite-firefox-bookmarks', {'depends': ['tyru/open-browser.vim', 'mattn/webapi-vim']}
NeoBundleLazy 'basyura/unite-rails', {'depends': 'Shougo/unite.vim'}
NeoBundleLazy 'choplin/unite-vim_hacks'
NeoBundleLazy 'cocopon/colorswatch.vim'
NeoBundleLazy 'dag/vim2hs'
NeoBundleLazy 'derekwyatt/vim-scala', {'build': {'mac': 'brew install scala sbt'}}
NeoBundleLazy 'digitaltoad/vim-jade'
NeoBundleLazy 'drakontia/sphinx.vim'
NeoBundleLazy 'eagletmt/ghcmod-vim', {'build': {'mac': 'cabal install ghc-mod'}}
NeoBundleLazy 'eagletmt/unite-haddock'
NeoBundleLazy 'edsono/vim-matchit'
NeoBundleLazy 'h1mesuke/unite-outline', {'depends': 'Shougo/unite.vim'}
NeoBundleLazy 'h1mesuke/vim-alignta'
NeoBundleLazy 'itchyny/dictionary.vim'
NeoBundleLazy 'jmcantrell/vim-virtualenv'
NeoBundleLazy 'jpo/vim-railscasts-theme'
NeoBundleLazy 'kchmck/vim-coffee-script'
NeoBundleLazy 'kien/ctrlp.vim'
NeoBundleLazy 'koron/chalice'
NeoBundleLazy 'lambdalisue/vim-django-support'
NeoBundleLazy 'leafgarland/typescript-vim'
NeoBundleLazy 'majutsushi/tagbar', {'build': {'mac': 'brew install ctags'}}
NeoBundleLazy 'mattn/emmet-vim'
NeoBundleLazy 'mattn/excitetranslate-vim'
NeoBundleLazy 'mattn/gist-vim', {'depends': 'mattn/webapi-vim'}
NeoBundleLazy 'mattn/googletasks-vim', {'depends': 'mattn/webapi-vim'}
NeoBundleLazy 'mattn/unite-advent_calendar'
NeoBundleLazy 'mattn/vimplenote-vim'
NeoBundleLazy 'mitechie/pyflakes-pathogen'
NeoBundleLazy 'modsound/macdict-vim'
NeoBundleLazy 'nanotech/jellybeans.vim'
NeoBundleLazy 'osyo-manga/vim-over'
NeoBundleLazy 'osyo-manga/vim-watchdogs'
NeoBundleLazy 'pasela/unite-webcolorname'
NeoBundleLazy 'rking/ag.vim'
NeoBundleLazy 'sjl/gundo.vim'
NeoBundleLazy 'supermomonga/vimshell-pure.vim', {'depends' : 'Shougo/vimshell.vim'}
NeoBundleLazy 't9md/vim-quickhl'
NeoBundleLazy 'tacroe/unite-mark'
NeoBundleLazy 'thinca/vim-qfreplace'
NeoBundleLazy 'thinca/vim-quickrun'
NeoBundleLazy 'thinca/vim-ref'
NeoBundleLazy 'thinca/vim-singleton'
NeoBundleLazy 'thinca/vim-template'
NeoBundleLazy 'thinca/vim-splash'
NeoBundleLazy 'thinca/vim-prettyprint'
NeoBundleLazy 'tpope/vim-endwise'
NeoBundleLazy 'tpope/vim-fireplace', {'depends': ['tpope/vim-classpath', 'guns/vim-clojure-static']}
NeoBundleLazy 'tpope/vim-rails'
NeoBundleLazy 'tsukkee/unite-help', {'depends': 'Shougo/unite.vim'}
NeoBundleLazy 'tsukkee/unite-tag', {'depends': 'Shougo/unite.vim'}
NeoBundleLazy 'tyru/open-browser.vim'
NeoBundleLazy 'ujihisa/neco-ghc'
NeoBundleLazy 'ujihisa/unite-colorscheme'
NeoBundleLazy 'ujihisa/unite-font'
NeoBundleLazy 'hachibeeDI/vim-vbnet'
NeoBundleLazy 'vim-ruby/vim-ruby'
NeoBundleLazy 'vim-scripts/Wombat'
NeoBundleLazy 'vim-scripts/copypath.vim'
NeoBundleLazy 'wavded/vim-stylus'
NeoBundleLazy 'wesleyche/SrcExpl'
NeoBundleLazy 'yuyunko/dosbatch-indent', {'depends': 'taku-o/vim-batch-source'}
NeoBundleLazy 'zhisheng/visualmark.vim'
NeoBundleLazy 't9md/vim-choosewin'
NeoBundleLazy 'davidhalter/jedi-vim', {
            \ 'depends': 'mitechie/pyflakes-pathogen',
            \ 'build': {
            \   'mac': 'pip install jedi',
            \   'unix': 'pip install jedi'
            \ }}
NeoBundleLazy 'basyura/TweetVim', 'dev', {
            \ 'depends': [
            \   'tyru/open-browser.vim',
            \   'basyura/twibill.vim',
            \   'basyura/bitly.vim',
            \   'Shougo/unite.vim',
            \   'Shougo/unite-outline',
            \   'Shougo/vimproc.vim',
            \   'mattn/favstar-vim',
            \   'mattn/webapi-vim'
            \ ]}
NeoBundleLazy 'jnwhiteh/vim-golang', {
            \ 'build': {
            \   'windows': ['go get github.com/nsf/gocode', 'go get github.com/golang/lint'],
            \   'cygwin' : ['go get github.com/nsf/gocode', 'go get github.com/golang/lint'],
            \   'mac'    : ['go get github.com/nsf/gocode', 'go get github.com/golang/lint'],
            \   'unix'   : ['go get github.com/nsf/gocode', 'go get github.com/golang/lint']
            \ }}
if has('lua') && ((v:version >= 703 && has('patch885')) || v:version >= 704)
  NeoBundleLazy 'Shougo/neocomplete.vim'
else
  NeoBundleLazy 'Shougo/neocomplcache.vim'
endif

filetype plugin indent on

" Installation check.
if ! has('gui_running')
    NeoBundleCheck
endif"}}}
"===================================================================================}}}

"{{{ ========== Function ============================================================
" Restore last cursor position when open a file"{{{
au MyAutoCmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
"}}}

" highlight Zenkaku space"{{{
function! ZenkakuSpace()
    highlight ZenkakuSpace cterm=underline ctermfg=darkgrey gui=underline guifg=darkgrey
    silent! match ZenkakuSpace /　/
endfunction

if has('syntax')
    au MyAutoCmd VimEnter,BufEnter * call ZenkakuSpace()
endif"}}}

" autochdir"{{{
au MyAutoCmd BufEnter * execute ":silent! lcd " . escape(expand("%:p:h"), ' ')
"}}}

" ctags
" set tags+=tags;
" set tag file. don't search tags in pwd and search upward
set tags& tags-=tags tags+=./tags;

" use vimproc for system
let s:system = exists('g:loaded_vimproc') ? 'vimproc#system_bg' : 'system'

" compiler
au MyAutoCmd FileType scala compiler sbt

function! s:mkdir(dir)"{{{
    if !isdirectory(a:dir)
        call mkdir(a:dir, "p")
    endif
endfunction"}}}

function! s:Str2byte(str)"{{{
    return map(range(len(a:str)), 'char2nr(a:str[v:val])')
endfunction"}}}

function! s:Byte2hex(bytes)"{{{
    return join(map(copy(a:bytes), 'printf("%02X", v:val)'), '')
endfunction"}}}

function! Rtrim()"{{{
    " delete space at the end of line
    let save_cursor = getpos(".")
    %s/\s\+$//e
    call setpos(".", save_cursor)
endfunction
"au MyAutoCmd BufWritePre * call Rtrim()
"}}}

function! Format()"{{{
    " auto indent format
    let save_view = winsaveview()
    normal gg=G
    call winrestview(save_view)
endfunction
nnoremap [Space]f :call Format()<CR>
"au MyAutoCmd BufWrite * call Format()
"}}}

function! s:open_in_browser()"{{{
    " open html in browser
    if s:is_windows
        silent ! start iexplore "%:p"
    else
        silent ! start firefox "%:p"
    endif
endfunction"}}}

function! s:auto_mkdir(dir, force)"{{{
    " Hack #202: http://vim-users.jp/2011/02/hack202/
    if !isdirectory(a:dir) && (a:force ||
                \ input(printf('"%s" does not exist. Create? [y/N]', a:dir)) =~? '^y\%[es]$')
        call mkdir(iconv(a:dir, &encoding, &termencoding), 'p')
    endif
endfunction
au MyAutoCmd BufWritePre * call s:auto_mkdir(expand('<afile>:p:h'), v:cmdbang)
"}}}

" diff original"{{{
command! DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis | wincmd p | diffthis
"}}}

" save as root"{{{
com! Wsu w !sudo tee > /dev/null %
"}}}
"===================================================================================}}}

"{{{ ========== System ================================================================
" backup directory
let $MY_BACKUP_DIR = $MY_VIMRUNTIME . '/back'
call s:mkdir($MY_BACKUP_DIR)
call s:clone_neobundle()

if version >= 703
    set undofile
    set undodir=$MY_BACKUP_DIR
endif
set encoding=utf-8 " encoding
set clipboard+=unnamed
set switchbuf=useopen
set nrformats-=octal " disable octal
set timeoutlen=3500
set hidden
set history=100000
set formatoptions+=mM
set textwidth=0
set virtualedit=block
set whichwrap=b,s,[,],<,>
set backspace=indent,eol,start
set ambiwidth=double
set wildmenu
set wildmode=longest:full,full
if has('mouse')
    set mouse=a
endif
set autoread
au MyAutoCmd WinEnter * checktime
" for log files
au MyAutoCmd BufNewFile,BufRead *.csv,*.log setl nowrap
" no insert comment
au MyAutoCmd FileType * set formatoptions-=ro
" windows cygwin
if s:is_windows
    if isdirectory("C:/cygwin/bin")
        let $PATH = 'C:/cygwin/bin;' . $PATH
    endif
endif
"===================================================================================}}}

"{{{ ========== Search ================================================================
set ignorecase
set smartcase
set wrapscan
set incsearch
set infercase " Ignore case on insert completion.
set hlsearch
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>
set grepprg=grep\ -nH
" https://sites.google.com/site/hymd3a/vim/vimgrep
au MyAutoCmd QuickfixCmdPost make,grep,vimgrep if len(getqflist()) != 0 | copen | endif
" Hack #104: http://vim-users.jp/2009/11/hack104/
"vnoremap <silent> * "vy/\V<C-r>=substitute(escape(@v,'\/'),"\n",'\\n','g')<CR><CR>
" Hack #62: http://vim-users.jp/2009/08/hack62/
"nnoremap <expr> s* ':%substitute/\<' . expand('<cword>') . '\>/'
" use verymagic
nnoremap / /\v
inoremap %s/ %s/\v
"===================================================================================}}}

"{{{ ========== Appearance ============================================================
set noerrorbells
set novisualbell
set visualbell t_vb=
set shellslash
set number
set showmatch matchtime=3
set tabstop=4
set shiftwidth=4
set softtabstop=0
set expandtab
set list
if s:is_windows
    set listchars=tab:>\ ,trail:-,extends:>,precedes:<
else
    "set listchars=tab:»\ ,trail:-,extends:»,precedes:«,nbsp:%
    set listchars=tab:\¦\ ,trail:-,extends:»,precedes:«,nbsp:%
endif
set backupdir=$MY_BACKUP_DIR
set directory=$MY_BACKUP_DIR
set autoindent
set smartindent
set smarttab
set cinoptions+=:0
set title
set cmdheight=2
set laststatus=2
set showcmd
set display=lastline
set foldmethod=marker
set foldclose=all
set t_Co=256
if &t_Co > 2 || has('gui_running')
    syntax on
endif

" color
set background=dark
colorscheme molokai

highlight Search ctermbg=88

" hilight cursorline, cursorcolumn {{{
" http://d.hatena.ne.jp/thinca/20090530/1243615055
au MyAutoCmd CursorMoved,CursorMovedI * call s:auto_cursorline('CursorMoved')
au MyAutoCmd CursorHold,CursorHoldI * call s:auto_cursorline('CursorHold')
au MyAutoCmd WinEnter * call s:auto_cursorline('WinEnter')
au MyAutoCmd WinLeave * call s:auto_cursorline('WinLeave')

let s:cursorline_lock = 0
function! s:auto_cursorline(event)
    if a:event ==# 'WinEnter'
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
        setlocal cursorline
        setlocal cursorcolumn
        let s:cursorline_lock = 1
    endif
endfunction"}}}
"===================================================================================}}}

"{{{ ========== Mappings ==============================================================
nnoremap j gj
nnoremap k gk
nnoremap <Down> gj
nnoremap <Up>   gk
nnoremap h <Left>
nnoremap l <Right>
" open folding in "l"
nnoremap <expr> l foldlevel(line('.')) ? "\<Right>zo" : "\<Right>"
" for buffer
nnoremap gh :bp<CR>
nnoremap gl :bn<CR>
" for tab
nnoremap <SID>[tab-right] gt
nnoremap <SID>[tab-left] gT
nmap <C-l> <SID>[tab-right]
nmap <C-h> <SID>[tab-left]

nmap <Space> [Space]
nnoremap [Space] <Nop>

nnoremap [Space]s :<C-u>split<CR>
nnoremap [Space]v :<C-u>vsplit<CR>

" like emacs
cnoremap <C-b> <Left>
cnoremap <C-f> <Right>
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
cnoremap <C-d> <Del>
cnoremap <C-y> <C-r>

" mapping for NeoBundle
nnoremap [Space]bi :<C-u>NeoBundleInstall!<CR>
" Vim-users.jp - Hack #74: http://vim-users.jp/2009/09/hack74/
nnoremap <silent> [Space]ev  :<C-u>tabedit $MYVIMRC<CR>
nnoremap <silent> [Space]eg  :<C-u>tabedit $MYGVIMRC<CR>

" cmdwin
nnoremap : q:i
vnoremap : q:i

" hilight over 100 column {{{
" http://blog.remora.cx/2013/06/source-in-80-columns-2.html
noremap <Plug>(ToggleColorColumn)
            \ :<c-u>let &colorcolumn = len(&colorcolumn) > 0 ? '' :
            \   join(range(101, 9999), ',')<CR>

nmap cc <Plug>(ToggleColorColumn)"}}}
"===================================================================================}}}

"{{{ ========== Plugin Settings =======================================================
if neobundle#tap('lightline.vim')"{{{
    if s:is_windows
        let g:lightline = {
                    \ 'colorscheme': 'landscape',
                    \ 'mode_map': { 'c': 'NORMAL' },
                    \ 'active': {
                    \   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename', 'anzu' ] ]
                    \ },
                    \ 'component_function': {
                    \   'modified': 'MyModified',
                    \   'readonly': 'MyReadonly',
                    \   'fugitive': 'MyFugitive',
                    \   'filename': 'MyFilename',
                    \   'fileformat': 'MyFileformat',
                    \   'filetype': 'MyFiletype',
                    \   'fileencoding': 'MyFileencoding',
                    \   'mode': 'MyMode',
                    \   'anzu': 'anzu#search_status'
                    \ }
                    \ }
    else
        let g:lightline = {
                    \ 'colorscheme': 'solarized',
                    \ 'mode_map': { 'c': 'NORMAL' },
                    \ 'active': {
                    \   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename', 'anzu' ] ]
                    \ },
                    \ 'component_function': {
                    \   'modified': 'MyModified',
                    \   'readonly': 'MyReadonly',
                    \   'fugitive': 'MyFugitive',
                    \   'filename': 'MyFilename',
                    \   'fileformat': 'MyFileformat',
                    \   'filetype': 'MyFiletype',
                    \   'fileencoding': 'MyFileencoding',
                    \   'mode': 'MyMode',
                    \   'anzu': 'anzu#search_status'
                    \ },
                    \ 'separator': { 'left': '⮀', 'right': '⮂' },
                    \ 'subseparator': { 'left': '⮁', 'right': '⮃' }
                    \ }
    endif
    function! MyModified()"{{{
        return &ft =~ 'help\|vimfiler\|gundo' ? '' : &modified ? '+' : &modifiable ? '' : '-'
    endfunction"}}}

    function! MyReadonly()"{{{
        if s:is_windows
            return &ft !~? 'help\|vimfiler\|gundo' && &readonly ? 'R' : ''
        else
            return &ft !~? 'help\|vimfiler\|gundo' && &readonly ? '⭤' : ''
        endif
    endfunction"}}}

    function! MyFilename()"{{{
        return ('' != MyReadonly() ? MyReadonly() . ' ' : '') .
                    \ (&ft == 'vimfiler' ? vimfiler#get_status_string() :
                    \  &ft == 'unite' ? unite#get_status_string() :
                    \  &ft == 'vimshell' ? vimshell#get_status_string() :
                    \ '' != expand('%:t') ? expand('%:t') : '[No Name]') .
                    \ ('' != MyModified() ? ' ' . MyModified() : '')
    endfunction"}}}

    function! MyFugitive()"{{{
        if &ft !~? 'vimfiler\|gundo' && exists("*fugitive#head")
            let _ = fugitive#head()
            if s:is_windows
                return strlen(_) ? '| '._ : ''
            else
                return strlen(_) ? '⭠ '._ : ''
            endif
        endif
        return ''
    endfunction"}}}

    function! MyFileformat()"{{{
        return winwidth('.') > 70 ? &fileformat : ''
    endfunction"}}}

    function! MyFiletype()"{{{
        return winwidth('.') > 70 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
    endfunction"}}}

    function! MyFileencoding()"{{{
        return winwidth('.') > 70 ? (strlen(&fenc) ? &fenc : &enc) : ''
    endfunction"}}}

    function! MyMode()"{{{
        return winwidth('.') > 60 ? lightline#mode() : ''
    endfunction"}}}

    call neobundle#untap()
endif"}}}

if neobundle#tap('vim-gitgutter')"{{{
    let g:gitgutter_sign_added = '✚'
    let g:gitgutter_sign_modified = '➜'
    let g:gitgutter_sign_removed = '✘'

    call neobundle#untap()
endif"}}}

if neobundle#tap('vim-submode')"{{{
    let g:submode_leave_with_key = 1
    call submode#enter_with('winsize', 'n', '', '<C-w>>', '<C-w>>')
    call submode#enter_with('winsize', 'n', '', '<C-w><', '<C-w><')
    call submode#enter_with('winsize', 'n', '', '<C-w>+', '<C-w>-')
    call submode#enter_with('winsize', 'n', '', '<C-w>-', '<C-w>+')
    call submode#map('winsize', 'n', '', '>', '<C-w>>')
    call submode#map('winsize', 'n', '', '<', '<C-w><')
    call submode#map('winsize', 'n', '', '+', '<C-w>-')
    call submode#map('winsize', 'n', '', '-', '<C-w>+')

    call neobundle#untap()
endif"}}}

if neobundle#tap('vim-anzu')"{{{
    au MyAutoCmd BufEnter,BufLeave,BufWinEnter,BufWinLeave,WinEnter,CmdwinLeave * nnoremap <ESC><ESC> :<C-u>nohlsearch<CR>
    "nmap n <Plug>(anzu-mode-n)
    "nmap N <Plug>(anzu-mode-N)
    "nnoremap <expr> n anzu#mode#mapexpr("n", "", "zzzv")
    "nnoremap <expr> N anzu#mode#mapexpr("N", "", "zzzv")
    nmap n <Plug>(anzu-n)zzzv
    nmap N <Plug>(anzu-N)zzzv
    nmap * <Plug>(anzu-star)zzzv
    nmap # <Plug>(anzu-sharp)zzzv

    call neobundle#untap()
endif"}}}

if neobundle#tap('TweetVim')"{{{
    call neobundle#config({
                \ 'autoload': {
                \   'commands': ['TweetVimVersion',
                \                'TweetVimAddAccount',
                \                'TweetVimSwitchAccount',
                \                'TweetVimHomeTimeline',
                \                'TweetVimMentions',
                \                'TweetVimListStatuses',
                \                'TweetVimUserTimeline',
                \                'TweetVimSay',
                \                'TweetVimUserStream',
                \                'TweetVimCommandSay',
                \                'TweetVimCurrentLineSay',
                \                'TweetVimSearch'],
                \   'unite_sources': ['tweetvim/account', 'tweetvim']
                \ }
                \ })

    au MyAutoCmd FileType tweetvim call s:my_tweetvim_mappings()
    nnoremap [Space]ut :<C-u>Unite tweetvim<CR>
    nnoremap [Space]us :<C-u>TweetVimUserStream<CR>

    function! s:my_tweetvim_mappings()
        setl nowrap
        nnoremap <buffer> [Space]s :<C-u>TweetVimSay<CR>
        nnoremap <buffer> <leader>s :<C-u>TweetVimSearch<Space>
        nnoremap <buffer> [Space]tl :<C-u>Unite tweetvim<CR>
        nnoremap <buffer> [Space]ta :<C-u>Unite tweetvim/account<CR>
    endfunction

    let g:tweetvim_default_account = "r_y_y_k_m"
    let g:tweetvim_tweet_per_page = 200
    let g:tweetvim_cache_size = 50
    let g:tweetvim_display_source = 1
    let g:tweetvim_display_time = 1

    call neobundle#untap()
endif"}}}

if neobundle#tap('vim-indent-guides')"{{{
    let g:indent_guides_enable_on_vim_startup = 1
    let g:indent_guides_guide_size = 1
    let g:indent_guides_auto_colors = 1
    let g:indent_guides_start_level = 2
    let g:indent_guides_exclude_filetypes = ['help', 'nerdtree', 'calendar', 'thumbnail']

    call neobundle#untap()
endif"}}}

if neobundle#tap('vimfiler.vim')"{{{
    call neobundle#config({
                \ 'autoload': {
                \   'unite_sources': ['vimfiler_drive', 'vimfiler_execute', 'vimfiler_history',
                \                     'vimfiler_mask', 'vimfiler_popd', 'vimfiler_sort'],
                \   'mappings': ['n', '<Plug>(vimfiler_'],
                \   'commands': [{'complete': 'customlist,vimfiler#complete', 'name': 'Read'},
                \                {'complete': 'customlist,vimfiler#complete', 'name': 'VimFiler'},
                \                {'complete': 'customlist,vimfiler#complete', 'name': 'Edit'},
                \                {'complete': 'customlist,vimfiler#complete', 'name': 'VimFilerExplorer'},
                \                {'complete': 'customlist,vimfiler#complete', 'name': 'VimFilerSplit'},
                \                {'complete': 'customlist,vimfiler#complete', 'name': 'Write'},
                \                {'complete': 'customlist,vimfiler#complete', 'name': 'VimFilerDouble'},
                \                {'complete': 'customlist,vimfiler#complete', 'name': 'Source'}]
                \ }
                \ })

    nnoremap <Leader>f :<C-u>VimFiler -split -simple -toggle -winwidth=35 -no-quit<CR>
    nnoremap <C-e> :<C-u>VimFilerDouble<CR>
    nnoremap <expr><Leader>g <SID>git_root_dir()
    function! s:git_root_dir()
        " http://qiita.com/items/39134f75e9360e1e733d
        if(system('git rev-parse --is-inside-work-tree') == "true\n")
            return ':VimFiler ' . '-split ' . '-simple ' . '-winwidth=35 ' . '-no-quit '
                        \ . system('git rev-parse --show-cdup') . '\<CR>'
        else
            echoerr '!!!current directory is outside git working tree!!!'
        endif
    endfunction
    function! neobundle#tapped.hooks.on_source(bundle)
        let g:vimfiler_as_default_explorer = 1
        let g:vimfiler_enable_auto_cd = 1
        if s:is_windows
            let g:unite_kind_file_use_trashbox = 1
        endif
    endfunction
    call neobundle#untap()
endif"}}}

if neobundle#tap('vimshell.vim')"{{{
    call neobundle#config({
                \ 'autoload': {
                \   'mappings': ['n', '<Plug>(vimshell_'],
                \   'commands': ['VimShell', 'VimShellPop']
                \ }
                \ })
    function! neobundle#tapped.hooks.on_source(bundle)
        " PATH
        if has('unix')
            " home bin
            let $PATH = $PATH . ':' . $HOME . '/bin:' . $HOME . '/bin/scripts'
            " homebrew
            let $PATH = '/usr/local/bin:' . $PATH
        endif

        let g:vimshell_right_prompt = 'vcs#info("(%s)-[%b]", "(%s)-[%b|%a]")'
        let g:vimshell_enable_smart_case = 1

        let g:vimshell_execute_file_list['zip'] = 'zipinfo'
        call vimshell#set_execute_file('tgz,gz', 'gzcat')
        call vimshell#set_execute_file('tbz,bz2', 'bzcat')

        let g:vimshell_execute_file_list = {}
        call vimshell#set_execute_file('txt,vim,c,h,cpp,d,xml,java', 'vim')
        let g:vimshell_execute_file_list['rb'] = 'ruby'
        let g:vimshell_execute_file_list['pl'] = 'perl'
        let g:vimshell_execute_file_list['py'] = 'python'
        call vimshell#set_execute_file('html,xhtml', 'gexe firefox')

        au MyAutoCmd FileType vimshell
                    \ if ! s:is_windows
                    \| call vimshell#altercmd#define('i', 'iexe')
                    \| call vimshell#altercmd#define('ll', 'ls -l')
                    \| call vimshell#altercmd#define('la', 'ls -a')
                    \| call vimshell#altercmd#define('lla', 'ls -al')
                    \| call vimshell#altercmd#define('lv', 'vim -R')
                    \| call vimshell#altercmd#define('vimfiler', 'vim -c VimFilerDouble')
                    \| call vimshell#altercmd#define('rm', 'rmtrash')
                    \| call vimshell#altercmd#define('s', ':UniteBookmarkAdd .')
                    \| call vimshell#altercmd#define('g', ':Unite bookmark -start-insert')
                    \| call vimshell#altercmd#define('l', ':Unite bookmark')
                    \| call vimshell#hook#add('chpwd', 'my_chpwd', 'g:my_chpwd')
                    \| else
                        \| call vimshell#altercmd#define('vimfiler', 'gvim -c VimFilerDouble')
                        \| endif


        function! g:my_chpwd(args, context)
            call vimshell#execute('ls')
        endfunction

        au MyAutoCmd FileType int-* call s:interactive_settings()
        function! s:interactive_settings()
        endfunction

        " history
        let g:vimshell_max_command_history = 5000000
        " mapping
        "nnoremap [Space]s :<C-u>VimShell<CR>
        au MyAutoCmd FileType vimshell inoremap <C-^> cd<Space>../<CR>
        au MyAutoCmd FileType vimshell imap <C-l> <Plug>(vimshell_clear)
    endfunction
    call neobundle#untap()
endif"}}}

if neobundle#tap('vimshell-pure.vim')"{{{
    call neobundle#config({
                \ 'autoload': {
                \   'on_source': ['vimshell.vim']
                \ }
                \ })
    call neobundle#untap()
endif"}}}

if neobundle#tap('neocomplete.vim')"{{{
    call neobundle#config({
                \ 'autoload': {
                \   'insert': 1
                \ }
                \ })
    function! neobundle#tapped.hooks.on_source(bundle)
        let g:neocomplete#enable_at_startup = 1
        let g:neocomplete#enable_smart_case = 1
        let g:neocomplete#sources#syntax#min_keyword_length = 3
        " Define dictionary.
        let g:neocomplete#sources#dictionary#dictionaries = {
                    \ 'default': '',
                    \ 'vimshell': $HOME . '/.vimshell_hist',
                    \ 'scheme': $HOME . '/.gosh_completions',
                    \ 'coffee': $MY_VIMRUNTIME . '/dict/coffee.dict',
                    \ 'vbs': $MY_VIMRUNTIME . '/dict/vbs.dict',
                    \ 'dosbatch': $MY_VIMRUNTIME . '/dict/dosbatch.dict',
                    \ 'scala': $MY_VIMRUNTIME . '/dict/scala.dict',
                    \ 'ps1': $MY_VIMRUNTIME . '/dict/ps1.dict',
                    \ 'javascript': $MY_VIMRUNTIME . '/dict/wsh.dict'
                    \ }
    endfunction
    call neobundle#untap()
endif"}}}

if neobundle#tap('neosnippet.vim')"{{{
    call neobundle#config({
                \ 'autoload': {
                \   'insert': 1,
                \   'unite_sources': ['neosnippet_file', 'snippet', 'snippet_target'],
                \   'mappings': ['sxi', '<Plug>(neosnippet_'],
                \   'commands': ['NeoSnippetEdit', 'NeoSnippetSource']
                \ }
                \ })

    " Plugin key-mappings.
    imap <C-k>     <Plug>(neosnippet_expand_or_jump)
    smap <C-k>     <Plug>(neosnippet_expand_or_jump)
    xmap <C-k>     <Plug>(neosnippet_expand_target)
    function! neobundle#tapped.hooks.on_source(bundle)
        " Tell Neosnippet about the other snippets
        let g:neosnippet#snippets_directory = $HOME . '/.snippets,'

        " For snippet_complete marker.
        if has('conceal')
            set conceallevel=2 concealcursor=i
        endif

        " for unite
        imap <C-s> <Plug>(neocomplcache_start_unite_snippet)
    endfunction
    call neobundle#untap()
endif"}}}

if neobundle#tap('unite.vim')"{{{
    call neobundle#config({
                \ 'autoload': {
                \   'unite_sources': ['action', 'alias', 'bookmark', 'buffer', 'change', 'command',
                \                     'directory', 'file', 'file_point', 'find', 'function', 'grep',
                \                     'history_input', 'history_yank', 'jump', 'jump_point',
                \                     'launcher', 'line', 'mapping', 'menu', 'mru', 'output',
                \                     'process', 'rec', 'register', 'resume', 'runtimepath',
                \                     'source', 'tab', 'undo', 'vimgrep', 'window'],
                \   'commands': [{'complete': 'customlist,unite#complete#source', 'name': 'UniteWithCurrentDir'},
                \                {'complete': 'customlist,unite#complete#source', 'name': 'Unite'},
                \                {'complete': 'customlist,unite#complete#source', 'name': 'UniteWithInputDirectory'},
                \                {'complete': 'customlist,unite#complete#buffer_name', 'name': 'UniteClose'},
                \                {'complete': 'file', 'name': 'UniteBookmarkAdd'},
                \                {'complete': 'customlist,unite#complete#buffer_name', 'name': 'UniteResume'},
                \                {'complete': 'customlist,unite#complete#source', 'name': 'UniteWithBufferDir'},
                \                {'complete': 'customlist,unite#complete#source', 'name': 'UniteWithCursorWord'},
                \                {'complete': 'customlist,unite#complete#source', 'name': 'UniteWithInput'},
                \                'UniteStartup']
                \ }
                \ })
    nnoremap <silent> [Space]uc :<C-u>Unite colorscheme -auto-preview<CR>
    nnoremap <silent> [Space]uy :<C-u>Unite -no-split history/yank -buffer-name=history/yank<CR>
    nnoremap <silent> [Space]ub :<C-u>Unite -no-split buffer -auto-preview -buffer-name=buffer<CR>
    nnoremap <silent> [Space]uf :<C-u>Unite -no-split -buffer-name=files file_rec<CR>
    "nnoremap <silent> [Space]uf :<C-u>Unite -no-split -buffer-name=file_rec/async file_rec/async<CR>
    nnoremap <silent> ,ub :<C-u>Unite -no-split -buffer-name=bookmark -default-action=cd bookmark<CR>
    nnoremap <silent> [Space]ug :<C-u>Unite -buffer-name=grep -no-quit -auto-preview grep<CR>
    nnoremap <silent> [Space]uo :<C-u>Unite -buffer-name=outline outline<CR>
    nnoremap <silent> [Space]uq :<C-u>Unite -buffer-name=QuickFix -no-quit qf<CR>
    nnoremap <silent> [Space]ur :<C-u>Unite -buffer-name=register register<CR>
    nnoremap <silent> [Space]um :<C-u>Unite -no-split file_mru -buffer-name=file_mru -auto-preview<CR>
    nnoremap <silent> [Space]uu :<C-u>Unite -no-split buffer file_mru<CR>
    nnoremap <silent> [Space]ua :<C-u>Unite -no-split -buffer-name=files buffer
                \                              file_mru bookmark file file_rec/async<CR>
    "nnoremap <silent> [Space]/ :<C-u>Unite -buffer-name=search line/fast -no-quit<CR>
    nnoremap <silent> [Space]uh :<C-u>Unite -no-split -buffer-name=help help<CR>

    " NeoBundle
    nnoremap [Space]ui :<C-u>Unite -no-split -no-start-insert -buffer-name=neobundle neobundle/update<CR>
    nnoremap [Space]bs :<C-u>Unite -no-split -buffer-name=neobundle/search neobundle/search<CR>
    " grep ~/.vim_junk
    nnoremap [Space]ujg :<C-u>Unite -no-split -buffer-name=Grep_JunkFile grep:~/.vim_junk/

    " http://d.hatena.ne.jp/osyo-manga/20131217/1387292034"{{{
    let g:unite_source_alias_aliases = {
                \ "startup_file_mru": {
                \   "source": "file_mru"
                \ },
                \ "startup_directory_mru": {
                \   "source": "directory_mru"
                \ }
                \}

    call unite#custom_max_candidates("startup_file_mru", 10)
    call unite#custom_max_candidates("startup_directory_mru", 10)

    if !exists("g:unite_source_menu_menus")
        let g:unite_source_menu_menus = {}
    endif
    let g:unite_source_menu_menus.startup = {
                \ "description": "startup menu",
                \   "command_candidates": [
                \       ["vimrc",  "edit " . $MYVIMRC],
                \       ["gvimrc", "edit " . $MYGVIMRC],
                \       ["unite-file_mru", "Unite file_mru"],
                \       ["unite-directory_mru", "Unite directory_mru"],
                \   ]
                \ }
    command! UniteStartup
                \ Unite
                \ output:echo:"===:file:mru:===":! startup_file_mru
                \ output:echo:":":!
                \ output:echo:"===:directory:mru:===":! startup_directory_mru
                \ output:echo:":":!
                \ output:echo:"===:menu:===":! menu:startup
                \ -hide-source-names
                \ -no-split
                \ -quick-match
    "autocmd MyAutoCmd VimEnter * :UniteStartup
"}}}

    function! neobundle#tapped.hooks.on_source(bundle)
        " start unite in insert mode
        let g:unite_enable_start_insert = 1
        " use vimfiler to open directory
        call unite#custom#default_action("source/bookmark/directory", "vimfiler")
        call unite#custom#default_action("directory", "vimfiler")
        call unite#custom#default_action("directory_mru", "vimfiler")
        "call unite#custom#default_action("file", "tabdrop")
        au MyAutoCmd FileType unite call s:unite_settings()
        function! s:unite_settings()
            silent! nunmap <ESC><ESC>
            nmap <buffer> <Esc> <Plug>(unite_exit)
            nmap <buffer> <C-n> <Plug>(unite_select_next_line)
            nmap <buffer> <C-p> <Plug>(unite_select_previous_line)
            "let g:unite_enable_split_vertically = 1
            let g:unite_source_file_mru_limit = 1000
            let g:unite_source_history_yank_enable = 1
            " grep source setting
            if s:is_windows
                "let g:unite_source_grep_command = 'grep'
                "let g:unite_source_grep_default_opts = '--color'
                let g:unite_source_grep_max_candidates = 200
            else
                let g:unite_source_grep_command = 'ag'
                let g:unite_source_grep_default_opts = '--nocolor --nogroup'
                let g:unite_source_grep_recursive_opt = ''
                let g:unite_source_grep_max_candidates = 200
            endif
        endfunction
    endfunction
    call neobundle#untap()
endif"}}}

if neobundle#tap('unite-help')"{{{
    call neobundle#config({
                \ 'autoload': {
                \   'unite_sources': ['help']
                \ }
                \ })
    call neobundle#untap()
endif"}}}

if neobundle#tap('unite-colorscheme')"{{{
    call neobundle#config({
                \ 'autoload': {
                \   'unite_sources': ['colorscheme']
                \ }
                \ })

    call neobundle#untap()
endif"}}}

if neobundle#tap('open-browser.vim')"{{{
    call neobundle#config({
                \ 'autoload': {
                \   'mappings': ['sxn', '<Plug>(openbrowser-'],
                \   'commands': ['OpenBrowser', 'OpenBrowserSearch', 'OpenBrowserSmartSearch']
                \ }
                \ })
    function! neobundle#tapped.hooks.on_source(bundle)
        " http://vim-users.jp/2011/08/hack225/
        nmap gx <Plug>(openbrowser-smart-search)
        vmap gx <Plug>(openbrowser-smart-search)
    endfunction
    call neobundle#untap()
endif"}}}

if neobundle#tap('sonictemplate-vim')"{{{
    call neobundle#config({
                \ 'autoload': {
                \   'unite_sources': ['sonictemplate'],
                \   'mappings': [['in', '<Plug>(sonictemplate']],
                \   'commands': ['Template']
                \ }
                \ })
    au MyAutoCmd BufNewFile *.rb Template template
    au MyAutoCmd BufNewFile *.ps1 Template template
    au MyAutoCmd BufNewFile *.cmd Template template
    function! neobundle#tapped.hooks.on_source(bundle)
        let g:sonictemplate_vim_template_dir = $MY_VIMRUNTIME . '/template'
    endfunction
endif"}}}

if neobundle#tap('vim-fugitive') "{{{
    nnoremap [Space]gd :<C-u>Gdiff<Enter>
    nnoremap [Space]gs :<C-u>Gstatus<Enter>
    nnoremap [Space]gl :<C-u>Glog<Enter>
    nnoremap [Space]ga :<C-u>Gwrite<Enter>
    nnoremap [Space]gc :<C-u>Gcommit<Enter>
    nnoremap [Space]gC :<C-u>Git commit --amend<Enter>
    nnoremap [Space]gp :<C-u>Git pull --rebase<Enter>
    nnoremap [Space]gb :<C-u>Gblame<Enter>

    call neobundle#untap()
endif"}}}

if neobundle#tap('vim-quickrun')"{{{
    call neobundle#config({
                \ 'autoload': {
                \   'mappings': ['sxn', '<Plug>(quickrun'],
                \   'commands': {'complete': 'customlist,quickrun#complete', 'name': 'QuickRun'}
                \ }
                \ })
    "nnoremap <Leader>r <Plug>(quickrun)
    " echo quickrun command output {{{
    " http://d.hatena.ne.jp/osyo-manga/searchdiary?word=quickrun
    let s:hook = {
                \   "name": "output_command",
                \   "kind": "hook",
                \   "config": {
                \       "enable": 0,
                \       "log": 0
                \   }
                \ }

    function! s:hook.on_ready(session, context)
        HierClear
        for command in a:session.commands
            execute self.config.log ? "echom command" : "echo command"
        endfor
    endfunction

    call quickrun#module#register(s:hook, 1)
    unlet s:hook"}}}

    " TypeScript compile according to the reference path {{{
    let s:hook = {
                \ "name": "typescript_compile",
                \ "kind": "hook",
                \ "config": {
                \       "enable": 0
                \  }
                \ }
    function! s:hook.on_module_loaded(session, context)
        let references = []
        for line in readfile(a:session.config.srcfile, '', 15)
            if line =~ '^///<reference path='
                "echom 'reference : ' . line[stridx(line, '"') + 1 : -4]
                if line[stridx(line, '"') + 1 : -4] !~ 'lib.d.ts'
                    call add(references, line[stridx(line, '"') + 1 : -4])
                endif
            endif
        endfor
        "echom 'exec : %c --nolib %s ' . join(references, ' ') . ' --out %s:p:r.js'
        let a:session.config.exec = '%c --nolib %s ' . join(references, ' ') . ' --out %s:p:r.js'
    endfunction
    call quickrun#module#register(s:hook, 1)
    unlet s:hook"}}}

    " coffeescript compile {{{
    let s:hook = {
                \ "name": "coffeescript_compile",
                \ "kind": "hook",
                \ "config": {
                \       "enable": 0
                \  }
                \ }
    function! s:hook.on_module_loaded(session, context)
        let imports = []
        for line in readfile(a:session.config.srcfile, '', 15)
            if line =~ '^# import'
                "echom 'import : ' . line[10 : -2]
                call add(imports, line[10 : -2])
            endif
        endfor
        "echom 'exec : %c -j %s:p:r.js -cb ' . join(imports, ' ') . ' %s'
        let a:session.config.exec = '%c -j %s:p:r.js -cb ' . join(imports, ' ') . ' %s'
    endfunction
    call quickrun#module#register(s:hook, 1)
    unlet s:hook"}}}

    " add wsh header {{{
    let s:hook = {
                \ "name": "js2cmd",
                \ "kind": "hook",
                \ "config": {
                \       "enable": 0
                \  }
                \ }
    function! s:hook.on_success(session, context)
        let list = []
        call add(list, "@if(0)==(0) ECHO OFF")
        for line in readfile(a:session.config.srcfile, '', 10)
            if line =~ '^//' || line =~ '^#'
                if line[3 : 4] =~ 'OP' || line[2 : 3] =~ 'OP'
                    "echom 'option : ' . line[stridx(line, '"') + 1 : -2]
                    if line[stridx(line, '"') + 1 : -2] =~ '^pushd'
                        call add(list, "    pushd \"%~dp0\" > nul")
                        call add(list, "    CScript.exe //NoLogo //E:JScript \"%~f0\" %*")
                        call add(list, "    popd > nul")
                        break
                    else
                        call add(list, "    CScript.exe //NoLogo //E:JScript \"%~f0\" %*")
                        break
                    endif
                endif
            endif
        endfor
        call add(list, "pause")
        call add(list, "GOTO :EOF")
        call add(list, "@end")
        call add(list, "")
        let inJs = fnamemodify(a:session.config.srcfile, ":p:r") . '.js'
        let outCmd = fnamemodify(a:session.config.srcfile, ":p:h") . '/_cmd/'
                    \ . fnamemodify(a:session.config.srcfile, ":t:r") .'.cmd'
        "echom inJs
        "echom outCmd
        let utf8List = list + readfile(inJs, 'b')
        let cp932List = []
        for line in utf8List
            "call add(cp932List, iconv(line, "UTF-8", "CP932"))
            call add(cp932List, iconv(substitute(line, "\n", "\r\n", "",), "UTF-8", "CP932"))
        endfor
        if isdirectory(fnamemodify(a:session.config.srcfile, ":p:h") . '/_cmd')
            call writefile(cp932List, outCmd, 'b')
            if has('win32') || has('win64')
                "call {s:system}('del ' . inJs)
                call {s:system}('unix2dos ' . outCmd)
            else
                "call {s:system}('rm ' . inJs)
                call {s:system}('nkf --windows --overwrite ' . outCmd)
            endif
        else
            echom fnamemodify(a:session.config.srcfile, ":p:h") . '/_cmd' . 'is not found !'
        endif
    endfunction

    call quickrun#module#register(s:hook, 1)
    unlet s:hook"}}}

    let g:quickrun_config = {}
    let g:quickrun_config = {
                \   "_": {
                \       "hook/output_command/enable": 1,
                \       "hook/output_command/log": 1,
                \       "hook/close_unite_quickfix/enable_hook_loaded": 1,
                \       "hook/unite_quickfix/enable_failure": 1,
                \       "hook/close_quickfix/enable_exit": 1,
                \       "hook/close_buffer/enable_failure": 1,
                \       "hook/close_buffer/enable_empty_data": 1,
                \       "hook/echo/enable": 1,
                \       "hook/echo/output_success": "success!!!",
                \       "hook/echo/output_failure": "failure...",
                \       "outputter": "multi:buffer:quickfix",
                \       "outputter/buffer/split": ":botright 18sp",
                \       "runner": "vimproc",
                \       "runner/vimproc/updatetime": 40
                \   },
                \ "typescript": {
                \       "commad": "tsc",
                \       "cmdopt": "--nolib --out",
                \       "exec"  : "%c %s _lib.ts %o %s:p:r.js",
                \       "hook/typescript_compile/enable": 1,
                \       "hook/js2cmd/enable": 1,
                \       "hook/output_command/log": 1
                \   },
                \ "plantuml": {
                \       "command": "java",
                \       "cmdopt": "-jar plantuml.jar -tpng",
                \       "exec": "%c %o %s"
                \   },
                \ "blockdiag": {
                \       "command": "blockdiag",
                \       "cmdopt": "-Tsvg",
                \       "exec": "%c %o %s"
                \   },
                \ "rst": {
                \       "command": "make",
                \       "cmdopt": "html",
                \       "exec": "%c %o"
                \ },
                \ "ps1": {
                \       'command': 'powershell.exe',
                \       'cmdopt': '-executionPolicy RemoteSigned',
                \       'tempfile': '%{tempname()}.ps1',
                \       'exec': '%c %o -F %s:p'
                \ }
                \ }
    call neobundle#untap()
endif"}}}

if neobundle#tap('shabadou.vim')"{{{
    call neobundle#config({
                \ 'autoload': {
                \   'on_source': ['vim-quickrun'],
                \   'mappings': ['sxn', '<Plug>(quickrun'],
                \   'commands': {'complete': 'customlist,quickrun#complete', 'name': 'QuickRun'}
                \ }
                \ })
    call neobundle#untap()
endif"}}}

if neobundle#tap('vim-coffee-script')"{{{
    call neobundle#config({
                \ 'autoload': {
                \   'filetypes': ['coffee'],
                \   'commands': ['CoffeeCompile', 'CoffeeWatch', 'CoffeeRun', 'CoffeeLint']
                \ }
                \ })
    function! neobundle#tapped.hooks.on_source(bundle)
        let coffee_compile_vert = 1
        let coffee_make_options = '--bare'
    endfunction
    call neobundle#untap()
endif"}}}

if neobundle#tap('jedi-vim')"{{{
    call neobundle#config({
                \ 'autoload': {
                \   'commands': [{'complete': 'custom,jedi#py_import_completions', 'name': 'Pyimport'},
                \                'Python'],
                \   'filetypes': ['python', 'python3']
                \ }
                \ })
    function! neobundle#tapped.hooks.on_source(bundle)
        let g:jedi#auto_initialization = 1
        let g:jedi#auto_vim_configuration = 0
        let g:jedi#goto_assignments_command = '<Leader>G'
        let g:jedi#popup_select_first = 0
        let g:jedi#rename_command = '<Leader>R'
        let g:jedi#show_call_signatures = 1
        "let g:jedi#popup_on_dot = 1
        au MyAutoCmd FileType python let b:did_ftplugin = 1
    endfunction
    call neobundle#untap()
endif"}}}

if neobundle#tap('ag.vim')"{{{
    call neobundle#config({
                \ 'autoload': {
                \   'commands': [{'complete': 'file', 'name': 'AgFromSearch'},
                \                {'complete': 'help', 'name': 'LAgHelp'},
                \                {'complete': 'file', 'name': 'LAg'},
                \                {'complete': 'file', 'name': 'LAgAdd'},
                \                {'complete': 'file', 'name': 'AgFile'},
                \                {'complete': 'file', 'name': 'AgAdd'},
                \                {'complete': 'file', 'name': 'Ag'},
                \                {'complete': 'help', 'name': 'AgHelp'}],
                \   'unite_sources': 'grep'
                \ }
                \ })

    call neobundle#untap()
endif"}}}

if neobundle#tap('vim-ref')"{{{
    call neobundle#config({
                \ 'autoload': {
                \   'unite_sources': ['ref'],
                \   'mappings': ['sxn', '<Plug>(ref-keyword)'],
                \   'commands': [{'complete': 'customlist,ref#complete', 'name': 'Ref'},
                \                'RefHistory']
                \ }
                \ })

    function! s:unite_ref_doc()
        if &filetype =~ 'perl'
            Unite ref/perldoc
        elseif &filetype =~ 'python'
            Unite -start-insert ref/pydoc
        elseif &filetype =~ 'ruby'
            Unite ref/refe
        else
            Unite ref/man
        endif
    endfunction
    nnoremap [Space]r :<C-u>call s:unite_ref_doc()<CR>
    call neobundle#untap()
endif"}}}

if neobundle#tap('tagbar')"{{{
    call neobundle#config({
                \ 'autoload': {
                \   'commands': ['TagbarGetTypeConfig', 'TagbarSetFoldlevel', 'TagbarOpen',
                \                'TagbarDebug', 'Tagbar', 'TagbarClose', 'TagbarTogglePause',
                \                'TagbarOpenAutoClose', 'TagbarDebugEnd', 'TagbarCurrentTag',
                \                'TagbarShowTag', 'TagbarToggle']
                \ }
                \ })

    nnoremap <Leader>t :<C-u>TagbarToggle<CR>
    function! neobundle#tapped.hooks.on_source(bundle)
        let g:tagbar_type_scala = {
                    \ 'ctagstype': 'Scala',
                    \ 'kinds': [
                    \   'p:packages:1',
                    \   'V:values',
                    \   'v:variables',
                    \   'T:types',
                    \   't:traits',
                    \   'o:objects',
                    \   'a:aclasses',
                    \   'c:classes',
                    \   'r:cclasses',
                    \   'm:methods'
                    \ ]
                    \ }
        let g:tagbar_type_ruby = {
                    \ 'kinds': [
                    \   'm:modules',
                    \   'c:classes',
                    \   'd:describes',
                    \   'C:contexts',
                    \   'f:methods',
                    \   'F:singleton methods'
                    \ ]
                    \ }
        let g:tagbar_type_markdown = {
                    \ 'ctagstype': 'markdown',
                    \ 'kinds': [
                    \   'h:Heading_L1',
                    \   'i:Heading_L2',
                    \   'k:Heading_L3'
                    \ ]
                    \ }
        let g:tagbar_type_css = {
                    \ 'ctagstype': 'Css',
                    \ 'kinds': [
                    \   'c:classes',
                    \   's:selectors',
                    \   'i:identities'
                    \ ]
                    \ }
        if executable('coffeetags')
            let g:tagbar_type_coffee = {
                        \ 'ctagsbin': 'coffeetags',
                        \ 'ctagsargs': '',
                        \ 'kinds': [
                        \   'f:functions',
                        \   'o:object',
                        \ ],
                        \ 'sro': ".",
                        \ 'kind2scope' : {
                        \   'f': 'object',
                        \   'o': 'object',
                        \ }
                        \ }
        endif

        " Posix regular expressions for matching interesting items. Since this will
        " be passed as an environment variable, no whitespace can exist in the options
        " so [:space:] is used instead of normal whitespaces.
        " Adapted from: https://gist.github.com/2901844
        let s:ctags_opts = '
                    \ --langdef=coffee
                    \ --langmap=coffee:.coffee
                    \ --regex-coffee=/(^|=[ \t])*class ([A-Za-z_][A-Za-z0-9_]+\.)*([A-Za-z_][A-Za-z0-9_]+)( extends ([A-Za-z][A-Za-z0-9_.]*)+)?$/\3/c,class/
                    \ --regex-coffee=/^[ \t]*(module\.)?(exports\.)?@?(([A-Za-z][A-Za-z0-9_.]*)+):.*[-=]>.*$/\3/m,method/
                    \ --regex-coffee=/^[ \t]*(module\.)?(exports\.)?(([A-Za-z][A-Za-z0-9_.]*)+)[ \t]*=.*[-=]>.*$/\3/f,function/
                    \ --regex-coffee=/^[ \t]*(([A-Za-z][A-Za-z0-9_.]*)+)[ \t]*=[^->\n]*$/\1/v,variable/
                    \ --regex-coffee=/^[ \t]*@(([A-Za-z][A-Za-z0-9_.]*)+)[ \t]*=[^->\n]*$/\1/f,field/
                    \ --regex-coffee=/^[ \t]*@(([A-Za-z][A-Za-z0-9_.]*)+):[^->\n]*$/\1/f,static field/
                    \ --regex-coffee=/^[ \t]*(([A-Za-z][A-Za-z0-9_.]*)+):[^->\n]*$/\1/f,field/
                    \ --regex-coffee=/((constructor|initialize):[ \t]*\()@(([A-Za-z][A-Za-z0-9_.]*)+)([ \t]*=[ \t]*[^,)]+)?/\3/f,field/
                    \ --regex-coffee=/((constructor|initialize):[ \t]*\()@(([A-Za-z][A-Za-z0-9_.]*)+)([ \t]*=[ \t]*[^,)]+)?(,[ \t]*@(([A-Za-z][A-Za-z0-9_.]*)+)([ \t]*=[ \t]*[^,)]+)?){0}/\8/f,field/
                    \ --regex-coffee=/((constructor|initialize):[ \t]*\()@(([A-Za-z][A-Za-z0-9_.]*)+)([ \t]*=[ \t]*[^,)]+)?(,[ \t]*@(([A-Za-z][A-Za-z0-9_.]*)+)([ \t]*=[ \t]*[^,)]+)?){1}/\8/f,field/
                    \ --regex-coffee=/((constructor|initialize):[ \t]*\()@(([A-Za-z][A-Za-z0-9_.]*)+)([ \t]*=[ \t]*[^,)]+)?(,[ \t]*@(([A-Za-z][A-Za-z0-9_.]*)+)([ \t]*=[ \t]*[^,)]+)?){2}/\8/f,field/
                    \ --regex-coffee=/((constructor|initialize):[ \t]*\()@(([A-Za-z][A-Za-z0-9_.]*)+)([ \t]*=[ \t]*[^,)]+)?(,[ \t]*@(([A-Za-z][A-Za-z0-9_.]*)+)([ \t]*=[ \t]*[^,)]+)?){3}/\8/f,field/
                    \ --regex-coffee=/((constructor|initialize):[ \t]*\()@(([A-Za-z][A-Za-z0-9_.]*)+)([ \t]*=[ \t]*[^,)]+)?(,[ \t]*@(([A-Za-z][A-Za-z0-9_.]*)+)([ \t]*=[ \t]*[^,)]+)?){4}/\8/f,field/
                    \ --regex-coffee=/((constructor|initialize):[ \t]*\()@(([A-Za-z][A-Za-z0-9_.]*)+)([ \t]*=[ \t]*[^,)]+)?(,[ \t]*@(([A-Za-z][A-Za-z0-9_.]*)+)([ \t]*=[ \t]*[^,)]+)?){5}/\8/f,field/
                    \ --regex-coffee=/((constructor|initialize):[ \t]*\()@(([A-Za-z][A-Za-z0-9_.]*)+)([ \t]*=[ \t]*[^,)]+)?(,[ \t]*@(([A-Za-z][A-Za-z0-9_.]*)+)([ \t]*=[ \t]*[^,)]+)?){6}/\8/f,field/
                    \ --regex-coffee=/((constructor|initialize):[ \t]*\()@(([A-Za-z][A-Za-z0-9_.]*)+)([ \t]*=[ \t]*[^,)]+)?(,[ \t]*@(([A-Za-z][A-Za-z0-9_.]*)+)([ \t]*=[ \t]*[^,)]+)?){7}/\8/f,field/
                    \ --regex-coffee=/((constructor|initialize):[ \t]*\()@(([A-Za-z][A-Za-z0-9_.]*)+)([ \t]*=[ \t]*[^,)]+)?(,[ \t]*@(([A-Za-z][A-Za-z0-9_.]*)+)([ \t]*=[ \t]*[^,)]+)?){8}/\8/f,field/
                    \ --regex-coffee=/((constructor|initialize):[ \t]*\()@(([A-Za-z][A-Za-z0-9_.]*)+)([ \t]*=[ \t]*[^,)]+)?(,[ \t]*@(([A-Za-z][A-Za-z0-9_.]*)+)([ \t]*=[ \t]*[^,)]+)?){9}/\8/f,field/'

        let $CTAGS = substitute(s:ctags_opts, '\v\([nst]\)', '\\', 'g')
    endfunction
    call neobundle#untap()
endif"}}}

if neobundle#tap('SrcExpl')"{{{
    call neobundle#config({
                \ 'autoload': {
                \   'commands': ['SrcExplToggle', 'SrcExplClose', 'SrcExpl']
                \ }
                \ })
    " The switch of the Source Explorer
    nmap <F8> :SrcExplToggle<CR>
    function! neobundle#tapped.hooks.on_source(bundle)
        "  Set the height of Source Explorer window
        let g:SrcExpl_winHeight = 8

        "  Set 100 ms for refreshing the Source Explorer
        let g:SrcExpl_refreshTime = 100

        "  Set "Enter" key to jump into the exact definition context
        let g:SrcExpl_jumpKey = "<ENTER>"

        "  Set "Space" key for back from the definition context
        let g:SrcExpl_gobackKey = "<SPACE>"

        "  In order to Avoid conflicts, the Source Explorer should know what plugins
        "  are using buffers. And you need add their bufname into the list below
        "  according to the command ":buffers!"
        let g:SrcExpl_pluginList = [
                    \ "__Tag_List__",
                    \ "Source_Explorer"
                    \ ]

        "  Enable/Disable the local definition searching, and note that this is not
        "  guaranteed to work, the Source Explorer doesn't check the syntax for now.
        "  It only searches for a match with the keyword according to command 'gd'
        let g:SrcExpl_searchLocalDef = 1

        "  Do not let the Source Explorer update the tags file when opening
        let g:SrcExpl_isUpdateTags = 0

        "  Use 'Exuberant Ctags' with '--sort=foldcase -R .' or '-L cscope.files' to
        "  create/update a tags file
        let g:SrcExpl_updateTagsCmd = "ctags --sort=foldcase -R ."

        "  Set "<F12>" key for updating the tags file artificially
        "let g:SrcExpl_updateTagsKey = "<F12>"

        "  Set "<F3>" key for displaying the previous definition in the jump list
        let g:SrcExpl_prevDefKey = "<F3>"

        "  Set "<F4>" key for displaying the next definition in the jump list
        let g:SrcExpl_nextDefKey = "<F4>"
    endfunction
    call neobundle#untap()
endif"}}}

if neobundle#tap('qfixhowm')"{{{
    " use markdown
    let howm_filename = '%Y/%m/%Y-%m-%d-%H%M%S.md'
    " filetype markdown
    let QFixHowm_FileType = 'markdown'
    let QFixHowm_Title = '#'
    let QFixMRU_Title = {}
    let QFixMRU_Title['mkd'] = '^###[^#]'
    let QFixMRU_Title['mkd_regxp'] = '^###[^#]'
    let howm_dir = $HOME . '/.howm'
    call neobundle#untap()
endif"}}}

if neobundle#tap('ctrlp.vim')"{{{
    call neobundle#config({
                \ 'autoload': {
                \   'commands': ['CtrlPMixed', 'CtrlPClearAllCaches', 'CtrlPCurWD', 'CtrlP',
                \                'CtrlPRTS', 'CtrlPBuffer', 'CtrlPMRUFiles', 'CtrlPBookmarkDirAdd',
                \                'CtrlPDir', 'CtrlPRoot', 'CtrlPChange', 'ClearCtrlPCache',
                \                'CtrlPLine', 'ClearAllCtrlPCaches', 'CtrlPBufTagAll',
                \                'CtrlPClearCache', 'CtrlPQuickfix', 'CtrlPBufTag', 'CtrlPTag',
                \                'CtrlPCurFile', 'CtrlPLastMode', 'CtrlPUndo', 'CtrlPChangeAll',
                \                'CtrlPBookmarkDir']
                \ }
                \ })

    nnoremap [Space]p :<C-u>CtrlP<CR>
    call neobundle#untap()
endif"}}}

if neobundle#tap('vim-automatic')"{{{
    " http://blog.supermomonga.com/articles/vim/automatic.html

    nnoremap <silent> <Plug>(quit) :<C-u>q<CR>
    function! s:my_temporary_window_init(config, context)
        silent! nunmap <ESC><ESC>
        nmap <buffer> <C-[> <Plug>(quit)
    endfunction

    let g:automatic_enable_autocmd_Futures = {}
    let g:automatic_default_match_config = {
                \   'is_open_other_window': 1
                \ }
    let g:automatic_default_set_config = {
                \   'height': '40%',
                \   'move': "bottom",
                \   'apply': function('s:my_temporary_window_init')
                \ }
    let g:automatic_config = [
                \   {'match': {'buftype': 'help'}},
                \   {'match': {'bufname': '^.vimshell'}},
                \   {'match': {'bufname': 'MacDict.*'}},
                \   {
                \       'match': {
                \           'autocmd_history_pattern' : 'BufWinEnterFileType$',
                \           'filetype' : 'unite'
                \       },
                \       'set': {
                \           'unsettings': ['move', 'resize']
                \       }
                \   },
                \   {
                \       'match': {
                \           'filetype': 'qf',
                \           'autocmds': ['FileType']
                \       },
                \   },
                \   {
                \       'match': {
                \           'filetype': '\v^ref-.+',
                \           'autocmds': ['FileType']
                \       }
                \   },
                \   {
                \       'match': {
                \           'bufname': '\[quickrun output\]'
                \       },
                \       'set': {
                \           'height': 8
                \       }
                \   },
                \   {
                \       'match': {
                \           'autocmds': ['CmdwinEnter']
                \       },
                \       'set': {
                \           'is_close_focus_out': 1,
                \           'unsettings': ['move', 'resize']
                \       }
                \   }
                \ ]

    call neobundle#untap()
endif"}}}

if neobundle#tap('macdict-vim')"{{{
    call neobundle#config({
                \ 'autoload': {
                \   'commands': ['MacDictThesaurus', 'MacDictFrench', 'MacDict', 'MacDictJapan',
                \                'MacDictGerman', 'MacDictClose', 'MacDictCWord', 'MacDictEnglish']
                \ }
                \ })
    if s:is_darwin
        nnoremap [Space]d :<C-u>MacDictCWord<CR>
    endif
    call neobundle#untap()
endif"}}}

if neobundle#tap('vim-golang')"{{{
    call neobundle#config({
                \ 'autoload': {
                \   'mappings': ['n', '<Plug>(godoc-keyword)'],
                \   'commands': [{'complete': 'customlist,go#complete#Package', 'name': 'Godoc'}],
                \   'filetypes': 'go'
                \ }
                \ })
    function! neobundle#tapped.hooks.on_source(bundle)
        set rtp+=$GOROOT/misc/vim
        exe "set rtp+=" . globpath($GOPATH, "src/github.com/nsf/gocode/vim")
        setl completeopt=menu,preview
        " golint
        exe "set rtp+=" . globpath($GOPATH, "src/github.com/golang/lint/misc/vim")
        au BufWritePre *.go Fmt
    endfunction
    call neobundle#untap()
endif"}}}

if neobundle#tap('ghcmod-vim')"{{{
    call neobundle#config({
                \ 'autoload': {
                \   'filetypes': 'haskell'
                \ }
                \ })
    function! neobundle#tapped.hooks.on_source(bundle)
        "au MyAutoCmd BufWritePost <buffer> GhcModCheckAsync
    endfunction

    call neobundle#untap()
endif"}}}

if neobundle#tap('yankround.vim')"{{{
    nmap p <Plug>(yankround-p)
    nmap P <Plug>(yankround-P)
    nmap <C-p> <Plug>(yankround-prev)
    nmap <C-n> <Plug>(yankround-next)
    let g:yankround_max_history = 100

    nnoremap <silent>g<C-p> :<C-u>CtrlPYankRound<CR>
    call neobundle#untap()
endif"}}}

if neobundle#tap('vim-over')"{{{
    call neobundle#config({
                \ 'autoload': {
                \   'commands': ['OverCommandLineNoremap', 'OverCommandLine']
                \ }
                \ })
    nnoremap <silent> <Leader>o :<C-u>OverCommandLine<CR>%s/
    call neobundle#untap()
endif"}}}

if neobundle#tap('nebula.vim')"{{{
    call neobundle#config({
                \ 'autoload': {
                \   'commands': ['NebulaPutLazy', 'NebulaPutFromClipboard', 'NebulaYankOptions',
                \                'NebulaPutConfig', 'NebulaYankTap']
                \ }
                \ })
    call neobundle#untap()
endif"}}}

if neobundle#tap('foldCC')"{{{
    set foldmethod=marker
    set foldtext=foldCC#foldtext()
    set foldcolumn=0
    set fillchars=vert:\|
    nnoremap <expr>l  foldclosed('.') != -1 ? 'zo' : 'l'
    nnoremap <silent><C-_> :<C-u>call <SID>smart_foldcloser()<CR>
    function! s:smart_foldcloser() "{{{
        if foldlevel('.') == 0
            norm! zM
            return
        endif

        let foldc_lnum = foldclosed('.')
        norm! zc
        if foldc_lnum == -1
            return
        endif

        if foldclosed('.') != foldc_lnum
            return
        endif
        norm! zM
    endfunction
    "}}}
    nnoremap  z[     :<C-u>call <SID>put_foldmarker(0)<CR>
    nnoremap  z]     :<C-u>call <SID>put_foldmarker(1)<CR>
    function! s:put_foldmarker(foldclose_p) "{{{
        let crrstr = getline('.')
        let padding = crrstr=='' ? '' : crrstr=~'\s$' ? '' : ' '
        let [cms_start, cms_end] = ['', '']
        let outside_a_comment_p = synIDattr(synID(line('.'), col('$')-1, 1), 'name') !~? 'comment'
        if outside_a_comment_p
            let cms_start = matchstr(&cms,'\V\s\*\zs\.\+\ze%s')
            let cms_end = matchstr(&cms,'\V%s\zs\.\+')
        endif
        let fmr = split(&fmr, ',')[a:foldclose_p]. (v:count ? v:count : '')
        exe 'norm! A'. padding. cms_start. fmr. cms_end
    endfunction
    "}}}
    nnoremap <silent>z<C-_>    zMzvzc
    nnoremap <silent>z0    :<C-u>set foldlevel=<C-r>=foldlevel('.')<CR><CR>

    call neobundle#untap()
endif"}}}

if neobundle#tap('junkfile.vim')"{{{
    call neobundle#config({
                \ 'autoload': {
                \   'unite_sources': ['junkfile'],
                \   'commands': ['JunkfileOpen']
                \ }
                \ })

    call neobundle#untap()
endif"}}}

if neobundle#tap('plantuml-syntax')"{{{
    call neobundle#config({
                \ 'autoload': {
                \   'filetypes': 'plantuml'
                \ }
                \ })
    call neobundle#untap()
endif"}}}

if neobundle#tap('vim-endwise')"{{{
    call neobundle#config({
                \ 'autoload': {
                \   'mappings': [['i', '<Plug>DiscretionaryEnd'], ['i', '<Plug>AlwaysEnd']]
                \ }
                \ })
    call neobundle#untap()
endif"}}}

if neobundle#tap('chalice')"{{{
    call neobundle#config({
                \ 'autoload': {
                \   'commands': 'Chalice'
                \ }
                \ })
    call neobundle#untap()
endif"}}}

if neobundle#tap('syntastic')"{{{
    call neobundle#config({
                \ 'autoload': {
                \   'commands': [{'complete': 'custom,s:CompleteCheckerName', 'name': 'SyntasticCheck'},
                \                'SyntasticInfo', 'Errors', 'SyntasticSetLoclist', 'SyntasticReset',
                \                'SyntasticToggleMode']
                \ }
                \ })
    let g:syntastic_go_checkers = ['go', 'golint']

    call neobundle#untap()
endif"}}}

if neobundle#tap('vim-ps1')"{{{
    call neobundle#config({
                \ 'autoload': {
                \   'filetypes': 'ps1'
                \ }
                \ })
    call neobundle#untap()
endif"}}}

if neobundle#tap('vim-alignta')"{{{
    call neobundle#config({
                \ 'autoload': {
                \   'unite_sources': ['alignta'],
                \   'commands': [{'complete': 'customlist,s:complete_command_option', 'name': 'Alignta'},
                \                {'complete': 'customlist,s:complete_command_option', 'name': 'Align'}]
                \ }
                \ })

    call neobundle#untap()
endif"}}}

if neobundle#tap('vim-splash')"{{{
    call neobundle#config({
                \ 'augroup': 'plugin',
                \   'autoload': {
                \   'commands': {'complete': 'file', 'name': 'Splash'}
                \ }
                \ })
    " clone splash gist "{{{
    function! s:clone_splash()
        let s:splash_dir = $HOME . "/.vim-splash"
        if !isdirectory(s:splash_dir)
            echom "cloning vim splash ..."
            let s:com = "git clone https://gist.github.com/7630711.git " . s:splash_dir
            echom s:com
            call system(s:com)
        endif
    endfunction"}}}
    call s:clone_splash()

    let g:splash#path = s:splash_dir . '/vim_intro.txt'

    call neobundle#untap()
endif"}}}

if neobundle#tap('splitjoin.vim')"{{{
    call neobundle#config({
                \ 'autoload': {
                \   'mappings': ['n', '<Plug>Splitjoin'],
                \   'commands': ['SplitjoinSplit', 'SplitjoinJoin']
                \ }
                \ })
    nmap sj :SplitjoinSplit<cr>
    nmap sk :SplitjoinJoin<cr>

    call neobundle#untap()
endif"}}}

if neobundle#tap('linediff.vim')"{{{
    call neobundle#config({
                \ 'autoload': {
                \   'commands': ['LinediffReset', 'Linediff']
                \ }
                \ })

    call neobundle#untap()
endif"}}}

if neobundle#tap('emmet-vim')"{{{
    call neobundle#config({
                \ 'autoload': {
                \   'commands': ['Emmet', 'EmmetInstall'],
                \   'filetypes': ['html']
                \ }
                \ })

    call neobundle#untap()
endif"}}}

if neobundle#tap('vim-fireplace')"{{{
    call neobundle#config({
                \ 'autoload': {
                \   'mappings': ['cxin', '<Plug>Fireplace'],
                \   'commands': [{'complete': 'customlist,fireplace#eval_complete', 'name': 'Eval'},
                \                'Last',
                \                {'complete': 'customlist,s:connect_complete', 'name': 'FireplaceConnect'},
                \                {'complete': 'customlist,fireplace#ns_complete', 'name': 'Require'}],
                \   'filetypes': 'clojure'
                \ }
                \ })

    call neobundle#untap()
endif"}}}

if neobundle#tap('vim-ft-clojure')"{{{
    call neobundle#config({
                \ 'autoload': {
                \   'filetypes': 'clojure'
                \ }
                \ })

    call neobundle#untap()
endif"}}}

if neobundle#tap('capture.vim')"{{{
    call neobundle#config({
                \ 'autoload': {
                \   'commands': [{'complete': 'command', 'name': 'Capture'}]
                \ }
                \ })

    call neobundle#untap()
endif"}}}

if neobundle#tap('restart.vim')"{{{
    call neobundle#config({
                \ 'autoload': {
                \   'commands': 'Restart'
                \ }
                \ })

    call neobundle#untap()
endif"}}}

if neobundle#tap('unite-qfixhowm')"{{{
    call neobundle#config({
                \ 'autoload': {
                \   'unite_sources': 'qfixhowm'
                \ }
                \ })

    nnoremap <silent> [Space]uq :<C-u>Unite -no-split -buffer-name=qfixhowm qfixhowm<CR>

    call neobundle#untap()
endif"}}}

if neobundle#tap('vim-prettyprint')"{{{
    call neobundle#config({
                \ 'autoload': {
                \   'commands': [{'complete': 'expression', 'name': 'PP'},
                \                {'complete': 'expression', 'name': 'PrettyPrint'}]
                \ }
                \ })

    call neobundle#untap()
endif"}}}

if neobundle#tap('vim-quickhl')"{{{
    call neobundle#config({
                \ 'augroup': 'QuickhlManual', 'autoload': {
                \   'mappings': ['sxn', '<Plug>(quickhl-'],
                \   'commands': ['QuickhlManualUnlockWindow', 'QuickhlManualDelete',
                \                'QuickhlTagToggle', 'QuickhlManualDisable', 'QuickhlTagDisable',
                \                'QuickhlManualAdd', 'QuickhlManualColors', 'QuickhlManualReset',
                \                'QuickhlManualLockToggle', 'QuickhlManualLock',
                \                'QuickhlManualEnable', 'QuickhlManualList', 'QuickhlCwordEnable',
                \                'QuickhlManualUnlock', 'QuickhlCwordDisable', 'QuickhlTagEnable',
                \                'QuickhlManualLockWindowToggle', 'QuickhlManualLockWindow',
                \                'QuickhlCwordToggle']
                \ }
                \ })

    nmap [Space]m <Plug>(quickhl-manual-this)
    xmap [Space]m <Plug>(quickhl-manual-this)
    "nmap <F9>     <Plug>(quickhl-manual-toggle)
    "xmap <F9>     <Plug>(quickhl-manual-toggle)

    nmap [Space]M <Plug>(quickhl-manual-reset)
    xmap [Space]M <Plug>(quickhl-manual-reset)

    nmap [Space]j <Plug>(quickhl-cword-toggle)

    nmap [Space]] <Plug>(quickhl-tag-toggle)

    map H <Plug>(operator-quickhl-manual-this-motion)

    call neobundle#untap()
endif"}}}

if neobundle#tap('vim-visualstar')"{{{
    call neobundle#config({
                \ 'autoload': {
                \   'mappings': '<Plug>(visualstar-'
                \ }
                \ })

    noremap <Plug>N N
    map * <Plug>(visualstar-*)<Plug>N
    map # <Plug>(visualstar-#)<Plug>N
    call neobundle#untap()
endif"}}}

if neobundle#tap('vim-operator-search')"{{{
    call neobundle#config({
                \ 'autoload': {
                \   'mappings': '<Plug>(operator-search'
                \ }
                \ })
    nmap [Space]/ <Plug>(operator-search)

    call neobundle#untap()
endif"}}}

if neobundle#tap('vim-textobj-multiblock')"{{{
    call neobundle#config({
                \ 'autoload': {
                \   'mappings': '<Plug>(textobj-multiblock'
                \ }
                \ })

    omap ab <Plug>(textobj-multiblock-a)
    omap ib <Plug>(textobj-multiblock-i)
    xmap ab <Plug>(textobj-multiblock-a)
    xmap ib <Plug>(textobj-multiblock-i)

    call neobundle#untap()
endif"}}}

if neobundle#tap('vim-textobj-ruby')"{{{
    call neobundle#config({
                \ 'autoload': {
                \   'mappings': '<Plug>(textobj-ruby',
                \   'filetypes': 'ruby'
                \ }
                \ })

    call neobundle#untap()
endif"}}}

if neobundle#tap('gitv')"{{{
    call neobundle#config({
                \ 'autoload': {
                \   'commands': ['Gitv']
                \ }
                \ })

    call neobundle#untap()
endif"}}}

if neobundle#tap('simple-javascript-indenter')"{{{
    call neobundle#config({
                \ 'autoload': {
                \   'filetypes': 'javascript'
                \ }
                \ })

    call neobundle#untap()
endif"}}}

if neobundle#tap('vim-javascript-syntax')"{{{
    call neobundle#config({
                \ 'autoload': {
                \   'filetypes': 'javascript'
                \ }
                \ })

    call neobundle#untap()
endif"}}}

if neobundle#tap('vim-javascript')"{{{
    call neobundle#config({
                \ 'autoload': {
                \   'filetypes': 'javascript'
                \ }
                \ })

    call neobundle#untap()
endif"}}}

if neobundle#tap('vim-vimperator')"{{{
    call neobundle#config({
                \ 'autoload': {
                \   'filetypes': 'vimperator'
                \ }
                \ })

    call neobundle#untap()
endif"}}}

if neobundle#tap('calendar.vim')"{{{
    call neobundle#config({
                \ 'autoload': {
                \   'commands': [{'complete': 'customlist,calendar#argument#complete', 'name': 'Calendar'}]
                \ }
                \ })

    let g:calendar_google_calendar = 1
    let g:calendar_google_task = 1

    call neobundle#untap()
endif"}}}

if neobundle#tap('thumbnail.vim')"{{{
    call neobundle#config({
                \ 'autoload': {
                \   'commands': [{'complete': 'customlist,thumbnail#complete', 'name': 'Thumbnail'}]
                \ }
                \ })

    call neobundle#untap()
endif"}}}

if neobundle#tap('vim-choosewin')"{{{
    call neobundle#config({
                \ 'autoload': {
                \   'mappings': ['<Plug>(choosewin)'],
                \   'commands': ['FontReview', 'FontPerfSmall', 'ChooseWin', 'FontPerfLarge']
                \ }
                \ })

    nmap  -  <Plug>(choosewin)

    let g:choosewin_overlay_enable = 1
    let g:choosewin_overlay_clear_multibyte = 1

    " color like tmux
    let g:choosewin_color_overlay = {
                \ 'gui': ['DodgerBlue3', 'DodgerBlue3' ],
                \ 'cterm': [ 25, 25 ]
                \ }
    let g:choosewin_color_overlay_current = {
                \ 'gui': ['firebrick1', 'firebrick1' ],
                \ 'cterm': [ 124, 124 ]
                \ }

    let g:choosewin_blink_on_land      = 0
    let g:choosewin_statusline_replace = 0
    let g:choosewin_tabline_replace    = 0

    call neobundle#untap()

endif"}}}

if neobundle#tap('indentLine')"{{{
    call neobundle#config({})

    let g:indentLine_fileTypeExclude = ['help', 'nerdtree', 'calendar', 'thumbnail']

    call neobundle#untap()
endif"}}}

if neobundle#tap('vimplenote-vim')"{{{
    call neobundle#config({
                \ 'autoload': {
                \   'commands': ['VimpleNote']
                \ }
                \ })

    nnoremap <Leader>vl :<C-u>VimpleNote -l<CR>
    nnoremap <Leader>vn :<C-u>VimpleNote -n<CR>

    call neobundle#untap()
endif"}}}

if neobundle#tap('unite-vim_advent-calendar')"{{{
    call neobundle#config({
                \ 'autoload': {
                \   'unite_sources': ['vim_advent_calendar']
                \ }
                \ })

    call neobundle#untap()
endif"}}}

if neobundle#tap('unite-advent_calendar')"{{{
    call neobundle#config({
                \ 'autoload': {
                \   'unite_sources': ['advent_calendar']
                \ }
                \ })

    call neobundle#untap()
endif"}}}

" disable plugin
let plugin_dicwin_disable = 1
"===================================================================================}}}

"{{{ ========== Language Settings =====================================================
au MyAutoCmd FileType python setl autoindent smartindent
      \ cinwords=if,elif,else,for,while,try,except,finally,def,class
      \ tabstop=8 expandtab shiftwidth=4 softtabstop=4
      \ foldmethod=indent foldlevel=99
au MyAutoCmd BufNewFile,BufRead *.cmd setl ft=ps1 fenc=cp932 ff=dos
au MyAutoCmd BufNewFile,BufRead *.hta setl ft=html fenc=cp932 ff=dos
au MyAutoCmd BufNewFile,BufRead *.sql setl fenc=cp932 ff=dos
au MyAutoCmd BufNewFile,BufRead *.bat setl fenc=cp932 ff=dos
au MyAutoCmd BufNewFile,BufRead *.ts setl ft=typescript fenc=utf8 ff=unix
au MyAutoCmd BufNewFile,BufRead *.coffee setl ft=coffee fenc=utf8 ff=unix
      \ tabstop=4 shiftwidth=2 softtabstop=2 expandtab
au MyAutoCmd BufNewFile,BufRead *.js setl ft=javascript fenc=utf8 ff=unix
      \ tabstop=4 shiftwidth=2 softtabstop=2 expandtab
au MyAutoCmd BufNewFile,BufRead *.wsf setl fenc=utf8 ff=unix
      \ tabstop=4 shiftwidth=2 softtabstop=2 expandtab
au MyAutoCmd BufNewFile,BufRead *.html setl ts=4 sw=2 st=2 et
au MyAutoCmd BufNewFile,BufRead *.uml setl fenc=cp932 ff=dos ft=plantuml
au MyAutoCmd BufNewFile,BufRead *.diag setl fenc=utf8 ff=unix ft=blockdiag
au MyAutoCmd BufNewFile,BufRead *.md setl ft=markdown fenc=utf8 ff=unix
      \ tabstop=4 shiftwidth=2 softtabstop=2 expandtab
au MyAutoCmd BufNewFile,BufRead *.rst setl tabstop=8 shiftwidth=3 softtabstop=3 expandtab
au MyAutoCmd BufNewFile,BufRead *.jade setl ft=jade
au MyAutoCmd BufNewFile,BufRead *.styl setl ft=stylus tabstop=8 shiftwidth=2
      \ softtabstop=2 expandtab
au MyAutoCmd BufNewFile,BufRead *.scpt,*.applescript setl filetype=applescript
au MyAutoCmd BufNewFile,BufRead *.scala setl ft=scala
au MyAutoCmd BufNewFile,BufRead *.rb setl ft=ruby fenc=utf8 ff=unix

" Scala {{{
" http://vim-users.jp/2013/02/vim-advent-calendar-2012-ujihisa-4/
function! s:ujihisa_start_sbt()"{{{
    execute 'VimShellInteractive sbt'
    stopinsert
    let t:sbt_bufname = bufname('%')
    if !has_key(t:, 'sbt_cmds')
        let t:sbt_cmds = [input('t:sbt_cmds[0] = ')]
    endif
    wincmd p
endfunction

command! -nargs=0 StartSBT call <SID>ujihisa_start_sbt()
"}}}

function! s:sbt_run()"{{{
    let cmds = get(t:, 'sbt_cmds', 'run')

    let sbt_bufname = get(t:, 'sbt_bufname')
    if sbt_bufname !=# ''
        call vimshell#interactive#set_send_buffer(sbt_bufname)
        call vimshell#interactive#send(cmds)
    else
        echoerr 'try StartSBT'
    endif
endfunction"}}}

function! s:vimrc_scala()"{{{
    nnoremap <buffer> [Space]m :<C-u>write<Cr>:call <SID>sbt_run()<Cr>
endfunction"}}}

augroup vimrc_scala"{{{
    autocmd!
    au FileType scala call s:vimrc_scala()
    au FileType scala nnoremap <buffer> [Space]st :<C-u>StartSBT<Cr>
augroup END"}}}
"}}}
"===================================================================================}}}

"{{{ ========== Temp Settings =========================================================


"===================================================================================}}}
