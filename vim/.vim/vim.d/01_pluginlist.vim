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
NeoBundle 'LeafCage/yankround.vim', {'depends': 'kien/ctrlp.vim'}
NeoBundle 'Shougo/neocomplete.vim', {'depends': 'Shougo/context_filetype.vim'}
NeoBundle 'Yggdroot/indentLine'
NeoBundle 'altercation/vim-colors-solarized'
NeoBundle 'itchyny/lightline.vim'
NeoBundle 'kana/vim-operator-user'
NeoBundle 'kana/vim-textobj-user'
NeoBundle 'kana/vim-operator-replace'
NeoBundle 'kana/vim-textobj-entire'
NeoBundle 'kana/vim-textobj-fold'
NeoBundle 'kana/vim-textobj-function'
NeoBundle 'kana/vim-textobj-indent'
NeoBundle 'mattn/webapi-vim'
NeoBundle 'osyo-manga/vim-anzu'
NeoBundle 'osyo-manga/vim-automatic', {'depends': ['osyo-manga/vim-gift', 'osyo-manga/vim-reunions']}
NeoBundle 'osyo-manga/vim-watchdogs', {'depends': 'thinca/vim-quickrun'}
NeoBundle 'rhysd/clever-f.vim'
NeoBundle 'rhysd/committia.vim'
NeoBundle 'soramugi/auto-ctags.vim'
NeoBundle 'thinca/vim-submode'
NeoBundle 'thinca/vim-qfreplace'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'tpope/vim-repeat'
NeoBundle 'tyru/operator-star.vim', {'depends': ['thinca/vim-visualstar']}
NeoBundle 'tyru/caw.vim'
NeoBundle 'vim-jp/vimdoc-ja'
NeoBundle 'airblade/vim-gitgutter'
"}}}
" Lazy"{{{
" NeoBundleLazy 'DrawIt'
" NeoBundleLazy 'adogear/vim-blockdiag-series'
" NeoBundleLazy 'alpaca-tc/alpaca_tags'
" NeoBundleLazy 'basyura/J6uil.vim'
" NeoBundleLazy 'basyura/unite-rails'
" NeoBundleLazy 'derekwyatt/vim-scala'
" NeoBundleLazy 'hachibeeDI/vim-vbnet'
" NeoBundleLazy 'jelera/vim-javascript-syntax'
" NeoBundleLazy 'jiangmiao/simple-javascript-indenter'
" NeoBundleLazy 'jpo/vim-railscasts-theme'
" NeoBundleLazy 'mattn/excitetranslate-vim'
" NeoBundleLazy 'mattn/gist-vim'
" NeoBundleLazy 'mattn/googletasks-vim'
" NeoBundleLazy 'mattn/unite-advent_calendar'
" NeoBundleLazy 'mattn/unite-vim_advent-calendar'
" NeoBundleLazy 'mitechie/pyflakes-pathogen'
" NeoBundleLazy 'modsound/macdict-vim'
" NeoBundleLazy 'mopp/googlesuggest-source.vim', {'depends': 'mattn/googlesuggest-complete-vim'}
" NeoBundleLazy 'pekepeke/titanium-vim'
" NeoBundleLazy 'rcmdnk/vim-markdown'
" NeoBundleLazy 'rhysd/vim-textobj-ruby'
" NeoBundleLazy 'thinca/vim-ft-clojure'
" NeoBundleLazy 'tpope/vim-rails'
" NeoBundleLazy 'triglav/vim-visual-increment'
NeoBundleLazy 'AndrewRadev/linediff.vim'
NeoBundleLazy 'AndrewRadev/splitjoin.vim'
NeoBundleLazy 'LeafCage/nebula.vim'
NeoBundleLazy 'PProvost/vim-ps1'
NeoBundleLazy 'SQLUtilities'
NeoBundleLazy 'Shougo/echodoc.vim'
NeoBundleLazy 'Shougo/junkfile.vim'
NeoBundleLazy 'Shougo/neomru.vim'
NeoBundleLazy 'Shougo/neosnippet.vim', {'depends': ['Shougo/neosnippet-snippets', 'Shougo/context_filetype.vim']}
NeoBundleLazy 'Shougo/unite.vim'
NeoBundleLazy 'Shougo/unite-outline'
NeoBundleLazy 'Shougo/vim-vcs'
NeoBundleLazy 'Shougo/vimfiler.vim'
NeoBundleLazy 'Shougo/vimshell.vim'
NeoBundleLazy 'Shougo/vinarise.vim'
NeoBundleLazy 'aklt/plantuml-syntax'
NeoBundleLazy 'basyura/J6uil.vim'
NeoBundleLazy 'basyura/unite-firefox-bookmarks'
NeoBundleLazy 'choplin/unite-vim_hacks'
NeoBundleLazy 'cocopon/colorswatch.vim'
NeoBundleLazy 'cohama/agit.vim'
if executable('npm')
  NeoBundleLazy 'clausreinke/typescript-tools', {'build': {'others': 'npm install -g typescript-tools'}}
  NeoBundleLazy 'marijnh/tern_for_vim', {'build': {'others': 'npm install'}}
  NeoBundleLazy 'mephux/vim-jsfmt', {'build': {'others': 'npm install -g jsfmt'}}
endif
NeoBundleLazy 'dag/vim2hs'
NeoBundleLazy 'digitaltoad/vim-jade'
NeoBundleLazy 'drakontia/sphinx.vim'
if executable('cabal')
  NeoBundleLazy 'eagletmt/ghcmod-vim', {'build': {'others': 'cabal install ghc-mod'}}
  NeoBundleLazy 'eagletmt/neco-ghc', {'build': {'others': 'cabal install ghc-mod'}}
  NeoBundleLazy 'eagletmt/unite-haddock', {'build': {'others': 'cabal install hoogle'}}
endif
NeoBundleLazy 'edsono/vim-matchit'
NeoBundleLazy 'glidenote/memolist.vim'
NeoBundleLazy 'gregsexton/gitv'
NeoBundleLazy 'guns/vim-clojure-static'
NeoBundleLazy 'itchyny/calendar.vim'
NeoBundleLazy 'itchyny/dictionary.vim'
NeoBundleLazy 'itchyny/thumbnail.vim'
NeoBundleLazy 'jmcantrell/vim-virtualenv'
NeoBundleLazy 'jason0x43/vim-js-indent'
NeoBundleLazy 'kana/vim-filetype-haskell'
NeoBundleLazy 'kannokanno/previm.git'
NeoBundleLazy 'kchmck/vim-coffee-script'
NeoBundleLazy 'kien/ctrlp.vim'
NeoBundleLazy 'kien/rainbow_parentheses.vim'
NeoBundleLazy 'koron/chalice'
NeoBundleLazy 'koron/codic-vim'
NeoBundleLazy 'lambdalisue/vim-django-support'
NeoBundleLazy 'lambdalisue/vim-gista'
NeoBundleLazy 'leafgarland/typescript-vim'
NeoBundleLazy 'majutsushi/tagbar', {'build': {'mac': 'brew install ctags'}}
NeoBundleLazy 'mattn/emmet-vim'
NeoBundleLazy 'mattn/vimplenote-vim'
NeoBundleLazy 'nanotech/jellybeans.vim'
NeoBundleLazy 'osyo-manga/vim-operator-blockwise', {'depends': 'kana/vim-operator-user'}
NeoBundleLazy 'osyo-manga/vim-operator-search', {'depends': 'kana/vim-operator-user'}
NeoBundleLazy 'osyo-manga/vim-over'
NeoBundleLazy 'osyo-manga/unite-quickfix'
NeoBundleLazy 'osyo-manga/shabadou.vim', {'depends': 'thinca/vim-quickrun'}
NeoBundleLazy 'osyo-manga/vim-marching'
NeoBundleLazy 'pangloss/vim-javascript'
NeoBundleLazy 'pasela/unite-webcolorname'
NeoBundleLazy 'rhysd/unite-codic.vim', {'depends': 'koron/codic-vim'}
NeoBundleLazy 'rhysd/vim-operator-surround', {'depends': 'kana/vim-operator-user'}
NeoBundleLazy 'rhysd/wandbox-vim'
NeoBundleLazy 'rking/ag.vim'
NeoBundleLazy 'sjl/gundo.vim'
NeoBundleLazy 'superbrothers/vim-vimperator'
NeoBundleLazy 'supermomonga/jazzradio.vim'
NeoBundleLazy 'supermomonga/vimshell-pure.vim', {'depends' : 'Shougo/vimshell.vim'}
NeoBundleLazy 't9md/vim-choosewin'
NeoBundleLazy 't9md/vim-quickhl'
NeoBundleLazy 'tacroe/unite-mark'
NeoBundleLazy 'thinca/vim-ft-help_fold'
NeoBundleLazy 'thinca/vim-prettyprint'
NeoBundleLazy 'thinca/vim-quickrun'
NeoBundleLazy 'thinca/vim-ref'
NeoBundleLazy 'thinca/vim-splash'
NeoBundleLazy 'thinca/vim-template'
NeoBundleLazy 'thinca/vim-visualstar'
NeoBundleLazy 'tpope/vim-fireplace', {'depends': ['tpope/vim-classpath', 'guns/vim-clojure-static']}
NeoBundleLazy 'tsukkee/lingr-vim'
NeoBundleLazy 'tsukkee/unite-help'
NeoBundleLazy 'tsukkee/unite-tag'
NeoBundleLazy 'tyru/capture.vim'
NeoBundleLazy 'tyru/open-browser.vim'
NeoBundleLazy 'tyru/restart.vim'
NeoBundleLazy 'ujihisa/unite-colorscheme'
NeoBundleLazy 'ujihisa/unite-font'
NeoBundleLazy 'vim-ruby/vim-ruby'
NeoBundleLazy 'vim-scripts/copypath.vim'
NeoBundleLazy 'wavded/vim-stylus'
NeoBundleLazy 'wesleyche/SrcExpl'
NeoBundleLazy 'yuyunko/dosbatch-indent', {'depends': 'taku-o/vim-batch-source'}
NeoBundleLazy 'zhisheng/visualmark.vim'
NeoBundleLazy 'fatih/vim-go'
if executable('pip')
  NeoBundleLazy 'davidhalter/jedi-vim', {
        \ 'depends': 'mitechie/pyflakes-pathogen',
        \ 'build': {
        \   'mac': 'pip install jedi',
        \   'unix': 'pip install jedi'
        \ }}
endif
NeoBundleLazy 'vim-jp/cpp-vim'
NeoBundleLazy 'basyura/TweetVim', 'dev', {
      \ 'depends': [
      \   'tyru/open-browser.vim',
      \   'basyura/twibill.vim',
      \   'basyura/bitly.vim',
      \   'Shougo/unite-outline',
      \   'Shougo/vimproc.vim',
      \   'mattn/favstar-vim',
      \   'mattn/webapi-vim'
      \ ]}
"}}}
call neobundle#end()

filetype plugin indent on

" Installation check.
if ! has('gui_running')
  NeoBundleCheck
endif
"}}}
