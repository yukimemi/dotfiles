" =============================================================================
" File        : minpac.vim
" Author      : yukimemi
" Last Change : 2018/10/27 16:36:16.
" =============================================================================

" Plugin:
" Use minpac. {{{1
set packpath^=$CACHE_HOME
let s:minpac_dir = $CACHE_HOME . '/pack/minpac/opt/minpac'
let s:minpac_init = 0
if has('vim_starting')
  if !isdirectory(s:minpac_dir)
    echo "Install minpac ..."
    execute '!git clone --depth 1 https://github.com/k-takata/minpac ' . s:minpac_dir
    let s:minpac_init = 1
  endif
endif

" minpac init. {{{1
if exists('*minpac#init')
  " minpac is loaded.
  call minpac#init()
  call minpac#add('k-takata/minpac', {'type': 'opt'})
endif

" minpac helper function. {{{1
let s:lazy_plugs = []
function! s:minpac_add(repo, ...) abort
  let l:opts = get(a:000, 0, {})
  if has_key(l:opts, 'if')
    if ! l:opts.if
      return
    endif
  endif

  let l:name = substitute(a:repo, '^.*/', '', '')
  " packadd on filetype.
  if has_key(l:opts, 'ft')
    let l:ft = type(l:opts.ft) == type([]) ? join(l:opts.ft, ',') : l:opts.ft
    exe printf('au MyAutoCmd FileType %s packadd %s', l:ft, l:name)
  endif

  " packadd on cmd.
  if has_key(l:opts, 'cmd')
    let l:cmd = type(l:opts.cmd) == type([]) ? join(l:opts.cmd, ',') : l:opts.cmd
    exe printf('au MyAutoCmd CmdUndefined %s packadd %s', l:cmd, l:name)
  endif

  if has_key(l:opts, 'lazy')
    if l:opts.lazy
      call add(s:lazy_plugs, l:name)
    endif
  endif

  if exists('*minpac#init')
    call minpac#add(a:repo, l:opts)
  endif
endfunction

com! -nargs=+ Pac call <SID>minpac_add(<args>)

" Load lazy plugins. {{{1
let s:idx = 0
function! PackAddHandler(timer)
  exe 'packadd ' . s:lazy_plugs[s:idx]
  let s:idx += 1
  " doautocmd BufReadPost
  au! lazy_load_bundle
  if s:idx == len(s:lazy_plugs)
    echom "lazy load done !"
  endif
endfunction

aug lazy_load_bundle
  au MyAutoCmd VimEnter * call timer_start(0, 'PackAddHandler', {'repeat': len(s:lazy_plugs)})
aug END

" Plugin list. {{{1
" start. {{{2
Pac 'Shougo/denite.nvim', {'do': 'silent! UpdateRemotePlugins', 'if': has('python3')}
Pac 'Yggdroot/indentLine'
Pac 'ctrlpvim/ctrlp.vim'
Pac 'haya14busa/vim-edgemotion'
Pac 'hotwatermorning/auto-git-diff'
Pac 'itchyny/lightline.vim'
Pac 'itchyny/vim-cursorword'
Pac 'itchyny/vim-gitbranch'
Pac 'itchyny/vim-parenmatch'
Pac 'kana/vim-operator-user'
Pac 'kana/vim-textobj-user'
Pac 'kopischke/vim-stay'
Pac 'lambdalisue/vim-findent'
Pac 'prabirshrestha/async.vim'
Pac 'prabirshrestha/asyncomplete-lsp.vim'
Pac 'prabirshrestha/asyncomplete.vim'
Pac 'prabirshrestha/vim-lsp'
Pac 'rhysd/committia.vim'
Pac 'roxma/nvim-yarp', {'if': !has('nvim')}
Pac 'roxma/vim-hug-neovim-rpc', {'if': !has('nvim')}
Pac 'ryanoasis/vim-devicons', {'if': !g:is_linux}
Pac 't9md/vim-quickhl'

