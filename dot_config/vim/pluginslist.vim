let g:lazy_events = ['CursorHold', 'FocusLost']

" Plugins:
Pg 'k-takata/minpac', {'type': 'opt'}
Pg 'kristijanhusak/vim-packager', {'type': 'opt'}

" Visual:
" Pg 'Xuyuanp/scrollbar.nvim', {'if': has('nvim') && !g:is_windows}
" Pg 'Yggdroot/indentLine', {'event': g:lazy_events}
" Pg 'dstein64/nvim-scrollview', {'event': g:lazy_events, 'if': has('nvim') && !g:is_windows}
" Pg 'glepnir/indent-guides.nvim', {'event': g:lazy_events, 'if': has('nvim')}
" Pg 'itchyny/vim-external', {'event': g:lazy_events}
" Pg 'jeffkreeftmeijer/vim-numbertoggle', {'event': g:lazy_events}
" Pg 'machakann/vim-highlightedyank', {'event': 'VimEnter'}
" Pg 'mg979/vim-xtabline', {'event': 'VimEnter'}
" Pg 'nathanaelkane/vim-indent-guides', {'event': g:lazy_events, 'if': !has('nvim')}
" Pg 'romgrk/barbar.nvim', {'if': has('nvim')}
Pg 'LumaKernel/nvim-visual-eof.lua', {'if': has('nvim')}
Pg 'andymass/vim-matchup', {'event': g:lazy_events}
Pg 'itchyny/vim-cursorword', {'event': g:lazy_events}
Pg 'itchyny/vim-highlighturl', {'event': g:lazy_events}
Pg 'itchyny/vim-parenmatch', {'event': g:lazy_events}
Pg 'kyazdani42/nvim-web-devicons'
Pg 'lambdalisue/vim-glyph-palette', {'event': 'VimEnter', 'if': g:plugin_use_fern}
Pg 'lambdalisue/vim-nerdfont', {'event': 'VimEnter', 'if': g:plugin_use_fern}
Pg 'lambdalisue/vim-seethrough', {'if': !has('gui')}
Pg 'lukas-reineke/indent-blankline.nvim', {'if': has('nvim'), 'event': 'VimEnter'}
Pg 'luochen1990/rainbow', {'event': g:lazy_events}
Pg 'mattn/transparency-windows-vim', {'if': g:is_windows && !has('nvim')}
Pg 'mattn/vimtweak', {'if': g:is_windows && !has('nvim')}
Pg 'mopp/smartnumber.vim', {'event': g:lazy_events}
Pg 'ntpeters/vim-better-whitespace', {'event': g:lazy_events}
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
Pg 'Matsuuu/pinkmare', {'type': 'opt'}

" Utility:
" Pg 'aiya000/aho-bakaup.vim', {'event': 'BufWritePre'}
" Pg 'gelguy/wilder.nvim', {'event': ['CmdlineEnter', 'CmdwinEnter']}
" Pg 'liuchengxu/vim-which-key', {'event': 'VimEnter'}
" Pg 'liuchengxu/vista.vim', {'event': 'VimEnter'}
" Pg 'psliwka/vim-smoothie', {'event': g:lazy_events}
" Pg 'romainl/vim-qf', {'ft': ['quickfix', 'qf']}
" Pg 'seroqn/tozzy.vim', {'event': 'InsertEnter'}
" Pg 'tenfyzhong/axring.vim', {'event': 'VimEnter'}
" Pg 'yegappan/mru', {'cmd': 'MRU'}
Pg 'AndrewRadev/linediff.vim', {'cmd': ['Linediff', 'LinediffReset', 'LinediffShow']}
Pg 'LeafCage/autobackup.vim', {'event': 'BufWritePre'}
Pg 'LeafCage/yankround.vim', {'event': 'VimEnter'}
Pg 'Shougo/context_filetype.vim', {'event': 'BufRead'}
Pg 'Shougo/echodoc.vim', {'event': 'VimEnter'}
Pg 'Shougo/junkfile.vim', {'cmd': 'JunkfileOpen'}
Pg 'airblade/vim-rooter', {'event': g:lazy_events}
Pg 'cohama/lexima.vim', {'if': g:plugin_use_lexima}
Pg 'da-x/name-assign.vim', {'event': 'VimEnter'}
Pg 'editorconfig/editorconfig-vim', {'event': 'VimEnter'}
Pg 'glidenote/memolist.vim', {'cmd': ['MemoNew', 'MemoList', 'MemoGrep']}
Pg 'haya14busa/vim-edgemotion', {'event': g:lazy_events}
Pg 'hrsh7th/vim-seak', {'event': 'BufRead'}
Pg 'itchyny/vim-winfix', {'event': 'BufRead'}
Pg 'junegunn/vim-easy-align', {'event': g:lazy_events}
Pg 'kwkarlwang/bufresize.nvim', {'event': g:lazy_events}
Pg 'lambdalisue/vim-mr-quickfix'
Pg 'lambdalisue/vim-mr'
Pg 'lambdalisue/vim-readablefold', {'event': g:lazy_events}
Pg 'lambdalisue/vim-backslash', {'ft': 'vim'}
Pg 'lambdalisue/vim-findent', {'cmd': 'Findent'}
Pg 'lilydjwg/colorizer', {'event': g:lazy_events}
Pg 'mattn/vim-lexiv', {'if': g:plugin_use_lexiv}
Pg 'mattn/vim-sonictemplate', {'cmd': 'Template'}
Pg 'mattn/webapi-vim', {'event': 'VimEnter'}
Pg 'mbbill/undotree', {'cmd': 'UndotreeToggle'}
Pg 'nicwest/vim-camelsnek', {'cmd': ['Snek', 'Camel', 'CamelB', 'Kebab']}
Pg 'qpkorr/vim-renamer', {'event': 'VimEnter'}
Pg 'rbtnn/vim-coloredit', {'cmd': 'ColorEdit', 'if': !has('nvim')}
Pg 'rbtnn/vim-gloaded'
Pg 'rbtnn/vim-vimscript_lasterror', {'cmd': 'VimscriptLastError'}
Pg 'rcarriga/nvim-notify', {'event': g:lazy_events}
Pg 'rickhowe/diffchar.vim', {'event': 'VimEnter'}
Pg 'roxma/nvim-yarp', {'if': !has('nvim')}
Pg 'roxma/vim-hug-neovim-rpc', {'if': !has('nvim')}
Pg 'roxma/vim-tmux-clipboard', {'event': 'VimEnter', 'if': !g:is_windows}
Pg 'sentriz/vim-print-debug', {'event': 'VimEnter'}
Pg 't9md/vim-choosewin', {'event': 'VimEnter'}
Pg 'thinca/vim-ambicmd', {'event': 'VimEnter'}
Pg 'thinca/vim-localrc'
Pg 'thinca/vim-prettyprint', {'cmd': 'PP'}
Pg 'thinca/vim-qfreplace', {'ft': ['quickfix', 'qf']}
Pg 'thinca/vim-singleton', {'if': !has('nvim') && has('clientserver')}
Pg 'thinca/vim-submode', {'event': 'BufRead'}
Pg 'tmux-plugins/vim-tmux-focus-events', {'event': 'VimEnter', 'if': !g:is_windows && !has('nvim')}
Pg 'tpope/vim-repeat', {'event': 'VimEnter'}
Pg 'tweekmonster/startuptime.vim', {'cmd': 'StartupTime'}
Pg 'tyru/capture.vim', {'cmd': 'Capture'}
Pg 'tyru/open-browser.vim', {'event': 'VimEnter'}
Pg 'tyru/restart.vim', {'cmd': 'Restart'}
Pg 'vim-scripts/autodate.vim', {'event': 'InsertEnter'}
Pg 'wesQ3/vim-windowswap', {'event': 'WinEnter'}

" Comment:
Pg 'tyru/caw.vim', {'event': g:lazy_events}

" App:
Pg 'twitvim/twitvim', {'event': 'VimEnter'}

" Git:
Pg 'itchyny/vim-gitbranch', {'event': 'VimEnter'}
Pg 'lambdalisue/vim-gina', {'cmd': 'Gina'}
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
Pg 'osyo-manga/vim-operator-search', {'event': g:lazy_events}
Pg 'osyo-manga/vim-operator-stay-cursor', {'event': g:lazy_events}
Pg 'osyo-manga/vim-operator-highlighter', {'event': g:lazy_events}


" Search:
" Pg 'eugen0329/vim-esearch', {'event': 'BufRead'}
" Pg 'hrsh7th/vim-eft', {'event': 'BufRead'}
" Pg 'inside/vim-search-pulse', {'event': g:lazy_events}
" Pg 'kevinhwang91/nvim-hlslens', {'event': 'VimEnter', 'if': has('nvim')}
" Pg 'mhinz/vim-grepper', {'event': 'VimEnter'}
" Pg 'pechorin/any-jump.vim', {'cmd': ['AnyJumpLastResults', 'AnyJumpBack', 'AnyJumpVisual', 'AnyJump']}
" Pg 'ripxorip/aerojump.nvim', {'event': 'BufRead', 'if': has('nvim')}
Pg 'haya14busa/vim-asterisk', {'event': 'BufRead'}
Pg 'markonm/traces.vim', {'event': 'BufRead'}
Pg 'unblevable/quick-scope', {'event': 'BufRead'}

" Shell:
" Pg 'Shougo/deol.nvim', {'cmd': ['Deol', 'DeolCd', 'DeolEdit'], 'do': 'silent! UpdateRemotePlugins'}
Pg 'akinsho/toggleterm.nvim', {'cmd': 'ToggleTerm'}

" FileType:
Pg 'sheerun/vim-polyglot'

