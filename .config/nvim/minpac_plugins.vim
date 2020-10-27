" Plugins: {{{1
Pack 'k-takata/minpac', {'type': 'opt'}

" Visual: {{{1
Pack 'LumaKernel/nvim-visual-eof.lua', {'type': 'lazyall', 'if': has('nvim')}
Pack 'andymass/vim-matchup', {'event': 'CursorHold'}
Pack 'itchyny/vim-cursorword', {'event': 'CursorHold'}
Pack 'itchyny/vim-external', {'event': 'CursorHold'}
Pack 'itchyny/vim-highlighturl', {'event': 'CursorHold'}
Pack 'itchyny/vim-parenmatch', {'event': 'CursorHold'}
Pack 'jeffkreeftmeijer/vim-numbertoggle', {'type': 'lazyall'}
Pack 'lambdalisue/glyph-palette.vim'
Pack 'lambdalisue/nerdfont.vim'
Pack 'lambdalisue/seethrough.vim', {'if': !has('gui')}
Pack 'luochen1990/rainbow', {'type': 'lazy'}
Pack 'machakann/vim-highlightedyank', {'type': 'lazyall'}
Pack 'machakann/vim-highlightedundo', {'if': executable('diff'), 'on': ['<Plug>(highlightedundo-undo)', '<Plug>(highlightedundo-redo)', '<Plug>(highlightedundo-Undo)', '<Plug>(highlightedundo-gminus)', '<Plug>(highlightedundo-gplus)']}
Pack 'mattn/transparency-windows-vim', {'if': g:is_windows && !has('nvim')}
Pack 'mattn/vimtweak', {'if': g:is_windows}
Pack 'nathanaelkane/vim-indent-guides', {'event': 'CursorHold'}
Pack 'ntpeters/vim-better-whitespace', {'event': 'CursorHold'}
Pack 't9md/vim-quickhl', {'event': 'CursorHold'}
Pack 'gcavallanti/vim-noscrollbar', {'if': !has('nvim')}
Pack 'camspiers/animate.vim', {'event': 'CursorHold'}
Pack 'camspiers/lens.vim', {'event': 'CursorHold'}

" colorscheme {{{2
Pack 'NLKNguyen/papercolor-theme', {'type': 'opt'}
Pack 'bluz71/vim-nightfly-guicolors', {'type': 'opt'}
Pack 'cocopon/iceberg.vim', {'type': 'opt'}
Pack 'drewtempelmeyer/palenight.vim', {'type': 'opt'}
Pack 'ghifarit53/tokyonight-vim', {'type': 'opt'}
Pack 'gkeep/iceberg-dark', {'type': 'opt'}
Pack 'joshdick/onedark.vim', {'type': 'opt'}
Pack 'kjssad/quantum.vim', {'type': 'opt'}
Pack 'rhysd/vim-color-spring-night', {'type': 'opt'}
Pack 'romgrk/github-light.vim', {'type': 'opt'}
Pack 'sainnhe/gruvbox-material', {'type': 'opt'}
Pack 'severij/vadelma', {'type': 'opt'}
Pack 'yasukotelin/shirotelin', {'type': 'opt'}