" opt. {{{2
Pac 'NLKNguyen/papercolor-theme', {'type': 'opt'}
Pac 'OmniSharp/Omnisharp-vim', {'type': 'opt', 'ft': 'cs'}
Pac 'PProvost/vim-ps1', {'type': 'opt', 'ft': 'ps1'}
Pac 'Shougo/defx.nvim', {'type': 'opt', 'cmd': 'Defx', 'do': 'silent! UpdateRemotePlugins', 'if': !g:is_windows}
Pac 'Shougo/junkfile.vim', {'type': 'opt', 'cmd': 'JunkfileOpen'}
Pac 'airblade/vim-rooter', {'type': 'opt', 'cmd': 'Rooter'}
Pac 'aklt/plantuml-syntax', {'type': 'opt', 'ft': 'plantuml'}
Pac 'alx741/vim-hindent', {'type': 'opt', 'do': 'silent! !stack install hindent', 'if': executable('stack'), 'ft': 'haskell'}
Pac 'b4b4r07/vim-sqlfmt', {'type': 'opt', 'do': 'silent! !go get github.com/jackc/sqlfmt', 'ft': 'sql'}
Pac 'basyura/TweetVim', {'type': 'opt', 'cmd': ['TweetVimHomeTimeline', 'TweetVimUserStream','TweetVimSay']}
Pac 'basyura/bitly.vim', {'type': 'opt'}
Pac 'basyura/twibill.vim', {'type': 'opt'}
Pac 'cespare/vim-toml', {'type': 'opt', 'ft': 'toml'}
Pac 'cocopon/iceberg.vim', {'type': 'opt'}
Pac 'cohama/agit.vim', {'type': 'opt', 'cmd': 'Agit*'}
Pac 'dag/vim-fish', {'type': 'opt', 'ft': 'fish'}
Pac 'dhruvasagar/vim-table-mode', {'type': 'opt', 'ft': 'markdown'}
Pac 'eagletmt/ghcmod-vim', {'type': 'opt', 'do': 'silent! !stack install ghc-mod', 'if': executable('stack'), 'ft': 'haskell'}
Pac 'eagletmt/neco-ghc', {'type': 'opt', 'ft': 'haskell'}
Pac 'ekalinin/Dockerfile.vim', {'type': 'opt', 'ft': 'dockerfile'}
Pac 'fatih/vim-go', {'type': 'opt', 'ft': 'go'}
Pac 'glidenote/memolist.vim', {'type': 'opt', 'cmd': 'Memo*'}
Pac 'itchyny/vim-haskell-indent', {'type': 'opt', 'ft': 'haskell'}
Pac 'itchyny/vim-haskell-sort-import', {'type': 'opt', 'ft': 'haskell'}
Pac 'joshdick/onedark.vim', {'type': 'opt'}
Pac 'jremmen/vim-ripgrep', {'type': 'opt', 'cmd': 'Rg'}
Pac 'justinmk/vim-dirvish', {'type': 'opt', 'cmd': 'Dirvish*'}
Pac 'kannokanno/previm', {'type': 'opt', 'ft': 'markdown'}
Pac 'kchmck/vim-coffee-script', {'type': 'opt', 'ft': 'coffee'}
Pac 'keremc/asyncomplete-racer.vim', {'type': 'opt', 'ft': 'rust', 'if': !executable('rls')}
Pac 'kristijanhusak/vim-hybrid-material', {'type': 'opt'}
Pac 'kylef/apiblueprint.vim', {'type': 'opt', 'ft': 'apiblueprint'}
Pac 'leafgarland/typescript-vim', {'type': 'opt', 'ft': ['typescript', 'typescript.tsx']}
Pac 'lifepillar/vim-solarized8', {'type': 'opt'}
Pac 'majutsushi/tagbar', {'type': 'opt', 'cmd': 'Tagbar*'}
Pac 'mattn/favstar-vim', {'type': 'opt'}
Pac 'mattn/sonictemplate-vim', {'type': 'opt', 'cmd': 'Template*'}
Pac 'morhetz/gruvbox', {'type': 'opt'}
Pac 'nelstrom/vim-markdown-folding', {'type': 'opt', 'ft': 'markdown'}
Pac 'neovimhaskell/haskell-vim', {'type': 'opt', 'ft': ['haskell', 'cabal']}
Pac 'othree/es.next.syntax.vim', {'type': 'opt', 'ft': ['javascript', 'javascript.jsx']}
Pac 'othree/javascript-libraries-syntax.vim', {'type': 'opt', 'ft': ['javascript', 'javascript.jsx']}
Pac 'pangloss/vim-javascript', {'type': 'opt', 'ft': ['javascript', 'javascript.jsx']}
Pac 'posva/vim-vue', {'type': 'opt', 'ft': 'vue'}
Pac 'prabirshrestha/asyncomplete-necosyntax.vim', {'type': 'opt', 'ft': 'vim'}
Pac 'prabirshrestha/asyncomplete-necovim.vim', {'type': 'opt', 'ft': 'vim'}
Pac 'qpkorr/vim-renamer', {'type': 'opt', 'cmd': 'Renamer*'}
Pac 'rhysd/rust-doc.vim', {'type': 'opt', 'if': executable('cargo'), 'ft': 'rust'}
Pac 'rhysd/vim-color-spring-night', {'type': 'opt'}
Pac 'rhysd/vim-gfm-syntax', {'type': 'opt', 'ft': 'markdown'}
Pac 'rust-lang/rust.vim', {'type': 'opt', 'ft': 'rust'}
Pac 'scrooloose/vim-slumlord', {'type': 'opt', 'ft': 'plantuml'}
Pac 'simnalamburt/vim-mundo', {'type': 'opt', 'cmd': 'MundoToggle*'}
Pac 'stephpy/vim-yaml', {'type': 'opt', 'ft': ['yml', 'yaml']}
Pac 'thinca/vim-qfreplace', {'type': 'opt', 'ft': ['quickfix', 'qf']}
Pac 'tyru/capture.vim', {'type': 'opt', 'cmd': 'Capture'}
Pac 'y0za/vim-reading-vimrc', {'type': 'opt', 'cmd': 'ReadingVimrc*'}

