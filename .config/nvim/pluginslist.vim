let g:lazy_events = ['CursorHold', 'CursorMoved', 'FocusLost']

" Plugins:
Pg 'k-takata/minpac', {'type': 'opt'}
Pg 'kristijanhusak/vim-packager', {'type': 'opt'}

" Visual:
" Pg 'Xuyuanp/scrollbar.nvim', {'if': has('nvim') && !g:is_windows}
Pg 'LumaKernel/nvim-visual-eof.lua', {'if': has('nvim')}
Pg 'andymass/vim-matchup', {'event': g:lazy_events}
Pg 'dstein64/nvim-scrollview', {'event': g:lazy_events, 'if': has('nvim') && !g:is_windows}
Pg 'glepnir/indent-guides.nvim', {'event': g:lazy_events, 'if': has('nvim')}
Pg 'itchyny/vim-cursorword', {'event': g:lazy_events}
Pg 'itchyny/vim-external', {'event': g:lazy_events}
Pg 'itchyny/vim-highlighturl', {'event': g:lazy_events}
Pg 'itchyny/vim-parenmatch', {'event': g:lazy_events}
Pg 'jeffkreeftmeijer/vim-numbertoggle', {'event': g:lazy_events}
Pg 'kyazdani42/nvim-web-devicons'
Pg 'lambdalisue/glyph-palette.vim', {'event': 'VimEnter'}
Pg 'lambdalisue/nerdfont.vim', {'event': 'VimEnter'}
Pg 'lambdalisue/seethrough.vim', {'if': !has('gui')}
Pg 'luochen1990/rainbow', {'event': g:lazy_events}
Pg 'machakann/vim-highlightedyank', {'event': 'VimEnter'}
Pg 'mattn/transparency-windows-vim', {'if': g:is_windows && !has('nvim')}
Pg 'mattn/vimtweak', {'if': g:is_windows}
Pg 'mg979/vim-xtabline', {'event': 'VimEnter', 'if': !has('nvim')}
Pg 'nathanaelkane/vim-indent-guides', {'event': g:lazy_events, 'if': !has('nvim')}
Pg 'ntpeters/vim-better-whitespace', {'event': g:lazy_events}
Pg 'romgrk/barbar.nvim', {'if': has('nvim')}
Pg 't9md/vim-quickhl', {'event': g:lazy_events}

" Colorscheme:
Pg 'JKirchartz/vim-colors-megapack', {'type': 'opt'}
Pg 'NLKNguyen/papercolor-theme', {'type': 'opt'}
Pg 'adrian5/oceanic-next-vim', {'type': 'opt'}
Pg 'ayu-theme/ayu-vim', {'type': 'opt'}
Pg 'bluz71/vim-nightfly-guicolors', {'type': 'opt'}
Pg 'cocopon/iceberg.vim', {'type': 'opt'}
Pg 'drewtempelmeyer/palenight.vim', {'type': 'opt'}
Pg 'flazz/vim-colorschemes', {'type': 'opt'}
Pg 'ghifarit53/tokyonight-vim', {'type': 'opt'}
Pg 'gkeep/iceberg-dark', {'type': 'opt'}
Pg 'glepnir/zephyr-nvim', {'type': 'opt'}
Pg 'joshdick/onedark.vim', {'type': 'opt'}
Pg 'kjssad/quantum.vim', {'type': 'opt'}
Pg 'rafi/awesome-vim-colorschemes', {'type': 'opt'}
Pg 'rakr/vim-one', {'type': 'opt'}
Pg 'rhysd/vim-color-spring-night', {'type': 'opt'}
Pg 'romgrk/github-light.vim', {'type': 'opt'}
Pg 'sainnhe/edge', {'type': 'opt'}
Pg 'sainnhe/gruvbox-material', {'type': 'opt'}
Pg 'severij/vadelma', {'type': 'opt'}
Pg 'ulwlu/elly.vim', {'type': 'opt'}
Pg 'yasukotelin/shirotelin', {'type': 'opt'}

