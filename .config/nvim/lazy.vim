" Pack 'Konfekt/FastFold', {'type': 'lazy'}
" Pack 'RRethy/vim-illuminate', {'type': 'lazy'}
" Pack 'Shougo/neomru.vim', {'type': 'lazy'}
" Pack 'Shougo/neosnippet-snippets', {'type': 'lazy'}
" Pack 'Shougo/neosnippet.vim', {'type': 'lazy'}
" Pack 'Shougo/vimproc.vim', {'type': 'lazy', 'do': 'silent! !make'}
" Pack 'TaDaa/vimade', {'type': 'lazy'}
" Pack 'bfredl/nvim-miniyank', {'type': 'lazy'}
" Pack 'cohama/lexima.vim', {'type': 'lazy'}
" Pack 'dense-analysis/ale', {'type': 'lazy'}
" Pack 'gko/vim-coloresque', {'type': 'lazy'}
" Pack 'haya14busa/is.vim', {'type': 'lazy'}
" Pack 'hotwatermorning/auto-git-diff', {'type': 'lazy'}
" Pack 'iyuuya/denite-ale', {'type': 'lazy'}
" Pack 'jeffkreeftmeijer/vim-numbertoggle', {'type': 'lazy'}
" Pack 'kassio/neoterm', {'type': 'lazy', 'if': has('nvim')}
" Pack 'machakann/vim-highlightedyank', {'type': 'lazy'}
" Pack 'mox-mox/vim-localsearch', {'type': 'lazy'}
" Pack 'osyo-manga/vim-anzu', {'type': 'lazy'}
" Pack 'osyo-manga/vim-jplus', {'type': 'lazy'}
" Pack 'osyo-manga/vim-precious', {'type': 'lazy'}
" Pack 'rhysd/clever-f.vim', {'type': 'lazy'}
" Pack 'skywind3000/vim-quickui', {'type': 'lazy'}
" Pack 'taku-o/vim-zoom', {'type': 'lazy'}
" Pack 'thinca/vim-localrc', {'type': 'lazy'}
" Pack 'unblevable/quick-scope', {'type': 'lazy'}
" Pack 'vim-scripts/matchit.zip', {'type': 'lazy'}
Pack 'LeafCage/yankround.vim', {'type': 'lazy'}
Pack 'MaxMEllon/vim-shiny', {'type': 'lazy'}
Pack 'Shougo/context_filetype.vim', {'type': 'lazy'}
Pack 'Shougo/echodoc.vim', {'type': 'lazy'}
Pack 'airblade/vim-gitgutter', {'type': 'lazy'}
Pack 'airblade/vim-rooter', {'type': 'lazy'}
Pack 'andymass/vim-matchup', {'type': 'lazy'}
Pack 'editorconfig/editorconfig-vim', {'type': 'lazy'}
Pack 'fuenor/qfixgrep', {'type': 'lazy'}
Pack 'fuenor/qfixhowm', {'type': 'lazy'}
Pack 'gilligan/textobj-lastpaste', {'type': 'lazy'}
Pack 'haya14busa/vim-asterisk', {'type': 'lazy'}
Pack 'haya14busa/vim-edgemotion', {'type': 'lazy'}
Pack 'haya14busa/vim-operator-flashy', {'type': 'lazy'}
Pack 'honza/vim-snippets', {'type': 'lazy'}
Pack 'itchyny/vim-cursorword', {'type': 'lazy'}
Pack 'itchyny/vim-external', {'type': 'lazy'}
Pack 'itchyny/vim-highlighturl', {'type': 'lazy'}
Pack 'kana/vim-operator-replace', {'type': 'lazy'}
Pack 'kana/vim-textobj-entire', {'type': 'lazy'}
Pack 'kana/vim-textobj-fold', {'type': 'lazy'}
Pack 'kana/vim-textobj-function', {'type': 'lazy'}
Pack 'kana/vim-textobj-indent', {'type': 'lazy'}
Pack 'kana/vim-textobj-line', {'type': 'lazy'}
Pack 'kshenoy/vim-signature', {'type': 'lazy'}
Pack 'lambdalisue/suda.vim', {'type': 'lazy'}
Pack 'ludovicchabant/vim-gutentags', {'type': 'lazy', 'if': executable('ctags')}
Pack 'markonm/traces.vim', {'type': 'lazy'}
Pack 'mattn/webapi-vim', {'type': 'lazy'}
Pack 'ntpeters/vim-better-whitespace', {'type': 'lazy'}
Pack 'osyo-manga/vim-operator-blockwise', {'type': 'lazy'}
Pack 'osyo-manga/vim-operator-search', {'type': 'lazy'}
Pack 'osyo-manga/vim-textobj-multiblock', {'type': 'lazy'}
Pack 'rhysd/accelerated-jk', {'type': 'lazy'}
Pack 'rhysd/vim-operator-surround', {'type': 'lazy'}
Pack 'roxma/vim-tmux-clipboard', {'type': 'lazy', 'if': !g:is_windows}
Pack 'thinca/vim-submode', {'type': 'lazy'}
Pack 'tmux-plugins/vim-tmux-focus-events', {'type': 'lazy', 'if': !g:is_windows && !has('nvim')}
Pack 'tpope/vim-obsession', {'type': 'lazy'}
Pack 'tpope/vim-repeat', {'type': 'lazy'}
Pack 'tyru/open-browser.vim', {'type': 'lazy'}
Pack 'vim-scripts/autodate.vim', {'type': 'lazy'}
Pack 'yuttie/comfortable-motion.vim', {'type': 'lazy'}


if 1
  Pack 'prabirshrestha/async.vim'
  Pack 'prabirshrestha/asyncomplete-lsp.vim'
  Pack 'prabirshrestha/asyncomplete.vim'
  Pack 'prabirshrestha/vim-lsp'
  Pack 'mattn/vim-lsp-icons'
  Pack 'mattn/vim-lsp-settings'
  Pack 'hrsh7th/vim-vsnip'
  Pack 'hrsh7th/vim-vsnip-integ'
  Pack 'prabirshrestha/asyncomplete-buffer.vim'
  Pack 'prabirshrestha/asyncomplete-emoji.vim'
  Pack 'prabirshrestha/asyncomplete-file.vim'
  Pack 'tsufeki/asyncomplete-fuzzy-match', {'do': '!cargo build --release', 'if': executable('cargo')}
  " Pack 'prabirshrestha/asyncomplete-necosyntax.vim', {'type': 'lazy'}
  " Pack 'prabirshrestha/asyncomplete-neosnippet.vim', {'type': 'lazy'}
  " Pack 'prabirshrestha/asyncomplete-tags.vim', {'type': 'lazy', 'if': !g:is_windows}
else
  Pack 'neoclide/coc.nvim', {'type': 'lazy', 'branch': 'release', 'on': ['CocList', 'CocListResume']}
endif