" lazy. {{{2
" Pac 'yuttie/comfortable-motion.vim', {'type': 'opt', 'lazy': 1, 'if': !g:is_windows}
Pac 'Konfekt/FastFold', {'type': 'opt', 'lazy': 1}
Pac 'LeafCage/yankround.vim', {'type': 'opt', 'lazy': 1}
Pac 'Shougo/context_filetype.vim', {'type': 'opt', 'lazy': 1}
Pac 'Shougo/echodoc.vim', {'type': 'opt', 'lazy': 1}
Pac 'Shougo/neomru.vim', {'type': 'opt', 'lazy': 1}
Pac 'Shougo/neosnippet-snippets', {'type': 'opt', 'lazy': 1}
Pac 'Shougo/neosnippet.vim', {'type': 'opt', 'lazy': 1}
Pac 'Shougo/vimproc.vim', {'type': 'opt', 'lazy': 1, 'do': 'silent! !make'}
Pac 'gilligan/textobj-lastpaste', {'type': 'opt', 'lazy': 1}
Pac 'haya14busa/is.vim', {'type': 'opt', 'lazy': 1}
Pac 'haya14busa/vim-asterisk', {'type': 'opt', 'lazy': 1}
Pac 'haya14busa/vim-operator-flashy', {'type': 'opt', 'lazy': 1}
Pac 'itchyny/vim-external', {'type': 'opt', 'lazy': 1}
Pac 'itchyny/vim-highlighturl', {'type': 'opt', 'lazy': 1}
Pac 'iyuuya/denite-ale', {'type': 'opt', 'lazy': 1}
Pac 'junegunn/vim-easy-align', {'type': 'opt', 'lazy': 1}
Pac 'kana/vim-operator-replace', {'type': 'opt', 'lazy': 1}
Pac 'kana/vim-textobj-entire', {'type': 'opt', 'lazy': 1}
Pac 'kana/vim-textobj-fold', {'type': 'opt', 'lazy': 1}
Pac 'kana/vim-textobj-function', {'type': 'opt', 'lazy': 1}
Pac 'kana/vim-textobj-indent', {'type': 'opt', 'lazy': 1}
Pac 'kaneshin/ctrlp-filetype', {'type': 'opt', 'lazy': 1}
Pac 'kaneshin/ctrlp-memolist', {'type': 'opt', 'lazy': 1}
Pac 'kaneshin/ctrlp-sonictemplate', {'type': 'opt', 'lazy': 1}
Pac 'kassio/neoterm', {'type': 'opt', 'lazy': 1, 'if': has('nvim')}
Pac 'lambdalisue/gina.vim', {'type': 'opt', 'lazy': 1}
Pac 'ludovicchabant/vim-gutentags', {'type': 'opt', 'lazy': 1, 'if': executable('ctags')}
Pac 'mattn/ctrlp-launcher', {'type': 'opt', 'lazy': 1}
Pac 'mattn/ctrlp-mark', {'type': 'opt', 'lazy': 1}
Pac 'mattn/webapi-vim', {'type': 'opt', 'lazy': 1}
Pac 'ntpeters/vim-better-whitespace', {'type': 'opt', 'lazy': 1}
Pac 'ompugao/ctrlp-history', {'type': 'opt', 'lazy': 1}
Pac 'osyo-manga/vim-anzu', {'type': 'opt', 'lazy': 1}
Pac 'osyo-manga/vim-operator-blockwise', {'type': 'opt', 'lazy': 1}
Pac 'osyo-manga/vim-operator-search', {'type': 'opt', 'lazy': 1}
Pac 'osyo-manga/vim-precious', {'type': 'opt', 'lazy': 1}
Pac 'osyo-manga/vim-textobj-multiblock', {'type': 'opt', 'lazy': 1}
Pac 'prabirshrestha/asyncomplete-buffer.vim', {'type': 'opt', 'lazy': 1}
Pac 'prabirshrestha/asyncomplete-emoji.vim', {'type': 'opt', 'lazy': 1}
Pac 'prabirshrestha/asyncomplete-file.vim', {'type': 'opt', 'lazy': 1}
Pac 'prabirshrestha/asyncomplete-neosnippet.vim', {'type': 'opt', 'lazy': 1}
Pac 'prabirshrestha/asyncomplete-tags.vim', {'type': 'opt', 'lazy': 1}
Pac 'rhysd/vim-operator-surround', {'type': 'opt', 'lazy': 1}
Pac 'roxma/vim-tmux-clipboard', {'type': 'opt', 'lazy': 1, 'if': !g:is_windows}
Pac 'taku-o/vim-zoom', {'type': 'opt', 'lazy': 1}
Pac 'thinca/vim-submode', {'type': 'opt', 'lazy': 1}
Pac 'tmux-plugins/vim-tmux-focus-events', {'type': 'opt', 'lazy': 1, 'if': !g:is_windows}
Pac 'tpope/vim-repeat', {'type': 'opt', 'lazy': 1}
Pac 'tyru/caw.vim', {'type': 'opt', 'lazy': 1}
Pac 'tyru/open-browser.vim', {'type': 'opt', 'lazy': 1}
Pac 'vim-scripts/autodate.vim', {'type': 'opt', 'lazy': 1}
Pac 'vim-scripts/matchit.zip', {'type': 'opt', 'lazy': 1}
Pac 'w0rp/ale', {'type': 'opt', 'lazy': 1}
Pac 'yami-beta/asyncomplete-omni.vim', {'type': 'opt', 'lazy': 1}