" Utility: {{{1
Pack 'AndrewRadev/linediff.vim', {'on': ['Linediff', 'LinediffReset', 'LinediffShow']}
Pack 'LeafCage/yankround.vim', {'type': 'lazyall'}
Pack 'Shougo/context_filetype.vim', {'type': 'lazyall'}
Pack 'Shougo/echodoc.vim', {'event': 'InsertEnter'}
Pack 'airblade/vim-rooter', {'event': 'CursorHold'}
Pack 'aiya000/aho-bakaup.vim', {'event': 'BufWritePre'}
Pack 'chamindra/marvim', {'type': 'lazyall'}
" Pack 'cohama/lexima.vim', {'on': 'InsertEnter'}
Pack 'da-x/name-assign.vim', {'on': '<Plug>NameAssign'}
Pack 'editorconfig/editorconfig-vim', {'event': 'VimEnter'}
Pack 'gelguy/wilder.nvim'
Pack 'haya14busa/vim-edgemotion', {'on': ['<Plug>(edgemotion-j)', '<Plug>(edgemotion-k)']}
Pack 'junegunn/vim-easy-align', {'on': '<Plug>(EasyAlign)'}
Pack 'lambdalisue/readablefold.vim', {'event': 'CursorHold'}
Pack 'lambdalisue/vim-findent', {'on': 'Findent'}
Pack 'liuchengxu/vim-which-key', {'type': 'lazyall'}
Pack 'liuchengxu/vista.vim', {'type': 'lazyall'}
Pack 'mattn/vim-sonictemplate', {'on': 'Template'}
Pack 'mattn/webapi-vim', {'type': 'lazyall'}
Pack 'mbbill/undotree', {'on': 'UndotreeToggle'}
Pack 'nicwest/vim-camelsnek', {'on': ['Snek', 'Camel', 'CamelB', 'Kebab']}
Pack 'psliwka/vim-smoothie', {'type': 'lazyall'}
Pack 'qpkorr/vim-renamer', {'type': 'lazyall'}
Pack 'rbtnn/vim-coloredit', {'on': 'ColorEdit', 'if': !has('nvim')}
Pack 'rbtnn/vim-gloaded'
Pack 'rbtnn/vim-vimscript_lasterror', {'on': 'VimscriptLastError'}
Pack 'rickhowe/diffchar.vim', {'type': 'lazyall'}
Pack 'romainl/vim-qf', {'for': ['quickfix', 'qf']}
Pack 'roxma/nvim-yarp', {'if': !has('nvim')}
Pack 'roxma/vim-hug-neovim-rpc', {'if': !has('nvim')}
Pack 'roxma/vim-tmux-clipboard', {'type': 'lazyall', 'if': !g:is_windows}
Pack 'sentriz/vim-print-debug', {'type': 'lazyall'}
Pack 't9md/vim-choosewin', {'type': 'lazyall'}
Pack 'thinca/vim-ambicmd', {'event': 'VimEnter'}
Pack 'thinca/vim-localrc'
Pack 'thinca/vim-prettyprint', {'on': 'PP'}
Pack 'thinca/vim-qfreplace', {'for': ['quickfix', 'qf']}
Pack 'thinca/vim-singleton', {'if': !has('nvim')}
Pack 'thinca/vim-submode', {'type': 'lazy'}
Pack 'tmux-plugins/vim-tmux-focus-events', {'type': 'lazyall', 'if': !g:is_windows && !has('nvim')}
Pack 'tpope/vim-repeat', {'type': 'lazyall'}
Pack 'tyru/capture.vim', {'on': 'Capture'}
Pack 'tyru/open-browser.vim', {'type': 'lazyall'}
Pack 'tyru/restart.vim', {'on': 'Restart'}
Pack 'vim-scripts/autodate.vim', {'event': 'InsertEnter'}
Pack 'wakatime/vim-wakatime', {'type': 'lazyall'}
Pack 'wesQ3/vim-windowswap', {'event': 'WinEnter'}
Pack 'yegappan/mru', {'on': 'MRU'}

" Comment: {{{1
Pack 'Shougo/junkfile.vim', {'on': 'JunkfileOpen'}
Pack 'glidenote/memolist.vim', {'on': ['MemoNew', 'MemoList', 'MemoGrep']}
Pack 'tyru/caw.vim', {'event': 'CursorMoved'}

" App: {{{1
Pack 'twitvim/twitvim', {'type': 'lazyall'}

" Git: {{{1
Pack 'itchyny/vim-gitbranch', {'type': 'lazyall'}
Pack 'lambdalisue/gina.vim', {'on': 'Gina'}
Pack 'rhysd/committia.vim', {'if': !g:is_windows}
Pack 'rhysd/conflict-marker.vim', {'type': 'lazyall'}

" Textobj: {{{1
Pack 'kana/vim-textobj-user', {'event': 'VimEnter'}

