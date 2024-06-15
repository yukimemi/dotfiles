" =============================================================================
" File        : vimplug.vim
" Author      : yukimemi
" Last Change : 2024/06/15 23:19:48.
" =============================================================================

" Plugin: {{{1
" Use vim-plug.
let s:plug_dir = $CACHE_HOME . '/plugs'
let s:vim_plug_dir = $CACHE_HOME . '/vim-plug'
if has('vim_starting')
  if !isdirectory(s:vim_plug_dir)
    echo "Install vim-plug ..."
    execute '!git clone --depth 1 https://github.com/junegunn/vim-plug.git ' . s:vim_plug_dir . '/autoload'
  endif
  execute 'set runtimepath^=' . fnamemodify(s:vim_plug_dir, ':p')
endif

let s:cfg_path = $VIM_PATH . '/rc'

" Helper function.
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

function! s:plug_add(repo, ...) abort
  let l:opts = get(a:000, 0, {})

  " Check if option
  if has_key(l:opts, 'if')
    if ! l:opts.if
      return
    endif
  endif

  execute printf("Plug '%s', %s", a:repo, l:opts)
endfunction

command! -bar -nargs=+ Pg call s:plug_add(<args>)


" Plugin list.
set noshellslash
call plug#begin(s:plug_dir)

" Visual:
Pg 'LumaKernel/nvim-visual-eof.lua', {'if': has('nvim')}
Pg 'andymass/vim-matchup'
Pg 'itchyny/vim-cursorword'
Pg 'itchyny/vim-external'
Pg 'itchyny/vim-highlighturl'
Pg 'itchyny/vim-parenmatch'
Pg 'jeffkreeftmeijer/vim-numbertoggle'
Pg 'lambdalisue/vim-glyph-palette'
Pg 'lambdalisue/vim-nerdfont'
Pg 'luochen1990/rainbow'
Pg 'mattn/transparency-windows-vim', {'if': g:is_windows && !has('nvim')}
Pg 'mattn/vimtweak', {'if': g:is_windows}

" Colorscheme:
Pg 'adrian5/oceanic-next-vim'

" Statusline:
Pg 'itchyny/lightline.vim'

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
  Pg 'lambdalisue/vim-fern'
  Pg 'lambdalisue/vim-fern-bookmark'
  Pg 'lambdalisue/vim-fern-comparator-lexical'
  Pg 'lambdalisue/vim-fern-git-status'
  Pg 'lambdalisue/vim-fern-git'
  Pg 'lambdalisue/vim-fern-hijack'
  Pg 'lambdalisue/vim-fern-mapping-git'
  Pg 'lambdalisue/vim-fern-renderer-nerdfont'
endif

" Molder:
if g:plugin_use_molder
  Pg 'mattn/vim-molder'
  Pg 'mattn/vim-molder-operations'
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
Pg 'lambdalisue/vim-gina'

" Comment:
Pg 'tyru/caw.vim'

" Completion:
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
Pg 'voldikss/vim-translator', {'on': ['<Plug>Translate', '<Plug>TranslateV', '<Plug>TranslateW', '<Plug>TranslateWV', '<Plug>TranslateR', '<Plug>TranslateRV']}

" FileType:
Pg 'sheerun/vim-polyglot'

" Util:
Pg 'Shougo/junkfile.vim', {'on': ['JunkfileOpen']}
Pg 'gelguy/wilder.nvim'
Pg 'glidenote/memolist.vim', {'on': ['MemoNew', 'MemoList', 'MemoGrep']}
Pg 'seroqn/tozzy.vim'
Pg 'thinca/vim-ambicmd'
Pg 'thinca/vim-prettyprint', {'on': ['PP']}
Pg 'thinca/vim-singleton'
Pg 'tpope/vim-repeat'
Pg 'vim-scripts/autodate.vim'
Pg 'qpkorr/vim-renamer', {'on': ['Renamer']}

" Pg 'neoclide/coc.nvim'

call plug#end()
set shellslash

let s:p = { 'plugs': get(g:, 'plugs', {}) }
function! s:p.is_installed(name) abort
  return has_key(self.plugs, a:name) ? isdirectory(self.plugs[a:name].dir) : 0
endfunction

function! IsInstalled(name) abort
  return s:p.is_installed(a:name)
endfunction

" Load plugin config.
call map(items(s:p.plugs), { _, v -> s:source_plugin_cfg(v[0]) })