" Utility:
Pg 'AndrewRadev/linediff.vim', {'cmd': ['Linediff', 'LinediffReset', 'LinediffShow']}
Pg 'LeafCage/yankround.vim', {'event': 'VimEnter'}
Pg 'Shougo/context_filetype.vim', {'event': 'VimEnter'}
Pg 'Shougo/echodoc.vim', {'event': 'InsertEnter'}
Pg 'Shougo/junkfile.vim', {'cmd': 'JunkfileOpen'}
Pg 'airblade/vim-rooter', {'event': g:lazy_events}
Pg 'aiya000/aho-bakaup.vim', {'event': 'BufWritePre'}
Pg 'da-x/name-assign.vim', {'event': 'VimEnter'}
Pg 'editorconfig/editorconfig-vim', {'event': 'VimEnter'}
Pg 'gelguy/wilder.nvim'
Pg 'glidenote/memolist.vim', {'cmd': ['MemoNew', 'MemoList', 'MemoGrep']}
Pg 'haya14busa/vim-edgemotion', {'event': g:lazy_events}
Pg 'junegunn/vim-easy-align', {'event': g:lazy_events}
Pg 'lambdalisue/readablefold.vim', {'event': g:lazy_events}
Pg 'lambdalisue/vim-findent', {'cmd': 'Findent'}
Pg 'lilydjwg/colorizer', {'event': 'VimEnter'}
Pg 'liuchengxu/vim-which-key', {'event': 'VimEnter'}
Pg 'liuchengxu/vista.vim', {'event': 'VimEnter'}
Pg 'mattn/vim-sonictemplate', {'cmd': 'Template'}
Pg 'mattn/webapi-vim', {'event': 'VimEnter'}
Pg 'mbbill/undotree', {'cmd': 'UndotreeToggle'}
Pg 'nicwest/vim-camelsnek', {'cmd': ['Snek', 'Camel', 'CamelB', 'Kebab']}
Pg 'qpkorr/vim-renamer', {'event': 'VimEnter'}
Pg 'rbtnn/vim-coloredit', {'cmd': 'ColorEdit', 'if': !has('nvim')}
Pg 'rbtnn/vim-gloaded'
Pg 'rbtnn/vim-vimscript_lasterror', {'cmd': 'VimscriptLastError'}
Pg 'rickhowe/diffchar.vim', {'event': 'VimEnter'}
Pg 'romainl/vim-qf', {'ft': ['quickfix', 'qf']}
Pg 'roxma/nvim-yarp', {'if': !has('nvim')}
Pg 'roxma/vim-hug-neovim-rpc', {'if': !has('nvim')}
Pg 'roxma/vim-tmux-clipboard', {'event': 'VimEnter', 'if': !g:is_windows}
Pg 'sentriz/vim-print-debug', {'event': 'VimEnter'}
Pg 'seroqn/tozzy.vim', {'event': 'InsertEnter'}
Pg 't9md/vim-choosewin', {'event': 'VimEnter'}
Pg 'tenfyzhong/axring.vim', {'event': 'VimEnter'}
Pg 'thinca/vim-ambicmd', {'event': 'VimEnter'}
Pg 'thinca/vim-localrc'
Pg 'thinca/vim-prettyprint', {'cmd': 'PP'}
Pg 'thinca/vim-qfreplace', {'ft': ['quickfix', 'qf']}
Pg 'thinca/vim-singleton', {'if': !has('nvim') && has('clientserver')}
Pg 'thinca/vim-submode', {'event': 'VimEnter'}
Pg 'tmux-plugins/vim-tmux-focus-events', {'event': 'VimEnter', 'if': !g:is_windows && !has('nvim')}
Pg 'tpope/vim-repeat', {'event': 'VimEnter'}
Pg 'tyru/capture.vim', {'cmd': 'Capture'}
Pg 'tyru/open-browser.vim', {'event': 'VimEnter'}
Pg 'tyru/restart.vim', {'cmd': 'Restart'}
Pg 'vim-scripts/autodate.vim', {'event': 'InsertEnter'}
Pg 'wesQ3/vim-windowswap', {'event': 'WinEnter'}
Pg 'yegappan/mru', {'cmd': 'MRU'}
Pg 'tweekmonster/startuptime.vim', {'cmd': 'StartupTime'}

" Comment:
Pg 'tyru/caw.vim', {'event': g:lazy_events}

" App:
Pg 'twitvim/twitvim', {'event': 'VimEnter'}

" Git:
Pg 'itchyny/vim-gitbranch', {'event': 'VimEnter'}
Pg 'lambdalisue/gina.vim', {'cmd': 'Gina'}
Pg 'rhysd/committia.vim', {'if': !g:is_windows}
Pg 'rhysd/conflict-marker.vim', {'event': 'VimEnter'}

" Textobj:
Pg 'kana/vim-textobj-user'

Pg 'gilligan/textobj-lastpaste', {'event': 'VimEnter'}
Pg 'kana/vim-textobj-entire', {'event': 'VimEnter'}
Pg 'kana/vim-textobj-fold', {'event': 'VimEnter'}
Pg 'kana/vim-textobj-function', {'event': 'VimEnter'}
Pg 'kana/vim-textobj-indent', {'event': 'VimEnter'}
Pg 'kana/vim-textobj-line', {'event': 'VimEnter'}
Pg 'machakann/vim-swap', {'event': 'VimEnter'}
Pg 'machakann/vim-textobj-delimited', {'event': 'VimEnter'}
Pg 'mattn/vim-textobj-url', {'event': 'VimEnter'}
Pg 'osyo-manga/vim-textobj-multiblock', {'event': 'VimEnter'}