Pack 'gilligan/textobj-lastpaste', {'type': 'lazyall'}
Pack 'kana/vim-textobj-entire', {'type': 'lazyall'}
Pack 'kana/vim-textobj-fold', {'type': 'lazyall'}
Pack 'kana/vim-textobj-function', {'type': 'lazyall'}
Pack 'kana/vim-textobj-indent', {'type': 'lazyall'}
Pack 'kana/vim-textobj-line', {'type': 'lazyall'}
Pack 'machakann/vim-textobj-delimited', {'type': 'lazyall'}
Pack 'mattn/vim-textobj-url', {'type': 'lazyall'}
Pack 'osyo-manga/vim-textobj-multiblock', {'type': 'lazyall'}


" Operator: {{{1
Pack 'kana/vim-operator-user', {'event': 'VimEnter'}

Pack 'kana/vim-operator-replace', {'type': 'lazyall'}
Pack 'osyo-manga/vim-operator-search', {'type': 'lazyall'}
Pack 'osyo-manga/vim-operator-stay-cursor', {'type': 'lazyall'}
Pack 'machakann/vim-sandwich', {'type': 'lazyall'}


" Search: {{{1
Pack 'eugen0329/vim-esearch', {'on': ['<Plug>(esearch)', '<Plug>(esearch-word-under-cursor)']}
Pack 'haya14busa/vim-asterisk', {'type': 'lazyall'}
Pack 'markonm/traces.vim', {'type': 'lazyall'}
Pack 'mhinz/vim-grepper', {'type': 'lazyall'}
Pack 'pechorin/any-jump.vim', {'on_cmd': ['AnyJumpLastResults', 'AnyJumpBack', 'AnyJumpVisual', 'AnyJump']}

" Shell: {{{1
Pack 'Shougo/deol.nvim', {'on': ['Deol', 'DeolCd', 'DeolEdit'], 'do': 'silent! UpdateRemotePlugins'}

" FileType: {{{1
Pack 'sheerun/vim-polyglot'

" markdown {{{2
Pack 'dhruvasagar/vim-table-mode', {'for': 'markdown'}
Pack 'iamcco/markdown-preview.nvim', {'on': 'MarkdownPreview', 'do': '!cd app & yarn install'}
Pack 'previm/previm', {'on': 'PrevimOpen'}

" html {{{2
Pack 'mattn/emmet-vim', {'for': 'html'}

" plantuml # {{{2
Pack 'tsuyoshicho/plantuml-previewer.vim', {'for': 'plantuml'}

" Fuzzy: {{{1
if g:plugin_use_ctrlp
  Pack 'ctrlpvim/ctrlp.vim'
  Pack 'raghur/fruzzy', {'do': 'call fruzzy#install()'}
  Pack 'mattn/ctrlp-matchfuzzy', {'if': exists('matchfuzzy')}

  Pack 'kaneshin/ctrlp-filetype', {'on': 'CtrlPFiletype'}
  Pack 'kaneshin/ctrlp-memolist', {'on': 'CtrlPMemolist'}
  Pack 'kaneshin/ctrlp-sonictemplate', {'on': 'CtrlPSonictemplate'}
  Pack 'mattn/ctrlp-launcher', {'on': 'CtrlPLauncher'}
  Pack 'mattn/ctrlp-mark', {'on': 'CtrlPMark'}
  Pack 'mattn/ctrlp-vimhelpjp', {'on': 'VimHelpJp'}
  Pack 'ompugao/ctrlp-history', {'on': ['CtrlPCmdHistory', 'CtrlPSearchHistory']}
  Pack 'suy/vim-ctrlp-commandline', {'type': 'lazyall'}
endif

if g:plugin_use_clap
  Pack 'liuchengxu/vim-clap', {'on': 'Clap'}
endif


if g:plugin_use_fz
  Pack 'mattn/vim-fz', {'do': 'silent! !go get github.com/mattn/gof'}
  Pack 'mattn/vim-fz-launcher'
endif

if g:plugin_use_denite
  Pack 'Shougo/denite.nvim', {'on': 'Denite', 'do': 'silent! UpdateRemotePlugins'}

  Pack 'mirachan010/vim-denite-plugins', {'type': 'lazyall'}
  Pack 'mirachan010/vim-pluginlist', {'type': 'lazyall'}
  Pack 'pocari/vim-denite-gists', {'type': 'lazyall', 'if': has('nvim')}
  Pack 'pocari/vim-denite-kind-open-browser', {'type': 'lazyall', 'if': has('nvim')}