" Plugin settings. {{{1
source $VIM_PATH/rc/lightline.vim
source $VIM_PATH/rc/indentLine.vim
source $VIM_PATH/rc/deoplete.vim
" source $VIM_PATH/rc/neocomplete.vim
source $VIM_PATH/rc/neosnippet.vim
source $VIM_PATH/rc/vim-rooter.vim
source $VIM_PATH/rc/vim-submode.vim
source $VIM_PATH/rc/FastFold.vim
source $VIM_PATH/rc/vim-easy-align.vim
source $VIM_PATH/rc/yankround.vim
source $VIM_PATH/rc/vim-operator-replace.vim
source $VIM_PATH/rc/vim-operator-surround.vim
" source $VIM_PATH/rc/vim-operator-blockwise.vim
source $VIM_PATH/rc/vim-operator-search.vim
source $VIM_PATH/rc/vim-operator-flashy.vim
source $VIM_PATH/rc/vim-textobj-multiblock.vim
source $VIM_PATH/rc/vim-textobj-entire.vim
source $VIM_PATH/rc/vim-textobj-fold.vim
source $VIM_PATH/rc/vim-textobj-function.vim
source $VIM_PATH/rc/vim-textobj-indent.vim
source $VIM_PATH/rc/textobj-lastpaste.vim
source $VIM_PATH/rc/memolist.vim
source $VIM_PATH/rc/sonictemplate-vim.vim
source $VIM_PATH/rc/autodate.vim
source $VIM_PATH/rc/vim-mundo.vim
source $VIM_PATH/rc/ale.vim
source $VIM_PATH/rc/vim-dirvish.vim
source $VIM_PATH/rc/neoterm.vim
source $VIM_PATH/rc/vim-findent.vim
source $VIM_PATH/rc/echodoc.vim
source $VIM_PATH/rc/is.vim
source $VIM_PATH/rc/vim-quickhl.vim
source $VIM_PATH/rc/vim-parenmatch.vim
source $VIM_PATH/rc/vim-cursorword.vim
source $VIM_PATH/rc/caw.vim
source $VIM_PATH/rc/gina.vim
source $VIM_PATH/rc/vim-go.vim
source $VIM_PATH/rc/vim-ps1.vim
source $VIM_PATH/rc/typescript-vim.vim
source $VIM_PATH/rc/vim-fish.vim
source $VIM_PATH/rc/rust.vim
source $VIM_PATH/rc/vim-racer.vim
source $VIM_PATH/rc/ghcmod-vim.vim
source $VIM_PATH/rc/neco-ghc.vim
source $VIM_PATH/rc/vim-haskell-sort-import.vim
source $VIM_PATH/rc/haskell-vim.vim
source $VIM_PATH/rc/vim-hindent.vim
source $VIM_PATH/rc/vim-sqlfmt.vim
source $VIM_PATH/rc/vim-renamer.vim
source $VIM_PATH/rc/tagbar.vim
source $VIM_PATH/rc/vim-startify.vim
source $VIM_PATH/rc/ctrlp.vim
source $VIM_PATH/rc/vim-devicons.vim
source $VIM_PATH/rc/asyncomplete.vim
source $VIM_PATH/rc/previm.vim
source $VIM_PATH/rc/vim-edgemotion.vim
" source $VIM_PATH/rc/vim-markdown-composer.vim
source $VIM_PATH/rc/vim-reading-vimrc.vim
source $VIM_PATH/rc/gruvbox.vim
source $VIM_PATH/rc/vim-precious.vim
source $VIM_PATH/rc/vim-external.vim
source $VIM_PATH/rc/vim-slumlord.vim
source $VIM_PATH/rc/Omnisharp-vim.vim
source $VIM_PATH/rc/TweetVim.vim
source $VIM_PATH/rc/defx.vim

" Define user commands for updating/cleaning the plugins. {{{1
" Each of them loads minpac, reloads .vimrc to register the
" information of plugins, then performs the task.
com! PackClean     packadd minpac | source $MYVIMRC | call minpac#clean()
com! PackUpdate    packadd minpac | source $MYVIMRC | call minpac#clean() | call minpac#update() | call minpac#status()
com! PackListStart packadd minpac | source $MYVIMRC | Capture echo minpac#getpackages("", "start")
com! PackListOpt   packadd minpac | source $MYVIMRC | Capture echo minpac#getpackages("", "opt")
com! PackNameStart packadd minpac | source $MYVIMRC | Capture echo minpac#getpackages("", "start", "", 1)
com! PackNameOpt   packadd minpac | source $MYVIMRC | Capture echo minpac#getpackages("", "opt", "", 1)

" Install on initiall setup.
if s:minpac_init
  PackUpdate
endif
