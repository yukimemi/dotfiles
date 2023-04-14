" =============================================================================
" File        : jetpack.vim
" Author      : yukimemi
" Last Change : 2022/11/29 15:03:57.
" =============================================================================

" Plugin:
" Use vim-jetpack
let s:package_home = expand('$CACHE_HOME/jetpack')
let s:jetpack_bootstrap = s:package_home .. '/pack/jetpack/opt/vim-jetpack'
if !isdirectory(s:jetpack_bootstrap)
  execute 'silent! !git clone --depth 1 https://github.com/tani/vim-jetpack ' . s:jetpack_bootstrap
endif
execute 'set packpath^=' . substitute(fnamemodify(s:package_home, ':p') , '[/\\]$', '', '')

function! IsInstalled(name) abort
  return jetpack#tap(a:name)
endfunction

let s:cfg_path = $VIM_PATH . '/rc'

function! s:plug_add(repo, ...) abort
  let l:opts = get(a:000, 0, {})
  let l:name = substitute(a:repo, '^.*/', '', '')

  " Check if option
  if has_key(l:opts, 'if')
    if ! l:opts.if
      return
    endif
  endif

  execute printf("Jetpack '%s', %s", a:repo, l:opts)
endfunction

function! s:source_plugin_cfg(name) abort
  " Load plugin config if exist.
  let l:plug_cfg = expand(s:cfg_path . '/' . a:name)
  let l:plug_cfg_vim = expand(s:cfg_path . '/' . a:name . '.vim')
  if filereadable(l:plug_cfg)
    execute printf('so %s', l:plug_cfg)
  elseif filereadable(l:plug_cfg_vim)
    execute printf('so %s', l:plug_cfg_vim)
  endif
endfunction

command! -bar -nargs=+ Pg call s:plug_add(<args>)

" Plugin list.
let g:lazy_events = ['CursorHold', 'FocusLost']

packadd vim-jetpack
call jetpack#begin(s:package_home)

Pg 'tani/vim-jetpack', {'opt': 1}

" Colorscheme:
Pg 'Matsuuu/pinkmare', {'opt': 1}
Pg 'rafi/awesome-vim-colorschemes', {'opt': 1}
Pg 'RRethy/nvim-base16', {'opt': 1}

" Visual:
Pg 'andymass/vim-matchup', {'event': g:lazy_events}
Pg 'itchyny/vim-cursorword', {'event': g:lazy_events}
Pg 'itchyny/vim-highlighturl', {'event': g:lazy_events}
Pg 'itchyny/vim-parenmatch', {'event': g:lazy_events}
Pg 'lambdalisue/seethrough.vim', {'if': !has('gui')}
Pg 'lukas-reineke/indent-blankline.nvim', {'if': has('nvim'), 'event': g:lazy_events}
Pg 'luochen1990/rainbow', {'event': g:lazy_events}
Pg 'mattn/transparency-windows-vim', {'if': g:is_windows && !has('nvim')}
Pg 'mattn/vim-notification', {'event': g:lazy_events, 'if': !has('nvim')}
Pg 'mattn/vimtweak', {'if': g:is_windows && !has('nvim')}
Pg 'mopp/smartnumber.vim', {'event': g:lazy_events}
Pg 'ntpeters/vim-better-whitespace', {'event': g:lazy_events}
Pg 't9md/vim-quickhl', {'event': g:lazy_events}

" Treesitter:
Pg 'nvim-treesitter/nvim-treesitter', {'if': has('nvim') && g:plugin_use_treesitter, 'do': 'execute(TSUpdate)', 'event': 'BufRead'}

" Movement:
" Pg 'psliwka/vim-smoothie', {'event': g:lazy_events}
Pg 'gen740/SmoothCursor.nvim', {'if': has('nvim'), 'event': g:lazy_events}

" Statusline:
Pg 'itchyny/lightline.vim', {'event': g:lazy_events}
Pg 'kmtoki/lightline-colorscheme-simplicity', {'event': g:lazy_events}
Pg 'josa42/vim-lightline-coc', {'event': g:lazy_events}
Pg 'itchyny/vim-gitbranch', {'event': g:lazy_events}

" Ctrlp:
Pg 'ctrlpvim/ctrlp.vim', {'cmd': ['CtrlP', 'CtrlPBuffer', 'CtrlPCurFile', 'CtrlPMRUFiles', 'CtrlPLauncher', 'CtrlPSonictemplate', 'VimHelpJp', 'CtrlPCmdHistory', 'CtrlPSearchHistory', 'CtrlPMRMru', 'CtrlPMRMrw', 'CtrlPMRMrr']}
Pg 'kaneshin/ctrlp-filetype', {'cmd': 'CtrlPFiletype'}
Pg 'kaneshin/ctrlp-sonictemplate', {'cmd': 'CtrlPSonictemplate'}
Pg 'ompugao/ctrlp-history', {'cmd': 'CtrlPSearchHistory'}
Pg 'tsuyoshicho/ctrlp-mr.vim', {'cmd': ['CtrlPMRMrw', 'CtrlPMRMru', 'CtrlPMRMrr']}
Pg 'mattn/ctrlp-launcher', {'cmd': 'CtrlPLauncher'}
Pg 'mattn/ctrlp-matchfuzzy', {'if': exists('*matchfuzzy'), 'event': g:lazy_events}
Pg 'suy/vim-ctrlp-commandline', {'cmd': 'CtrlPCmdHistory'}

" Fern:
if g:plugin_use_fern
  Pg 'lambdalisue/fern.vim', {'cmd': ['Fern']}

  Pg 'lambdalisue/fern-bookmark.vim', {'event': g:lazy_events}
  Pg 'lambdalisue/fern-comparator-lexical.vim', {'event': g:lazy_events}
  Pg 'lambdalisue/fern-git-status.vim', {'event': g:lazy_events}
  Pg 'lambdalisue/fern-git.vim', {'event': g:lazy_events}
  Pg 'lambdalisue/fern-hijack.vim', {'event': g:lazy_events}
  Pg 'lambdalisue/fern-mapping-git.vim', {'event': g:lazy_events}
  Pg 'lambdalisue/fern-renderer-nerdfont.vim', {'event': g:lazy_events}
  Pg 'lambdalisue/glyph-palette.vim', {'event': g:lazy_events}
  Pg 'lambdalisue/nerdfont.vim', {'event': g:lazy_events}
endif

" Textobj:
Pg 'kana/vim-textobj-user', {'event': 'BufRead'}
Pg 'gilligan/textobj-lastpaste', {'map': '<Plug>(textobj-lastpaste-i)'}
Pg 'kana/vim-textobj-entire', {'map': ['<Plug>(textobj-entire-a)', '<Plug>(textobj-entire-i)']}
Pg 'kana/vim-textobj-fold', {'map': ['<Plug>(textobj-fold-a)', '<Plug>(textobj-fold-i)']}
Pg 'kana/vim-textobj-function', {'map': ['<Plug>(textobj-function-a)', '<Plug>(textobj-function-i)', '<Plug>(textobj-function-A)', '<Plug>(textobj-function-I)']}
Pg 'kana/vim-textobj-indent', {'map': ['<Plug>(textobj-indent-a)', '<Plug>(textobj-indent-i)', '<Plug>(textobj-indent-same-a)', '<Plug>(textobj-indent-same-i)']}
Pg 'kana/vim-textobj-line', {'map': ['<Plug>(textobj-line-i)', '<Plug>(textobj-line-a)']}
Pg 'mattn/vim-textobj-url', {'map': g:lazy_events}
Pg 'vimtaku/vim-operator-mdurl', {'map': ['<Plug>(operator-mdurl)', '<Plug>(operator-mdurlp)']}
Pg 'osyo-manga/vim-textobj-multiblock', {'map': ['<Plug>(textobj-multiblock-a)', '<Plug>(textobj-multiblock-i)']}

" Operator:
Pg 'kana/vim-operator-user', {'event': 'BufRead'}
Pg 'kana/vim-operator-replace', {'map': '<Plug>(operator-replace)'}
Pg 'machakann/vim-sandwich', {'event': g:lazy_events}
Pg 'machakann/vim-swap', {'map': ['<Plug>(swap-textobject-i)', '<Plug>(swap-textobject-a)']}
Pg 'osyo-manga/vim-operator-search', {'map': '<Plug>(operator-search)'}
Pg 'osyo-manga/vim-operator-stay-cursor', {'event': g:lazy_events}

" Search:
Pg 'haya14busa/vim-asterisk', {'map': ['<Plug>(asterisk-z*)', '<Plug>(asterisk-gz*)', '<Plug>(asterisk-z#)', '<Plug>(asterisk-gz#)']}
Pg 'deris/vim-shot-f', {'event': g:lazy_events}
Pg 'inside/vim-search-pulse', {'event': g:lazy_events}

" Git:
if g:plugin_use_gin
  Pg 'lambdalisue/askpass.vim', {'event': 'BufRead'}
  Pg 'lambdalisue/gin.vim', {'event': 'BufRead'}
  Pg 'lambdalisue/guise.vim', {'event': 'BufRead'}
endif
if g:plugin_use_gina
  Pg 'lambdalisue/gina.vim', {'cmd': 'Gina'}
endif

" Tmux:
Pg 'sunaku/tmux-navigate', {'if': !g:is_windows, 'event': 'BufRead'}


" Comment:
Pg 'tyru/caw.vim', {'map': ['<Plug>(caw:prefix)', '<Plug>(caw:hatpos:toggle)']}

" FileType:
" Pg 'alvan/vim-closetag', {'for': ['xml', 'html']}