endif


if g:plugin_use_lightline
  Pack 'itchyny/lightline.vim', {'event': ['CursorHold', 'CursorMoved']}
endif

if g:plugin_use_airline
  Pack 'vim-airline/vim-airline'

  Pack 'vim-airline/vim-airline-themes'
endif

if g:plugin_use_fern
  Pack 'lambdalisue/fern.vim'
  Pack 'lambdalisue/fern-hijack.vim'

  Pack 'lambdalisue/fern-git-status.vim', {'type': 'lazyall'}
  Pack 'lambdalisue/fern-git.vim', {'type': 'lazyall'}
  Pack 'lambdalisue/fern-mapping-git.vim', {'type': 'lazyall'}
  Pack 'lambdalisue/fern-bookmark.vim', {'type': 'lazyall'}
  Pack 'lambdalisue/fern-comparator-lexical.vim', {'type': 'lazyall'}
  Pack 'lambdalisue/fern-renderer-nerdfont.vim', {'type': 'lazyall'}
endif

if g:plugin_use_molder
  Pack 'mattn/vim-molder'
  Pack 'mattn/vim-molder-operations'
endif

if g:plugin_use_vaffle
  Pack 'cocopon/vaffle.vim', {'on': 'Vaffle'}
endif

if g:plugin_use_defx
  Pack 'Shougo/defx.nvim', {'on': 'Defx', 'do': 'silent! UpdateRemotePlugins'}

  Pack 'kristijanhusak/defx-icons', {'type': 'opt'}
endif


" Completion: {{{1
Pack 'honza/vim-snippets', {'event': 'InsertEnter'}

if g:plugin_use_asyncomplete
  Pack 'prabirshrestha/asyncomplete.vim'

  Pack 'high-moctane/asyncomplete-nextword.vim', {'do': 'silent! !go get -u github.com/high-moctane/nextword', 'if': executable('go') && !g:is_windows}
  Pack 'hrsh7th/vim-vsnip'
  Pack 'hrsh7th/vim-vsnip-integ'
  Pack 'mattn/vim-lsp-icons'
  Pack 'mattn/vim-lsp-settings'
  Pack 'prabirshrestha/async.vim'
  Pack 'prabirshrestha/asyncomplete-buffer.vim'
  Pack 'prabirshrestha/asyncomplete-emoji.vim'
  Pack 'prabirshrestha/asyncomplete-file.vim'
  Pack 'prabirshrestha/asyncomplete-lsp.vim'
  Pack 'prabirshrestha/vim-lsp'
  Pack 'tsuyoshicho/vim-efm-langserver-settings'
  Pack 'voldikss/vim-translator', {'on': ['<Plug>Translate', '<Plug>TranslateV', '<Plug>TranslateW', '<Plug>TranslateWV', '<Plug>TranslateR', '<Plug>TranslateRV']}
endif

if g:plugin_use_coc
  Pack 'neoclide/coc.nvim', {'branch': 'release', 'do': 'silent! !go get -u github.com/high-moctane/nextword', 'if': executable('go')}
endif

if g:plugin_use_deoplete
  Pack 'Shougo/deoplete.nvim', {'do': '!pip install -U msgpack'}

  Pack 'lighttiger2505/deoplete-vim-lsp'
  Pack 'mattn/vim-lsp-icons'
  Pack 'mattn/vim-lsp-settings'
  Pack 'prabirshrestha/async.vim'
  Pack 'prabirshrestha/vim-lsp'
  Pack 'tsuyoshicho/vim-efm-langserver-settings'
  Pack 'voldikss/vim-translator', {'on': ['<Plug>Translate', '<Plug>TranslateV', '<Plug>TranslateW', '<Plug>TranslateWV', '<Plug>TranslateR', '<Plug>TranslateRV']}
endif


" Runner: {{{1
Pack 'thinca/vim-quickrun', {'on': ['QuickRun', '<Plug>(quickrun)']}
Pack 'lambdalisue/vim-quickrun-neovim-job', {'type': 'lazyall'}


" vim:fdm=marker expandtab fdc=3 ft=vim ts=2 sw=2 sts=2:
