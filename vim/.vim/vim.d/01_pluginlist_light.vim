" Use neobundle.vim
let s:bundle_dir = expand($HOME . "/.vim/bundle")
let s:neobundle_dir = s:bundle_dir . "/neobundle.vim"

if has('vim_starting') "{{{
  " Load neobundle.
  if isdirectory('neobundle.vim')
    set runtimepath^=neobundle.vim
  elseif finddir('neobundle.vim', '.;') != ''
    execute 'set runtimepath^=' . finddir('neobundle.vim', '.;')
  elseif &runtimepath !~ '/neobundle.vim'
    if !isdirectory(s:neobundle_dir)
      execute printf('!git clone %s://github.com/Shougo/neobundle.vim.git',
            \ (exists('$http_proxy') ? 'https' : 'git'))
            \ s:neobundle_dir
    endif

    execute 'set runtimepath^=' . s:neobundle_dir
  endif
endif
"}}}

call neobundle#begin(s:bundle_dir)

" Let NeoBundle manage NeoBundle
NeoBundleFetch 'Shougo/neobundle.vim'

" Plugin list {{{
" Not lazy"{{{
NeoBundle 'Shougo/vimproc.vim', {
      \ 'build': {
      \   'windows': 'mingw32-make -f make_mingw32.mak',
      \   'cygwin': 'make -f make_cygwin.mak',
      \   'mac': 'make -f make_mac.mak',
      \   'unix': 'make -f make_unix.mak',
      \ }}
NeoBundle 'haya14busa/incsearch.vim'
NeoBundle 'banyan/recognize_charcode.vim'
NeoBundle 'LeafCage/foldCC'
NeoBundle 'altercation/vim-colors-solarized'
NeoBundle 'itchyny/lightline.vim'
NeoBundle 'osyo-manga/vim-anzu'
NeoBundle 'osyo-manga/vim-automatic', {'depends': ['osyo-manga/vim-gift', 'osyo-manga/vim-reunions']}
NeoBundle 'rhysd/clever-f.vim'
NeoBundle 'thinca/vim-submode'
NeoBundle 'tpope/vim-repeat'
"}}}
" Lazy"{{{
NeoBundleLazy 'Shougo/vimfiler.vim'
NeoBundleLazy 'edsono/vim-matchit'
NeoBundleLazy 't9md/vim-quickhl'
NeoBundleLazy 'thinca/vim-visualstar'
NeoBundleLazy 'vim-scripts/copypath.vim'
NeoBundleLazy 'fuenor/qfixgrep'
"}}}
call neobundle#end()

filetype plugin indent on

" Installation check.
if ! has('gui_running')
  NeoBundleCheck
endif
"}}}