" Util:
Pg 'Bakudankun/BackAndForward.vim', {'map': ['<Plug>(backandforward-back)', '<Plug>(backandforward-forward)']}
Pg 'LeafCage/yankround.vim', {'event': 'BufRead'}
Pg 'Shougo/junkfile.vim', {'cmd': 'JunkfileOpen'}
Pg 'airblade/vim-rooter', {'event': 'BufRead'}
Pg 'aiya000/aho-bakaup.vim', {'event': 'BufWritePre'}
Pg 'cohama/lexima.vim', {'if': g:plugin_use_lexima}
Pg 'glidenote/memolist.vim', {'cmd': ['MemoNew', 'MemoList', 'MemoGrep']}
Pg 'haya14busa/vim-edgemotion', {'map': ['<Plug>(edgemotion-j)', '<Plug>(edgemotion-k)']}
Pg 'lambdalisue/mr.vim', {'event': ['JetpackCtrlpVimPre']}
Pg 'lambdalisue/vim-findent', {'cmd': 'Findent'}
Pg 'mattn/vim-lexiv', {'if': g:plugin_use_lexiv}
Pg 'mattn/vim-sonictemplate', {'cmd': 'Template'}
Pg 'qpkorr/vim-renamer', {'cmd': 'Renamer'}
Pg 'thinca/vim-ambicmd', {'event': 'BufRead'}
Pg 'thinca/vim-prettyprint', {'cmd': 'PP'}
Pg 'thinca/vim-singleton', {'if': g:is_windows}
Pg 'thinca/vim-submode', {'event': 'BufRead'}
Pg 'tpope/vim-repeat', {'event': 'BufRead'}
Pg 'tyru/open-browser.vim', {'event': g:lazy_events}
Pg 'gelguy/wilder.nvim', {'if': !g:plugin_use_ddc}
Pg 'thinca/vim-partedit', {'cmd': 'Partedit'}

" Denops:
Pg 'vim-denops/denops.vim'

Pg 'kat0h/bufpreview.vim'
Pg 'monaqa/dps-dial.vim'
Pg 'tamago324/dps-gitignore'
Pg 'yuki-yano/dps-zero.vim'
Pg 'yuki-yano/fuzzy-motion.vim'
Pg 'yukimemi/dps-ahdr'
Pg 'yukimemi/dps-asyngrep'
Pg 'yukimemi/dps-autocursor'
Pg 'yukimemi/dps-walk'
Pg 'yukimemi/dps-randomcolorscheme'
Pg 'yukimemi/dps-autobackup'
Pg 'yukimemi/dps-autodate'
Pg 'yutkat/dps-coding-now.nvim'
Pg 'skanehira/denops-translate.vim'

" Completion:
Pg 'neoclide/coc.nvim', {'branch': 'release', 'if': g:plugin_use_coc}

if g:plugin_use_ddc
  Pg 'Shougo/ddc.vim'
  Pg 'Shougo/ddc-around'
  Pg 'Shougo/ddc-nextword'
  Pg 'Shougo/ddc-mocword'
  Pg 'Shougo/ddc-matcher_head'
  Pg 'Shougo/ddc-matcher_length'
  Pg 'Shougo/ddc-sorter_rank'
  Pg 'Shougo/ddc-converter_remove_overlap'
  Pg 'Shougo/ddc-converter_truncate_abbr'
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
  " Pg 'tani/ddc-fuzzy'
  Pg 'yukimemi/ddc-fuzzy'
  Pg 'tani/ddc-git'
  Pg 'tani/ddc-oldfiles'
  Pg 'tani/ddc-path'
  Pg 'octaltree/cmp-look'

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

if g:plugin_use_ddu
  Pg 'Shougo/ddu.vim'
  Pg 'Shougo/ddu-commands.vim'

  Pg 'Shougo/ddu-filter-matcher_hidden'
  Pg 'Shougo/ddu-filter-matcher_relative'
  Pg 'Shougo/ddu-filter-matcher_substring'
  Pg 'Shougo/ddu-kind-file'
  Pg 'Shougo/ddu-kind-word'
  Pg 'Shougo/ddu-source-action'
  Pg 'Shougo/ddu-source-file'
  Pg 'Shougo/ddu-source-file_old'
  Pg 'Shougo/ddu-source-file_point'
  Pg 'Shougo/ddu-source-file_rec'
  Pg 'Shougo/ddu-source-line'
  Pg 'Shougo/ddu-source-register'
  Pg 'Shougo/ddu-ui-ff'
  Pg 'kuuote/ddu-source-mr'
  Pg 'matsui54/ddu-source-file_external'
  Pg 'matsui54/ddu-source-help'
  Pg 'shun/ddu-source-buffer'
  Pg 'shun/ddu-source-rg'
  Pg 'yuki-yano/ddu-filter-fzf'
  Pg '4513ECHO/ddu-source-colorscheme'
  Pg '4513ECHO/vim-readme-viewer'
endif

call jetpack#end()

for name in jetpack#names()
  if !jetpack#tap(name)
    call jetpack#sync()
    break
  endif
endfor

" Load plugin config.
call jetpack#names()->map({ -> s:source_plugin_cfg(v:val) })
