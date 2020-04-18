" Funcs: {{{1
function! Markdown_preview_do(hooktype, name) abort
  echom a:hooktype
  packadd markdown-preview.nvim
  call mkdp#util#install()
endfunction

" Plugins: {{{1
" Pack 'Konfekt/FastFold', {'type': 'lazyall'}
" Pack 'LumaKernel/vim-messages-qf', {'type': 'lazy'}
" Pack 'MaxMEllon/vim-shiny', {'type': 'lazyall'}
" Pack 'NLKNguyen/papercolor-theme', {'type': 'opt'}
" Pack 'OmniSharp/Omnisharp-vim', {'type': 'opt', 'for': 'cs'}
" Pack 'PProvost/vim-ps1', {'type': 'opt', 'for': 'ps1'}
" Pack 'RRethy/vim-illuminate', {'type': 'lazyall'}
" Pack 'Rigellute/rigel', {'type': 'opt'}
" Pack 'Shougo/defx.nvim', {'type': 'opt', 'on': ['Defx'], 'do': 'silent! UpdateRemotePlugins'}
" Pack 'Shougo/echodoc.vim', {'type': 'lazyall'}
" Pack 'Shougo/junkfile.vim', {'type': 'opt', 'on': 'JunkfileOpen'}
" Pack 'Shougo/neco-syntax'
" Pack 'Shougo/neco-vim', {'type': 'opt', 'for': 'vim'}
" Pack 'Shougo/neomru.vim', {'type': 'lazyall'}
" Pack 'Shougo/neosnippet-snippets', {'type': 'lazyall'}
" Pack 'Shougo/neosnippet.vim', {'type': 'lazyall'}
" Pack 'Shougo/vimproc.vim', {'type': 'lazyall', 'do': 'silent! !make'}
" Pack 'TaDaa/vimade', {'type': 'lazyall'}
" Pack 'Vimjas/vim-python-pep8-indent', {'type': 'opt', 'for': 'python'}
" Pack 'Yggdroot/indentLine'
" Pack 'aereal/vim-colors-japanesque', {'type': 'opt'}
" Pack 'airblade/vim-gitgutter', {'type': 'lazyall'}
" Pack 'airblade/vim-rooter', {'type': 'lazyall'}
" Pack 'aklt/plantuml-syntax', {'type': 'opt', 'for': 'plantuml'}
" Pack 'alx741/vim-hindent', {'type': 'opt', 'do': 'silent! !stack install hindent', 'if': executable('stack'), 'for': 'haskell'}
" Pack 'andymass/vim-matchup', {'type': 'lazyall'}
" Pack 'arcticicestudio/nord-vim', {'type': 'opt'}
" Pack 'b4b4r07/vim-sqlfmt', {'type': 'opt', 'do': 'silent! !go get github.com/jackc/sqlfmt', 'for': 'sql'}
" Pack 'basyura/TweetVim', {'type': 'opt', 'on': ['TweetVimHomeTimeline', 'TweetVimUserStream','TweetVimSay']}
" Pack 'basyura/bitly.vim', {'type': 'opt'}
" Pack 'basyura/twibill.vim', {'type': 'lazyall'}
" Pack 'bfredl/nvim-miniyank', {'type': 'lazyall'}
" Pack 'camspiers/animate.vim', {'type': 'lazyall'}
" Pack 'camspiers/lens.vim', {'type': 'lazyall'}
" Pack 'cespare/vim-toml', {'type': 'opt', 'for': 'toml'}
" Pack 'chriskempson/base16-vim'
" Pack 'cocopon/iceberg.vim', {'type': 'opt'}
" Pack 'cohama/lexima.vim', {'type': 'lazyall'}
" Pack 'cormacrelf/vim-colors-github', {'type': 'opt'}
" Pack 'dag/vim-fish', {'type': 'opt', 'for': 'fish'}
" Pack 'davidhalter/jedi-vim', {'type': 'opt', 'for': ['python']}
" Pack 'dense-analysis/ale', {'type': 'lazyall'}
" Pack 'dhruvasagar/vim-table-mode', {'type': 'opt', 'for': 'markdown'}
" Pack 'dkarter/bullets.vim', {'type': 'lazyall'}
" Pack 'dzeban/vim-log-syntax', {'type': 'opt', 'for': 'log'}
" Pack 'eagletmt/ghcmod-vim', {'type': 'opt', 'do': 'silent! !stack install ghc-mod', 'if': executable('stack'), 'for': 'haskell'}
" Pack 'eagletmt/neco-ghc', {'type': 'opt', 'for': 'haskell'}
" Pack 'edkolev/tmuxline.vim', {'type': 'opt', 'on': ['Tmuxline', 'TmuxlineSnapshot']}
" Pack 'ekalinin/Dockerfile.vim', {'type': 'opt', 'for': 'dockerfile'}
" Pack 'fatih/vim-go', {'type': 'opt', 'for': 'go'}
" Pack 'fuenor/qfixgrep', {'type': 'lazyall'}
" Pack 'fuenor/qfixhowm', {'type': 'lazyall'}
" Pack 'gko/vim-coloresque', {'type': 'lazyall'}
" Pack 'haya14busa/is.vim', {'type': 'lazyall'}
" Pack 'haya14busa/vim-edgemotion', {'type': 'lazyall'}
" Pack 'hiroakis/cyberspace.vim', {'type': 'opt'}
" Pack 'hotwatermorning/auto-git-diff', {'type': 'lazyall'}
" Pack 'iamcco/markdown-preview.nvim', {'type': 'opt', 'for': 'markdown', 'on': 'MarkdownPreview', 'do': function('Markdown_preview_do')}
" Pack 'itchyny/vim-cursorword', {'type': 'lazyall'}
" Pack 'itchyny/vim-external', {'type': 'lazyall'}
" Pack 'itchyny/vim-haskell-indent', {'type': 'opt', 'for': 'haskell'}
" Pack 'itchyny/vim-haskell-sort-import', {'type': 'opt', 'for': 'haskell'}
" Pack 'iyuuya/denite-ale', {'type': 'lazyall'}
" Pack 'jeffkreeftmeijer/vim-numbertoggle'
" Pack 'joshdick/onedark.vim', {'type': 'opt'}
" Pack 'jremmen/vim-ripgrep', {'type': 'opt', 'on': 'Rg'}
" Pack 'kana/vim-altr', {'type': 'opt', 'on': ['<Plug>(altr-forward)', '<Plug>(altr-back)']}
" Pack 'kannokanno/previm', {'type': 'opt', 'for': 'markdown'}
" Pack 'kassio/neoterm', {'type': 'lazyall', 'if': has('nvim')}
" Pack 'kchmck/vim-coffee-script', {'type': 'opt', 'for': 'coffee'}
" Pack 'keremc/asyncomplete-racer.vim', {'type': 'opt', 'for': 'rust', 'if': !executable('rls')}
" Pack 'kmtoki/lightline-colorscheme-simplicity'
" Pack 'kopischke/vim-stay'
" Pack 'kristijanhusak/defx-icons', {'type': 'opt'}
" Pack 'kristijanhusak/vim-hybrid-material', {'type': 'opt'}
" Pack 'kshenoy/vim-signature', {'type': 'lazyall'}
" Pack 'kylef/apiblueprint.vim', {'type': 'opt', 'for': 'apiblueprint'}
" Pack 'lambdalisue/edita.vim', {'type': 'lazyall'}
" Pack 'lambdalisue/fern-bookmark.vim', {'type': 'lazyall'}
" Pack 'lambdalisue/fern-comparator-lexical.vim', {'type': 'lazyall'}
" Pack 'lambdalisue/suda.vim', {'type': 'lazyall', 'if': !g:is_windows}
" Pack 'lambdalisue/vim-findent'
" Pack 'lambdalisue/vim-pyenv', {'type': 'lazyall'}
" Pack 'lambdalisue/vim-quickrun-neovim-job', {'type': 'lazyall'}
" Pack 'leafgarland/typescript-vim', {'type': 'opt', 'for': ['typescript', 'typescript.tsx']}
" Pack 'lifepillar/vim-solarized8', {'type': 'opt'}
" Pack 'liuchengxu/vista.vim', {'type': 'lazyall'}
" Pack 'ludovicchabant/vim-gutentags', {'type': 'lazyall', 'if': executable('ctags')}
" Pack 'luochen1990/rainbow', {'type': 'lazyall'}
" Pack 'machakann/vim-colorscheme-kemonofriends'
" Pack 'machakann/vim-colorscheme-snowtrek', {'type': 'opt'}
" Pack 'machakann/vim-highlightedundo', {'type': 'lazyall', 'if': executable('diff')}
" Pack 'machakann/vim-highlightedyank', {'type': 'lazyall'}
" Pack 'majutsushi/tagbar', {'type': 'opt', 'on': 'TagbarToggle'}
" Pack 'markonm/traces.vim', {'type': 'lazyall'}
" Pack 'mattn/benchvimrc-vim', {'type': 'opt', 'on': 'BenchVimrc'}
" Pack 'mattn/favstar-vim', {'type': 'opt'}
" Pack 'mattn/qiita-vim', {'type': 'opt', 'on': 'Qiita'}
" Pack 'mattn/vim-findroot', {'type': 'lazyall'}
" Pack 'mattn/vim-gist', {'type': 'opt', 'on': 'Gist'}
" Pack 'mattn/vim-lexiv', {'type': 'lazyall'}
" Pack 'mattn/vim-sonictemplate', {'type': 'opt', 'on': 'Template'}
" Pack 'mbbill/undotree', {'type': 'opt', 'on': 'UndotreeToggle'}
" Pack 'mechatroner/rainbow_csv', {'type': 'opt', 'for': 'csv'}
" Pack 'mhinz/vim-grepper', {'type': 'opt', 'on': ['Grepper', '<Plug>(GrepperOperator)']}
" Pack 'morhetz/gruvbox', {'type': 'opt'}
" Pack 'mox-mox/vim-localsearch', {'type': 'lazyall'}
" Pack 'nelstrom/vim-markdown-folding', {'type': 'opt', 'for': 'markdown'}
" Pack 'neovimhaskell/haskell-vim', {'type': 'opt', 'for': ['haskell', 'cabal']}
" Pack 'osyo-manga/vim-anzu', {'type': 'lazyall'}
" Pack 'osyo-manga/vim-jplus', {'type': 'lazyall'}
" Pack 'osyo-manga/vim-operator-blockwise', {'type': 'lazyall'}
" Pack 'osyo-manga/vim-precious', {'type': 'lazyall'}
" Pack 'osyo-manga/vim-reanimate'
" Pack 'osyo-manga/vim-textobj-multiblock', {'type': 'lazyall'}
" Pack 'othree/es.next.syntax.vim', {'type': 'opt', 'for': ['javascript', 'javascript.jsx']}
" Pack 'othree/javascript-libraries-syntax.vim', {'type': 'opt', 'for': ['javascript', 'javascript.jsx']}
" Pack 'pangloss/vim-javascript', {'type': 'opt', 'for': ['javascript', 'javascript.jsx']}
" Pack 'posva/vim-vue', {'type': 'opt', 'for': 'vue'}
" Pack 'prabirshrestha/asyncomplete-necovim.vim', {'type': 'opt', 'for': 'vim'}
" Pack 'preservim/nerdcommenter', {'type': 'lazyall'}
" Pack 'psliwka/vim-smoothie', {'type': 'lazyall'}
" Pack 'qpkorr/vim-renamer', {'type': 'opt', 'on': ['Renamer', '<Plug>RenamerStart']}
" Pack 'rafi/awesome-vim-colorschemes', {'type': 'opt'}
" Pack 'rbtnn/vim-coloredit', {'type': 'opt', 'on': 'ColorEdit'}
" Pack 'reedes/vim-colors-pencil', {'type': 'opt'}
" Pack 'rhysd/accelerated-jk', {'type': 'lazyall'}
" Pack 'rhysd/clever-f.vim', {'type': 'lazyall'}
" Pack 'rhysd/git-messenger.vim', {'type': 'opt', 'on': 'GitMessenger'}
" Pack 'rhysd/reply.vim', {'type': 'opt', 'on': 'Repl'}
" Pack 'rhysd/rust-doc.vim', {'type': 'opt', 'if': executable('cargo'), 'for': 'rust'}
" Pack 'rhysd/vim-color-spring-night', {'type': 'opt'}
" Pack 'rhysd/vim-color-spring-night', {'type': 'opt'}
" Pack 'rhysd/vim-gfm-syntax', {'type': 'opt', 'for': 'markdown'}
" Pack 'rhysd/vim-healthcheck', {'type': 'opt', 'on': ['CheckHealth']}
" Pack 'roxma/nvim-yarp', {'if': !has('nvim')}
" Pack 'roxma/vim-hug-neovim-rpc', {'if': !has('nvim')}
" Pack 'rust-lang/rust.vim', {'type': 'opt', 'for': 'rust'}
" Pack 'scrooloose/nerdtree', {'type': 'opt', 'on': ['NERDTreeToggle', 'NERDTreeFind']}
" Pack 'scrooloose/vim-slumlord', {'type': 'opt', 'for': 'plantuml'}
" Pack 'sheerun/vim-polyglot'
" Pack 'skanehira/preview-markdown.vim', {'type': 'opt', 'on': 'PreviewMarkdown', 'if': executable('mdr') && !has('nvim')}
" Pack 'skanehira/translate.vim', {'type': 'opt', 'on': ['AutoTranslateModeToggle', '<Plug>(VTranslate)', '<Plug>(VTranslateBang)'], 'if': executable('gtran') && !has('nvim')}
" Pack 'skywind3000/vim-quickui', {'type': 'lazyall'}
" Pack 'stephpy/vim-yaml', {'type': 'opt', 'for': ['yml', 'yaml']}
" Pack 'svermeulen/vim-yoink', {'type': 'lazyall'}
" Pack 't9md/vim-choosewin', {'type': 'opt', 'on': ['<Plug>(choosewin)']}
" Pack 'taku-o/vim-zoom', {'type': 'lazyall'}
" Pack 'thinca/vim-localrc', {'type': 'lazyall'}
" Pack 'thinca/vim-quickrun', {'type': 'lazyall'}
" Pack 'tpope/vim-obsession', {'type': 'lazyall'}
" Pack 'twitvim/twitvim', {'type': 'lazyall'}
" Pack 'tyru/caw.vim', {'type': 'lazyall'}
" Pack 'unblevable/quick-scope', {'type': 'lazyall'}
" Pack 'vim-airline/vim-airline'
" Pack 'vim-airline/vim-airline-themes'
" Pack 'vim-scripts/matchit.zip', {'type': 'lazyall'}
" Pack 'voldikss/vim-floaterm', {'type': 'lazyall'}
" Pack 'wadackel/vim-dogrun', {'type': 'opt'}
" Pack 'wellle/context.vim', {'type': 'lazyall'}
" Pack 'wimstefan/vim-artesanal', {'type': 'opt'}
" Pack 'yssl/QFEnter', {'type': 'lazyall'}
" Pack 'yuttie/comfortable-motion.vim', {'type': 'lazyall'}
Pack 'LeafCage/yankround.vim', {'type': 'lazyall'}
Pack 'Shougo/context_filetype.vim', {'type': 'lazyall'}
Pack 'editorconfig/editorconfig-vim', {'type': 'lazyall'}
Pack 'eugen0329/vim-esearch', {'type': 'lazyall'}
Pack 'gilligan/textobj-lastpaste', {'type': 'lazyall'}
Pack 'glidenote/memolist.vim', {'type': 'opt', 'on': ['MemoNew', 'MemoList', 'MemoGrep']}
Pack 'haya14busa/vim-asterisk', {'type': 'lazyall'}
Pack 'haya14busa/vim-operator-flashy', {'type': 'lazyall'}
Pack 'honza/vim-snippets', {'type': 'lazyall'}
Pack 'itchyny/lightline.vim'
Pack 'itchyny/vim-gitbranch'
Pack 'itchyny/vim-highlighturl', {'type': 'lazyall'}
Pack 'itchyny/vim-parenmatch'
Pack 'junegunn/vim-easy-align', {'type': 'opt', 'on': '<Plug>(EasyAlign)'}
Pack 'k-takata/minpac', {'type': 'opt'}
Pack 'kana/vim-operator-replace', {'type': 'lazyall'}
Pack 'kana/vim-operator-user'
Pack 'kana/vim-textobj-entire', {'type': 'lazyall'}
Pack 'kana/vim-textobj-fold', {'type': 'lazyall'}
Pack 'kana/vim-textobj-function', {'type': 'lazyall'}
Pack 'kana/vim-textobj-indent', {'type': 'lazyall'}
Pack 'kana/vim-textobj-line', {'type': 'lazyall'}
Pack 'kana/vim-textobj-user'
Pack 'lambdalisue/gina.vim'
Pack 'mattn/transparency-windows-vim', {'if': g:is_windows}
Pack 'mattn/vimtweak', {'if': g:is_windows}
Pack 'mattn/webapi-vim', {'type': 'lazyall'}
Pack 'nathanaelkane/vim-indent-guides'
Pack 'ntpeters/vim-better-whitespace', {'type': 'lazyall'}
Pack 'osyo-manga/vim-operator-search', {'type': 'lazyall'}
Pack 'osyo-manga/vim-operator-stay-cursor', {'type': 'lazyall'}
Pack 'pechorin/any-jump.vim', {'type': 'lazyall'}
Pack 'rbtnn/vim-vimscript_lasterror', {'type': 'opt', 'on': ['VimscriptLastError']}
Pack 'rhysd/committia.vim', {'if': !g:is_windows}
Pack 'rhysd/vim-operator-surround', {'type': 'lazyall'}
Pack 'roxma/vim-tmux-clipboard', {'type': 'lazyall', 'if': !g:is_windows}
Pack 'ryanoasis/vim-devicons'
Pack 'sainnhe/gruvbox-material'
Pack 't9md/vim-quickhl'
Pack 'thinca/vim-qfreplace', {'type': 'opt', 'for': ['quickfix', 'qf']}
Pack 'thinca/vim-submode', {'type': 'lazy'}
Pack 'tmux-plugins/vim-tmux-focus-events', {'type': 'lazyall', 'if': !g:is_windows && !has('nvim')}
Pack 'tpope/vim-commentary'
Pack 'tpope/vim-repeat', {'type': 'lazyall'}
Pack 'tsuyoshicho/vim-fg'
Pack 'tyru/capture.vim', {'type': 'opt', 'on': 'Capture'}
Pack 'tyru/columnskip.vim', {'type': 'opt', 'on': ['<Plug>(columnskip-j)', '<Plug>(columnskip-k)']}
Pack 'tyru/open-browser.vim', {'type': 'lazyall'}
Pack 'vim-scripts/autodate.vim', {'type': 'lazyall'}


" Fuzzy: {{{1
if 0
  Pack 'ctrlpvim/ctrlp.vim'
  Pack 'kaneshin/ctrlp-filetype', {'type': 'opt', 'on': 'CtrlPFiletype'}
  Pack 'kaneshin/ctrlp-memolist', {'type': 'opt', 'on': 'CtrlPMemolist'}
  Pack 'kaneshin/ctrlp-sonictemplate', {'type': 'opt', 'on': 'CtrlPSonictemplate'}
  Pack 'mattn/ctrlp-launcher', {'type': 'opt', 'on': 'CtrlPLauncher'}
  Pack 'mattn/ctrlp-mark', {'type': 'opt', 'on': 'CtrlPMark'}
  Pack 'mattn/ctrlp-vimhelpjp', {'type': 'opt', 'on': 'VimHelpJp'}
  Pack 'mattn/ctrlp-ghq', {'type': 'opt', 'on': 'CtrlPGhq'}
  Pack 'ompugao/ctrlp-history', {'type': 'opt', 'on': 'CtrlPCmdHistory'}
  " Pack 'FelikZ/ctrlp-py-matcher'
elseif 0
  Pack 'liuchengxu/vim-clap', {'type': 'opt', 'on': 'Clap', 'do': 'Clap install-binary!'}
