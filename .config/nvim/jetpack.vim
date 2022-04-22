" =============================================================================
" File        : jetpack.vim
" Author      : yukimemi
" Last Change : 2022/04/22 13:11:33.
" =============================================================================

" Plugin:
" Use vim-jetpack
let s:jetpack_bootstrap = $CACHE_HOME .. '/jetpack_bootstrap'
let s:jetpack_bootstrap_dir = s:jetpack_bootstrap .. '/pack/jetpack/start/jetpack'
let s:package_home = $CACHE_HOME . '/jetpack'
let s:jetpack_download = 0
execute printf('set packpath^=%s', s:jetpack_bootstrap)
if has('vim_starting')
  if !isdirectory(expand(s:jetpack_bootstrap_dir))
    echo "Install jetpack ..."
    execute 'silent! !git clone --depth 1 https://github.com/tani/vim-jetpack ' .. s:jetpack_bootstrap_dir
    let s:jetpack_download = 1
  endif
endif

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

call jetpack#begin(s:package_home)

Pg 'tani/vim-jetpack', {'on': 'JetpackSync'}

" Colorscheme:
Pg 'Matsuuu/pinkmare'

" Visual:
Pg 'LumaKernel/nvim-visual-eof.lua', {'if': has('nvim')}
Pg 'andymass/vim-matchup', {'on': g:lazy_events}
Pg 'itchyny/vim-cursorword', {'on': g:lazy_events}
Pg 'itchyny/vim-highlighturl', {'on': g:lazy_events}
Pg 'itchyny/vim-parenmatch', {'on': g:lazy_events}
Pg 'lambdalisue/seethrough.vim', {'if': !has('gui')}
Pg 'lukas-reineke/indent-blankline.nvim', {'if': has('nvim'), 'on': 'VimEnter'}
Pg 'luochen1990/rainbow', {'on': g:lazy_events}
Pg 'mattn/transparency-windows-vim', {'if': g:is_windows && !has('nvim')}
Pg 'mattn/vimtweak', {'if': g:is_windows && !has('nvim')}
Pg 'mopp/smartnumber.vim', {'on': g:lazy_events}
Pg 'ntpeters/vim-better-whitespace', {'on': g:lazy_events}
Pg 't9md/vim-quickhl', {'on': g:lazy_events}
Pg 'mattn/vim-notification', {'on': g:lazy_events, 'if': !has('nvim')}

" Statusline:
if g:plugin_use_barow
  Pg 'doums/barow', {'on': g:lazy_events}
  Pg 'doums/barowLSP', {'on': g:lazy_events}
  Pg 'doums/barowGit', {'on': g:lazy_events}
endif

if g:plugin_use_lightline
  Pg 'itchyny/lightline.vim', {'on': g:lazy_events}
  Pg 'kmtoki/lightline-colorscheme-simplicity', {'on': g:lazy_events}
  Pg 'josa42/vim-lightline-coc', {'on': g:lazy_events}
  Pg 'itchyny/vim-gitbranch', {'on': g:lazy_events}
endif

" Ctrlp:
Pg 'ctrlpvim/ctrlp.vim'
Pg 'kaneshin/ctrlp-filetype'
Pg 'kaneshin/ctrlp-memolist'
Pg 'kaneshin/ctrlp-sonictemplate'
Pg 'ompugao/ctrlp-history'
Pg 'tsuyoshicho/ctrlp-mr.vim'
Pg 'mattn/ctrlp-launcher'
Pg 'mattn/ctrlp-mark'
Pg 'mattn/ctrlp-matchfuzzy', {'if': exists('*matchfuzzy')}
Pg 'suy/vim-ctrlp-commandline'

" Fern:
if g:plugin_use_fern
  Pg 'lambdalisue/fern-bookmark.vim'
  Pg 'lambdalisue/fern-comparator-lexical.vim'
  Pg 'lambdalisue/fern-git-status.vim'
  Pg 'lambdalisue/fern-git.vim'
  Pg 'lambdalisue/fern-hijack.vim'
  Pg 'lambdalisue/fern-mapping-git.vim'
  Pg 'lambdalisue/fern-renderer-nerdfont.vim'
  Pg 'lambdalisue/fern.vim'
  Pg 'lambdalisue/glyph-palette.vim', {'on': 'VimEnter'}
  Pg 'lambdalisue/nerdfont.vim', {'on': 'VimEnter'}
endif

" Textobj:
Pg 'kana/vim-textobj-user'
Pg 'gilligan/textobj-lastpaste', {'on': '<Plug>(textobj-lastpaste-i)'}
Pg 'kana/vim-textobj-entire', {'on': ['<Plug>(textobj-entire-a)', '<Plug>(textobj-entire-i)']}
Pg 'kana/vim-textobj-fold', {'on': ['<Plug>(textobj-fold-a)', '<Plug>(textobj-fold-i)']}
Pg 'kana/vim-textobj-function', {'on': ['<Plug>(textobj-function-a)', '<Plug>(textobj-function-i)', '<Plug>(textobj-function-A)', '<Plug>(textobj-function-I)']}
Pg 'kana/vim-textobj-indent', {'on': ['<Plug>(textobj-indent-a)', '<Plug>(textobj-indent-i)', '<Plug>(textobj-indent-same-a)', '<Plug>(textobj-indent-same-i)']}
Pg 'kana/vim-textobj-line', {'on': ['<Plug>(textobj-line-i)', '<Plug>(textobj-line-a)']}
Pg 'mattn/vim-textobj-url', {'on': g:lazy_events}
Pg 'vimtaku/vim-operator-mdurl', {'on': ['<Plug>(operator-mdurl)', '<Plug>(operator-mdurlp)']}
Pg 'osyo-manga/vim-textobj-multiblock', {'on': ['<Plug>(textobj-multiblock-a)', '<Plug>(textobj-multiblock-i)']}

" Operator:
Pg 'kana/vim-operator-user'
Pg 'kana/vim-operator-replace', {'on': '<Plug>(operator-replace)'}
Pg 'machakann/vim-sandwich', {'on': g:lazy_events}
Pg 'machakann/vim-swap', {'on': ['<Plug>(swap-textobject-i)', '<Plug>(swap-textobject-a)']}
Pg 'osyo-manga/vim-operator-search', {'on': '<Plug>(operator-search)'}
Pg 'osyo-manga/vim-operator-stay-cursor', {'on': g:lazy_events}

" Search:
Pg 'haya14busa/vim-asterisk', {'on': g:lazy_events}

" Git:
Pg 'lambdalisue/askpass.vim'
Pg 'lambdalisue/gin.vim'
Pg 'lambdalisue/guise.vim'

" Comment:
Pg 'tyru/caw.vim', {'on': ['<Plug>(caw:prefix)', '<Plug>(caw:hatpos:toggle)']}

" FileType:

" Util:
Pg 'Bakudankun/BackAndForward.vim', {'on': ['<Plug>(backandforward-back)', '<Plug>(backandforward-forward)']}
Pg 'LeafCage/yankround.vim', {'on': 'BufRead'}
Pg 'Shougo/junkfile.vim', {'on': 'JunkfileOpen'}
Pg 'airblade/vim-rooter', {'on': 'BufRead'}
Pg 'aiya000/aho-bakaup.vim', {'on': 'BufWritePre'}
Pg 'cohama/lexima.vim', {'if': g:plugin_use_lexima}
Pg 'glidenote/memolist.vim', {'on': ['MemoNew', 'MemoList', 'MemoGrep']}
Pg 'haya14busa/vim-edgemotion', {'on': ['<Plug>(edgemotion-j)', '<Plug>(edgemotion-k)']}
Pg 'lambdalisue/mr.vim'
Pg 'lambdalisue/vim-findent', {'on': 'Findent'}
Pg 'mattn/vim-lexiv', {'if': g:plugin_use_lexiv}
Pg 'qpkorr/vim-renamer', {'on': 'Renamer'}
Pg 'thinca/vim-ambicmd'
Pg 'thinca/vim-prettyprint', {'on': 'PP'}
Pg 'thinca/vim-singleton', {'if': !has('nvim')}
Pg 'thinca/vim-submode', {'on': 'BufRead'}
Pg 'tpope/vim-repeat', {'on': 'BufRead'}
Pg 'tyru/open-browser.vim', {'on': g:lazy_events}
Pg 'vim-scripts/autodate.vim', {'on': 'InsertEnter'}

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

call jetpack#end()

" Load plugin config.
call jetpack#names()->map({ -> s:source_plugin_cfg(v:val) })
