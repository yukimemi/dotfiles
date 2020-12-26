" =============================================================================
" File        : packager.vim
" Author      : yukimemi
" Last Change : 2020/12/26 00:07:04.
" =============================================================================

" Plugin:
" Use packager. {{{1
set packpath^=$CACHE_HOME
let s:package_home = $CACHE_HOME . '/pack/packager'
let s:packager_dir = s:package_home . '/opt/vim-packager'
let s:packager_download = v:false
if has('vim_starting')
  if !isdirectory(s:packager_dir)
    echo "Install vim-packager ..."
    execute '!git clone --depth 1 https://github.com/kristijanhusak/vim-packager ' . s:packager_dir
    let s:packager_download = v:true
  endif
endif

function! IsInstalled(name) abort
  return !empty(globpath(&pp, "pack/packager/*/" . a:name))
endfunction

let s:TYPE = {
      \   'string':  type(''),
      \   'list':    type([]),
      \   'dict':    type({}),
      \   'funcref': type(function('call'))
      \ }
let s:repos = {}
let s:cfg_path = $VIM_PATH . '/rc'

" Helper function.
function! s:plug_add(repo, ...) abort
  let l:opts = get(a:000, 0, {})
  let l:name = substitute(a:repo, '^.*/', '', '')
  let l:type = get(l:opts, 'type', 'start')

  " Check if option
  if has_key(l:opts, 'if')
    if ! l:opts.if
      return
    endif
  endif

  " Check ft option
  if has_key(l:opts, 'ft')
    let l:opts['type'] = 'opt'
    let l:ft = type(l:opts.ft) == s:TYPE.list ? join(l:opts.ft, ',') : l:opts.ft
    execute printf('au MyAutoCmd FileType %s packadd %s', l:ft, l:name)
  endif

  " Check cmd option
  if has_key(l:opts, 'cmd')
    let l:opts['type'] = 'opt'
    let l:cmd = type(l:opts.cmd) == s:TYPE.list ? join(l:opts.cmd, ',') : l:opts.cmd
    execute printf('au MyAutoCmd CmdUndefined %s packadd %s', l:cmd, l:name)
  endif

  " Check event
  if has_key(l:opts, 'event')
    let l:opts['type'] = 'opt'
    let l:event = type(l:opts.event) == s:TYPE.list ? join(l:opts.event, ',') : l:opts.event
    execute printf('au MyAutoCmd %s * ++once packadd %s', l:event, l:name)
  endif

  " source config
  let l:plug_cfg = expand(s:cfg_path . '/' . l:name)
  let l:plug_cfg_vim = expand(s:cfg_path . '/' . l:name . '.vim')
  if filereadable(l:plug_cfg)
    execute printf('so %s', l:plug_cfg)
  elseif filereadable(l:plug_cfg_vim)
    execute printf('so %s', l:plug_cfg_vim)
  endif

  let s:repos[a:repo] = l:opts
endfunction

command! -bar -nargs=+ Pg call s:plug_add(<args>)

" Load packager only when you need it
function! PackagerInit() abort
  packadd vim-packager
  call packager#init()
  for [repo, opts] in items(s:repos)
    call packager#add(repo, opts)
  endfor
endfunction

Pg 'kristijanhusak/vim-packager', {'type': 'opt'}

" Visual:
Pg 'LumaKernel/nvim-visual-eof.lua', {'if': has('nvim')}
Pg 'andymass/vim-matchup', {'event': ['CursorHold', 'FocusLost']}
Pg 'itchyny/vim-cursorword', {'event': ['CursorHold', 'FocusLost']}
Pg 'itchyny/vim-external', {'event': ['CursorHold', 'FocusLost']}
Pg 'itchyny/vim-highlighturl', {'event': ['CursorHold', 'FocusLost']}
Pg 'itchyny/vim-parenmatch', {'event': ['CursorHold', 'FocusLost']}
Pg 'jeffkreeftmeijer/vim-numbertoggle', {'event': ['CursorHold', 'FocusLost']}
Pg 'lambdalisue/glyph-palette.vim', {'event': ['VimEnter']}
Pg 'lambdalisue/nerdfont.vim', {'event': ['VimEnter']}
Pg 'luochen1990/rainbow', {'event': ['CursorHold', 'FocusLost']}
Pg 'mattn/transparency-windows-vim', {'if': g:is_windows && !has('nvim'), 'event': ['CursorHold', 'FocusLost']}
Pg 'mattn/vimtweak', {'if': g:is_windows}
Pg 'ntpeters/vim-better-whitespace', {'event': ['CursorHold', 'FocusLost']}

" Colorscheme:
Pg 'adrian5/oceanic-next-vim', {'type': 'opt'}

" Statusline:
Pg 'itchyny/lightline.vim', {'event': ['CursorHold', 'FocusLost']}

" Ctrlp:
Pg 'ctrlpvim/ctrlp.vim', {'event': 'VimEnter'}
Pg 'mattn/ctrlp-matchfuzzy', {'event': 'VimEnter'}
Pg 'kaneshin/ctrlp-filetype', {'cmd': 'CtrlPFiletype'}
Pg 'kaneshin/ctrlp-memolist', {'cmd': 'CtrlPMemolist'}
Pg 'kaneshin/ctrlp-sonictemplate', {'cmd': 'CtrlPSonictemplate'}
Pg 'ompugao/ctrlp-history', {'cmd': 'CtrlPSearchHistory'}
Pg 'mattn/ctrlp-launcher', {'cmd': 'CtrlPLauncher'}
Pg 'mattn/ctrlp-mark', {'cmd': 'CtrlPMark'}
Pg 'suy/vim-ctrlp-commandline', {'cmd': 'CtrlPCommandLine'}

" Fern:
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

" Molder:
if g:plugin_use_molder
  Pg 'mattn/vim-molder'
  Pg 'mattn/vim-molder-operations'
endif

" Textobj:
Pg 'kana/vim-textobj-user'
Pg 'gilligan/textobj-lastpaste', {'event': 'VimEnter'}
Pg 'kana/vim-textobj-entire', {'event': 'VimEnter'}
Pg 'kana/vim-textobj-fold', {'event': 'VimEnter'}
Pg 'kana/vim-textobj-function', {'event': 'VimEnter'}
Pg 'kana/vim-textobj-indent', {'event': 'VimEnter'}
Pg 'kana/vim-textobj-line', {'event': 'VimEnter'}
Pg 'machakann/vim-textobj-delimited', {'event': 'VimEnter'}
Pg 'osyo-manga/vim-textobj-multiblock', {'event': 'VimEnter'}
Pg 'mattn/vim-textobj-url', {'event': 'VimEnter'}

" Operator:
Pg 'kana/vim-operator-user'
Pg 'kana/vim-operator-replace', {'event': 'VimEnter'}
Pg 'machakann/vim-sandwich', {'event': 'VimEnter'}
Pg 'machakann/vim-swap', {'event': 'VimEnter'}
Pg 'osyo-manga/vim-operator-search', {'event': 'VimEnter'}
Pg 'osyo-manga/vim-operator-stay-cursor', {'event': 'VimEnter'}

" Search:
Pg 'haya14busa/vim-asterisk', {'event': 'VimEnter'}

" Git:
Pg 'lambdalisue/gina.vim', {'cmd': 'Gina'}

" Comment:
Pg 'tyru/caw.vim', {'event': ['CursorMoved', 'CursorHold', 'FocusLost']}

" Completion:
if g:plugin_use_asyncomplete
  Pg 'prabirshrestha/asyncomplete.vim', {'event': ['InsertEnter']}
  Pg 'high-moctane/asyncomplete-nextword.vim', {'do': 'silent! !go get -u github.com/high-moctane/nextword', 'if': executable('go')}, {'event': ['InsertEnter']}
  Pg 'hrsh7th/vim-vsnip', {'event': ['InsertEnter']}
  Pg 'hrsh7th/vim-vsnip-integ', {'event': ['InsertEnter']}
  Pg 'mattn/vim-lsp-icons'
  Pg 'mattn/vim-lsp-settings'
  Pg 'prabirshrestha/async.vim', {'event': ['InsertEnter']}
  Pg 'prabirshrestha/asyncomplete-buffer.vim', {'event': ['InsertEnter']}
  Pg 'prabirshrestha/asyncomplete-emoji.vim', {'event': ['InsertEnter']}
  Pg 'prabirshrestha/asyncomplete-file.vim', {'event': ['InsertEnter']}
  Pg 'prabirshrestha/asyncomplete-lsp.vim', {'event': ['InsertEnter']}
  Pg 'prabirshrestha/vim-lsp'
  Pg 'tsuyoshicho/vim-efm-langserver-settings'
  Pg 'voldikss/vim-translator', {'event': ['CursorMoved', 'CursorHold', 'FocusLost']}
endif

if g:plugin_use_coc
  Pg 'neoclide/coc.nvim', {'branch': 'release', 'do': 'silent! !go get -u github.com/high-moctane/nextword', 'if': executable('go')}
endif

" FileType:
Pg 'sheerun/vim-polyglot'

" Util:
Pg 'Shougo/junkfile.vim', {'cmd': ['JunkfileOpen']}
Pg 'gelguy/wilder.nvim'
Pg 'glidenote/memolist.vim', {'cmd': ['MemoNew', 'MemoList', 'MemoGrep']}
Pg 'seroqn/tozzy.vim', {'event': ['InsertEnter']}
Pg 'thinca/vim-ambicmd'
Pg 'thinca/vim-prettyprint', {'cmd': 'PP'}
Pg 'thinca/vim-singleton'
Pg 'tpope/vim-repeat', {'event': 'VimEnter'}
Pg 'vim-scripts/autodate.vim', {'event': ['InsertEnter']}
Pg 'qpkorr/vim-renamer', {'cmd': 'Renamer'}

" These commands are automatically added when using `packager#setup()`
command! -nargs=* -bar PackagerInstall call PackagerInit() | call packager#install(<args>)
command! -nargs=* -bar PackagerUpdate call PackagerInit() | call packager#update(<args>)
command! -bar PackagerClean call PackagerInit() | call packager#clean()
command! -bar PackagerStatus call PackagerInit() | call packager#status()