elseif 0
  Pack 'yuki-ycino/fzf-preview.vim'
  Pack 'MattesGroeger/vim-bookmarks', {'type': 'lazyall'}
elseif 1
  Pack 'mattn/vim-fz', {'do': 'silent! !go get github.com/mattn/gof'}
  Pack 'mattn/vim-fz-launcher'
else
  Pack 'Shougo/denite.nvim', {'type': 'opt', 'on': ['Denite'], 'do': 'silent! UpdateRemotePlugins'}
  " Pack 'Jagua/vim-denite-ghq', {'type': 'lazyall', 'if': has('nvim')}
  Pack 'pocari/vim-denite-gists', {'type': 'lazyall', 'if': has('nvim')}
  Pack 'pocari/vim-denite-kind-open-browser', {'type': 'lazyall', 'if': has('nvim')}
endif


" Completion: {{{1
if 0
  Pack 'prabirshrestha/async.vim'
  Pack 'prabirshrestha/asyncomplete-lsp.vim'
  Pack 'prabirshrestha/asyncomplete.vim'
  Pack 'prabirshrestha/vim-lsp'
  Pack 'mattn/vim-lsp-icons'
  Pack 'mattn/vim-lsp-settings'
  Pack 'tsuyoshicho/vim-efm-langserver-settings'
  Pack 'hrsh7th/vim-vsnip'
  Pack 'hrsh7th/vim-vsnip-integ'
  Pack 'high-moctane/asyncomplete-nextword.vim', {'do': 'silent !go get -u github.com/high-moctane/nextword', 'if': executable('go') && !g:is_windows}
  Pack 'prabirshrestha/asyncomplete-buffer.vim'
  Pack 'prabirshrestha/asyncomplete-emoji.vim'
  Pack 'prabirshrestha/asyncomplete-file.vim'
  Pack 'tsufeki/asyncomplete-fuzzy-match', {'do': '!cargo build --release', 'if': executable('cargo') && !g:is_windows}
  " Pack 'prabirshrestha/asyncomplete-necosyntax.vim', {'type': 'lazyall'}
  " Pack 'prabirshrestha/asyncomplete-neosnippet.vim', {'type': 'lazyall'}
  " Pack 'prabirshrestha/asyncomplete-tags.vim', {'type': 'lazyall', 'if': !g:is_windows}
  Pack 'voldikss/vim-translator', {'type': 'opt', 'on': ['<Plug>Translate', '<Plug>TranslateV', '<Plug>TranslateW', '<Plug>TranslateWV', '<Plug>TranslateR', '<Plug>TranslateRV']}
  " Pack 'lambdalisue/fern-renderer-devicons.vim', {'type': 'lazyall'}
  " Pack 'lambdalisue/fern.vim'
elseif 1
  Pack 'neoclide/coc.nvim', {'branch': 'release', 'do': 'silent !go get -u github.com/high-moctane/nextword', 'if': executable('go')}
else
  Pack 'Shougo/deoplete.nvim', {'do': '!pip install -U msgpack'}
  Pack 'lighttiger2505/deoplete-vim-lsp'
  Pack 'hrsh7th/vim-vsnip'
  Pack 'hrsh7th/vim-vsnip-integ'
  Pack 'mattn/vim-lsp-icons'
  Pack 'mattn/vim-lsp-settings'
  Pack 'prabirshrestha/async.vim'
  Pack 'prabirshrestha/vim-lsp'
  Pack 'tsuyoshicho/vim-efm-langserver-settings'
  Pack 'voldikss/vim-translator', {'type': 'opt', 'on': ['<Plug>Translate', '<Plug>TranslateV', '<Plug>TranslateW', '<Plug>TranslateWV', '<Plug>TranslateR', '<Plug>TranslateRV']}
  " Pack 'lambdalisue/fern-renderer-devicons.vim', {'type': 'lazyall'}
  " Pack 'lambdalisue/fern.vim'
endif