" Operator:
Pg 'kana/vim-operator-user'

Pg 'kana/vim-operator-replace', {'event': 'VimEnter'}
Pg 'machakann/vim-sandwich', {'event': 'VimEnter'}
Pg 'osyo-manga/vim-operator-search', {'event': 'VimEnter'}
Pg 'osyo-manga/vim-operator-stay-cursor', {'event': 'VimEnter'}


" Search:
Pg 'eugen0329/vim-esearch', {'event': 'VimEnter'}
Pg 'haya14busa/vim-asterisk', {'event': 'VimEnter'}
Pg 'kevinhwang91/nvim-hlslens', {'event': 'VimEnter', 'if': has('nvim')}
Pg 'markonm/traces.vim', {'event': 'VimEnter'}
Pg 'mhinz/vim-grepper', {'event': 'VimEnter'}
Pg 'pechorin/any-jump.vim', {'cmd': ['AnyJumpLastResults', 'AnyJumpBack', 'AnyJumpVisual', 'AnyJump']}
Pg 'ripxorip/aerojump.nvim', {'event': 'VimEnter', 'if': has('nvim')}

" Shell:
Pg 'Shougo/deol.nvim', {'cmd': ['Deol', 'DeolCd', 'DeolEdit'], 'do': 'silent! UpdateRemotePlugins'}

" FileType:
Pg 'sheerun/vim-polyglot'

" markdown
Pg 'plasticboy/vim-markdown', {'ft': 'markdown'}
Pg 'dkarter/bullets.vim', {'ft': 'markdown'}
Pg 'dhruvasagar/vim-table-mode', {'ft': 'markdown'}
Pg 'iamcco/markdown-preview.nvim', {'cmd': 'MarkdownPreview', 'do': '!cd app & yarn install', 'if': executable('yarn')}
Pg 'previm/previm', {'cmd': 'PrevimOpen'}

" html
Pg 'mattn/emmet-vim', {'ft': 'html'}

" plantuml
Pg 'tsuyoshicho/plantuml-previewer.vim', {'ft': 'plantuml'}

" Fuzzy:
if g:plugin_use_ctrlp
  Pg 'ctrlpvim/ctrlp.vim'

  Pg 'kaneshin/ctrlp-filetype', {'cmd': 'CtrlPFiletype'}
  Pg 'kaneshin/ctrlp-memolist', {'cmd': 'CtrlPMemolist'}
  Pg 'kaneshin/ctrlp-sonictemplate', {'cmd': 'CtrlPSonictemplate'}
  Pg 'mattn/ctrlp-launcher', {'cmd': 'CtrlPLauncher'}
  Pg 'mattn/ctrlp-mark', {'cmd': 'CtrlPMark'}
  Pg 'mattn/ctrlp-matchfuzzy', {'if': exists('*matchfuzzy')}
  Pg 'mattn/ctrlp-vimhelpjp', {'cmd': 'VimHelpJp'}
  Pg 'ompugao/ctrlp-history', {'cmd': ['CtrlPCmdHistory', 'CtrlPSearchHistory']}
  Pg 'raghur/fruzzy', {'do': 'call fruzzy#install()', 'if': has('python')}
  Pg 'suy/vim-ctrlp-commandline', {'event': 'VimEnter'}
endif

if g:plugin_use_clap
  Pg 'liuchengxu/vim-clap', {'cmd': 'Clap'}
endif


if g:plugin_use_fz
  Pg 'mattn/vim-fz', {'do': 'silent! !go get github.com/mattn/gof'}
  Pg 'mattn/vim-fz-launcher'
endif

if g:plugin_use_denite
  Pg 'Shougo/denite.nvim', {'cmd': 'Denite', 'do': 'silent! UpdateRemotePlugins'}

  Pg 'mirachan010/vim-denite-plugins', {'event': 'VimEnter'}
  Pg 'mirachan010/vim-pluginlist', {'event': 'VimEnter'}
  Pg 'pocari/vim-denite-gists', {'event': 'VimEnter', 'if': has('nvim')}
  Pg 'pocari/vim-denite-kind-open-browser', {'event': 'VimEnter', 'if': has('nvim')}
endif


if g:plugin_use_lightline
  Pg 'itchyny/lightline.vim', {'event': g:lazy_events}
endif

if g:plugin_use_airline
  Pg 'vim-airline/vim-airline'

  Pg 'vim-airline/vim-airline-themes'
endif