" markdown
Pg 'plasticboy/vim-markdown', {'ft': 'markdown'}
Pg 'dkarter/bullets.vim', {'ft': 'markdown'}
Pg 'dhruvasagar/vim-table-mode', {'ft': 'markdown'}
" Pg 'iamcco/markdown-preview.nvim', {'cmd': 'MarkdownPreview', 'do': '!cd app & yarn install', 'if': executable('yarn')}
" Pg 'previm/previm', {'cmd': 'PrevimOpen'}

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
  Pg 'suy/vim-ctrlp-commandline', {'event': 'VimEnter'}
  Pg 'tsuyoshicho/ctrlp-mr.vim', {'cmd': ['CtrlPMRMru', 'CtrlPMRMrw', 'CtrlPMRMrr']}
  Pg 'kaneshin/ctrlp-git-log', {'cmd': 'CtrlPGitLog'}
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

if g:plugin_use_linearf
  Pg 'octaltree/linearf'
  Pg 'octaltree/linearf-my-flavors'
endif

if g:plugin_use_lightline
  Pg 'itchyny/lightline.vim', {'event': g:lazy_events}
  Pg 'kmtoki/lightline-colorscheme-simplicity'
  Pg 'josa42/vim-lightline-coc'
endif

if g:plugin_use_airline
  Pg 'vim-airline/vim-airline', {'event': g:lazy_events}

  " Pg 'vim-airline/vim-airline-themes'
endif

if g:plugin_use_lualine
  Pg 'nvim-lualine/lualine.nvim'
endif

if g:plugin_use_neoline
  Pg 'adelarsq/neoline.vim'
endif

if g:plugin_use_galaxyline
  Pg 'glepnir/galaxyline.nvim', {'branch': 'main'}
endif

if g:plugin_use_fern
  Pg 'lambdalisue/vim-fern'
  Pg 'lambdalisue/vim-fern-hijack'

  Pg 'lambdalisue/vim-fern-bookmark', {'event': 'VimEnter'}
  Pg 'lambdalisue/vim-fern-comparator-lexical', {'event': 'VimEnter'}
  Pg 'lambdalisue/vim-fern-git-status', {'event': 'VimEnter'}
  Pg 'lambdalisue/vim-fern-git', {'event': 'VimEnter'}
  Pg 'lambdalisue/vim-fern-mapping-git', {'event': 'VimEnter'}
  Pg 'lambdalisue/vim-fern-renderer-nerdfont', {'event': 'VimEnter'}
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
if plugin_use_quickrun
  Pg 'thinca/vim-quickrun', {'event': 'VimEnter'}
  Pg 'lambdalisue/vim-quickrun-ne-job', {'event': 'VimEnter'}
endif

" Treesitter:
Pg 'nvim-treesitter/nvim-treesitter', {'if': has('nvim'), 'do': 'silent! TSUpdate', 'event': 'BufRead'}
Pg 'p00f/nvim-ts-rainbow', {'if': has('nvim'), 'event': 'BufRead'}


" Denops:
Pg 'kat0h/bufpreview.vim'
Pg 'monaqa/dps-dial.vim'
Pg 'tamago324/dps-gitignore'
Pg 'vim-denops/denops.vim'
Pg 'yuki-yano/dps-zero.vim'
Pg 'yuki-yano/fuzzy-motion.vim'
Pg 'yukimemi/dps-ahdr'
Pg 'yukimemi/dps-asyngrep'
Pg 'yukimemi/dps-autocursor'
Pg 'yukimemi/dps-walk'

if g:plugin_use_ddc
  Pg 'Shougo/ddc.vim'
  Pg 'Shougo/ddc-around'
  Pg 'Shougo/ddc-nextword'
  Pg 'Shougo/ddc-matcher_head'
  Pg 'Shougo/ddc-matcher_length'
  Pg 'Shougo/ddc-sorter_rank'
  Pg 'Shougo/ddc-converter_remove_overlap'
  Pg 'Shougo/ddc-omni'
  Pg 'Shougo/ddc-cmdline'
  Pg 'Shougo/ddc-cmdline-history'
  Pg 'Shougo/ddc-line'
  Pg 'Shougo/pum.vim'
  Pg 'Shougo/ddc-zsh', {'ft': 'zsh'}
  Pg 'Shougo/neco-vim', {'ft': ['vim', 'toml', 'markdown']}
  Pg 'Shougo/ddc-rg', {'if': executable('rg')}

  Pg 'LumaKernel/ddc-file'
  Pg 'delphinus/ddc-treesitter'
  Pg 'matsui54/ddc-buffer'
  Pg 'matsui54/denops-popup-preview.vim'
  Pg 'tani/ddc-fuzzy'
  Pg 'tani/ddc-git'
  Pg 'tani/ddc-oldfiles'
  Pg 'tani/ddc-path'

  if g:plugin_use_vimlsp
    Pg 'prabirshrestha/vim-lsp'
    Pg 'mattn/vim-lsp-icons'
    Pg 'mattn/vim-lsp-settings'
    Pg 'shun/ddc-vim-lsp'
  endif
  if g:plugin_use_nvimlsp
    Pg 'neovim/nvim-lspconfig'
    Pg 'williamboman/nvim-lsp-installer'
    Pg 'Shougo/ddc-nvim-lsp'
  endif
endif


" vim:fdm=marker expandtab fdc=3 ft=vim ts=2 sw=2 sts=2:
