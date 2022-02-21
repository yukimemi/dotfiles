" =============================================================================
" File        : jetpack.vim
" Author      : yukimemi
" Last Change : 2022/02/20 18:13:27.
" =============================================================================

" Plugin:
" Use vim-jetpack
let $CACHE_HOME_VIM = expand('$CACHE_HOME/jetpack')
let s:jetpack_pkg_dir = expand('~/.vim')
set packpath^=$CACHE_HOME_VIM
set packpath^=s:jetpack_pkg_dir
let s:package_home = $CACHE_HOME_VIM . '/pack/jetpack'
let s:jetpack_dir = s:package_home . '/start/jetpack'
let s:jetpack_download = 0
if has('vim_starting')
  if !isdirectory(expand(s:jetpack_dir))
    echo "Install jetpack ..."
    execute 'silent! !git clone --depth 1 https://github.com/tani/vim-jetpack ' .. s:jetpack_dir
    let s:jetpack_download = 1
  endif
endif

function! IsInstalled(name) abort
  return !empty(globpath(&pp, "pack/jetpack/*/" . a:name))
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

  " Load plugin config if exist.
  let l:plug_cfg = expand(s:cfg_path . '/' . l:name)
  let l:plug_cfg_vim = expand(s:cfg_path . '/' . l:name . '.vim')
  if filereadable(l:plug_cfg)
    execute printf('so %s', l:plug_cfg)
  elseif filereadable(l:plug_cfg_vim)
    execute printf('so %s', l:plug_cfg_vim)
  endif
endfunction

command! -bar -nargs=+ Pg call s:plug_add(<args>)
command! MyJetPackSync call s:my_jetpack_sync()

" Plugin list.
call jetpack#begin()

Pg 'Matsuuu/pinkmare'

" Statusline:
Pg 'doums/barow'
Pg 'doums/barowLSP'
Pg 'doums/barowGit'

" Ctrlp:
Pg 'ctrlpvim/ctrlp.vim'
Pg 'kaneshin/ctrlp-filetype'
Pg 'kaneshin/ctrlp-memolist'
Pg 'kaneshin/ctrlp-sonictemplate'
Pg 'ompugao/ctrlp-history'
Pg 'mattn/ctrlp-launcher'
Pg 'mattn/ctrlp-mark'
Pg 'mattn/ctrlp-matchfuzzy'
Pg 'suy/vim-ctrlp-commandline'

" Fern:
if g:plugin_use_fern
  Pg 'lambdalisue/fern.vim'
  Pg 'lambdalisue/fern-bookmark.vim'
  Pg 'lambdalisue/fern-comparator-lexical.vim'
  Pg 'lambdalisue/fern-git-status.vim'
  Pg 'lambdalisue/fern-git.vim'
  Pg 'lambdalisue/fern-hijack.vim'
  Pg 'lambdalisue/fern-mapping-git.vim'
  Pg 'lambdalisue/fern-renderer-nerdfont.vim'
endif

" Textobj:
Pg 'kana/vim-textobj-user'
Pg 'gilligan/textobj-lastpaste'
Pg 'kana/vim-textobj-entire'
Pg 'kana/vim-textobj-fold'
Pg 'kana/vim-textobj-function'
Pg 'kana/vim-textobj-indent'
Pg 'kana/vim-textobj-line'
Pg 'machakann/vim-textobj-delimited'
Pg 'osyo-manga/vim-textobj-multiblock'
Pg 'mattn/vim-textobj-url'

" Operator:
Pg 'kana/vim-operator-user'
Pg 'kana/vim-operator-replace'
Pg 'machakann/vim-sandwich'
Pg 'machakann/vim-swap'
Pg 'osyo-manga/vim-operator-search'
Pg 'osyo-manga/vim-operator-stay-cursor'

" Search:
Pg 'haya14busa/vim-asterisk'

" Git:
Pg 'lambdalisue/gina.vim'

" Comment:
Pg 'tyru/caw.vim'

" Completion:
Pg 'neoclide/coc.nvim'

" FileType:
Pg 'sheerun/vim-polyglot'

" Util:
Pg 'Shougo/junkfile.vim', {'on': ['JunkfileOpen']}
Pg 'glidenote/memolist.vim', {'on': ['MemoNew', 'MemoList', 'MemoGrep']}
Pg 'qpkorr/vim-renamer', {'on': ['Renamer']}
Pg 'thinca/vim-ambicmd'
Pg 'thinca/vim-prettyprint', {'on': ['PP']}
Pg 'thinca/vim-singleton'
Pg 'tpope/vim-repeat'
Pg 'vim-scripts/autodate.vim'

call jetpack#end()