if g:plugin_use_lualine
  Pg 'hoob3rt/lualine.nvim'
endif

if g:plugin_use_neoline
  Pg 'adelarsq/neoline.vim'
endif

if g:plugin_use_fern
  Pg 'lambdalisue/fern.vim'
  Pg 'lambdalisue/fern-hijack.vim'

  Pg 'lambdalisue/fern-bookmark.vim', {'event': 'VimEnter'}
  Pg 'lambdalisue/fern-comparator-lexical.vim', {'event': 'VimEnter'}
  Pg 'lambdalisue/fern-git-status.vim', {'event': 'VimEnter'}
  Pg 'lambdalisue/fern-git.vim', {'event': 'VimEnter'}
  Pg 'lambdalisue/fern-mapping-git.vim', {'event': 'VimEnter'}
  Pg 'lambdalisue/fern-renderer-nerdfont.vim', {'event': 'VimEnter'}
endif

if g:plugin_use_molder
  Pg 'mattn/vim-molder'
  Pg 'mattn/vim-molder-operations'
endif

if g:plugin_use_vaffle
  Pg 'cocopon/vaffle.vim', {'cmd': 'Vaffle'}
endif

if g:plugin_use_defx
  Pg 'Shougo/defx.nvim', {'cmd': 'Defx', 'do': 'silent! UpdateRemotePlugins'}

  Pg 'kristijanhusak/defx-icons', {'type': 'opt'}
  Pg 'kristijanhusak/defx-git', {'type': 'opt'}
endif

if g:plugin_use_fzf
  Pg 'junegunn/fzf', {'do': {-> fzf#install()}}
  Pg 'yuki-ycino/fzf-preview.vim', {'branch': 'release/rpc'}
endif
if g:plugin_use_cocfzf
  Pg 'junegunn/fzf', {'do': {-> fzf#install()}}
  Pg 'yuki-ycino/fzf-preview.vim', {'branch': 'release/remote'}
endif

if g:plugin_use_telescope
  Pg 'nvim-lua/plenary.nvim'
  Pg 'nvim-lua/popup.nvim'
  Pg 'nvim-telescope/telescope.nvim'
endif


" Completion:
Pg 'honza/vim-snippets', {'event': 'InsertEnter'}

if g:plugin_use_asyncomplete
  Pg 'prabirshrestha/asyncomplete.vim'

  Pg 'high-moctane/asyncomplete-nextword.vim', {'do': 'silent! !go get -u github.com/high-moctane/nextword', 'if': executable('go')}
  Pg 'hrsh7th/vim-vsnip'
  Pg 'hrsh7th/vim-vsnip-integ'
  Pg 'mattn/vim-lsp-icons'
  Pg 'mattn/vim-lsp-settings'
  Pg 'prabirshrestha/async.vim'
  Pg 'prabirshrestha/asyncomplete-buffer.vim'
  Pg 'prabirshrestha/asyncomplete-emoji.vim'
  Pg 'prabirshrestha/asyncomplete-file.vim'
  Pg 'prabirshrestha/asyncomplete-lsp.vim'
  Pg 'prabirshrestha/vim-lsp'
  Pg 'tsuyoshicho/vim-efm-langserver-settings'
  Pg 'voldikss/vim-translator', {'cmd': ['<Plug>Translate', '<Plug>TranslateV', '<Plug>TranslateW', '<Plug>TranslateWV', '<Plug>TranslateR', '<Plug>TranslateRV']}
endif

if g:plugin_use_coc
  Pg 'neoclide/coc.nvim', {'branch': 'release', 'do': 'silent! !go get -u github.com/high-moctane/nextword', 'if': executable('go')}
endif

if g:plugin_use_deoplete
  Pg 'Shougo/deoplete.nvim', {'do': '!pip install -U msgpack'}

  Pg 'lighttiger2505/deoplete-vim-lsp'
  Pg 'mattn/vim-lsp-icons'
  Pg 'mattn/vim-lsp-settings'
  Pg 'prabirshrestha/async.vim'
  Pg 'prabirshrestha/vim-lsp'
  Pg 'tsuyoshicho/vim-efm-langserver-settings'
  Pg 'voldikss/vim-translator', {'cmd': ['<Plug>Translate', '<Plug>TranslateV', '<Plug>TranslateW', '<Plug>TranslateWV', '<Plug>TranslateR', '<Plug>TranslateRV']}
endif

" Runner:
Pg 'thinca/vim-quickrun', {'cmd': ['QuickRun', '<Plug>(quickrun)']}
Pg 'lambdalisue/vim-quickrun-neovim-job', {'event': 'VimEnter'}


" vim:fdm=marker expandtab fdc=3 ft=vim ts=2 sw=2 sts=2:
