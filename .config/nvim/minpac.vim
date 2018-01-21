" =============================================================================
" File        : minpac.vim
" Author      : yukimemi
" Last Change : 2018/01/21 00:40:23.
" =============================================================================

" Plugin:
" Use minpac. {{{1
set packpath^=$CACHE_HOME
let s:minpac_dir = $CACHE_HOME . '/pack/minpac/opt/minpac'
if has('vim_starting')
  if !isdirectory(s:minpac_dir)
    echo "Install minpac ..."
    execute '!git clone --depth 1 https://github.com/k-takata/minpac ' . s:minpac_dir
  endif
endif

" pack list. {{{1
" start plugins. {{{2
let s:start_plugs = [
      \ ['Yggdroot/indentLine', {}],
      \ ['haya14busa/vim-edgemotion', {}],
      \ ['hotwatermorning/auto-git-diff', {}],
      \ ['itchyny/lightline.vim', {}],
      \ ['itchyny/vim-cursorword', {}],
      \ ['itchyny/vim-parenmatch', {}],
      \ ['kana/vim-operator-user', {}],
      \ ['kana/vim-textobj-user', {}],
      \ ['lambdalisue/vim-findent', {}],
      \ ['prabirshrestha/async.vim', {}],
      \ ['prabirshrestha/asyncomplete-lsp.vim', {}],
      \ ['prabirshrestha/asyncomplete.vim', {}],
      \ ['prabirshrestha/vim-lsp', {}],
      \ ['rhysd/committia.vim', {}],
      \ ['ryanoasis/vim-devicons', {}],
      \ ['thinca/vim-singleton', {}, !has('nvim')],
      \ ['tpope/vim-fugitive', {}],
      \ ]

      " \ ['vim-airline/vim-airline', {}],
      " \ ['vim-airline/vim-airline-themes', {}],
      " \ ['mhinz/vim-startify', {}],


" opt plugins. {{{2
let s:opt_plugs = [
      \ ['PProvost/vim-ps1', {'type': 'opt'}],
      \ ['Shougo/denite.nvim', {'type': 'opt', 'do': 'silent! UpdateRemotePlugins'}, has('python3')],
      \ ['aklt/plantuml-syntax', {'type': 'opt'}],
      \ ['alx741/vim-hindent', {'type': 'opt', 'do': 'silent! !stack install hindent'}, executable('stack')],
      \ ['b4b4r07/vim-sqlfmt', {'type': 'opt', 'do': 'silent! !go get github.com/jackc/sqlfmt'}],
      \ ['cespare/vim-toml', {'type': 'opt'}],
      \ ['cocopon/iceberg.vim', {'type': 'opt'}],
      \ ['dag/vim-fish', {'type': 'opt'}],
      \ ['dhruvasagar/vim-table-mode', {'type': 'opt'}],
      \ ['eagletmt/ghcmod-vim', {'type': 'opt', 'do': 'silent! !stack install ghc-mod'}, executable('stack')],
      \ ['eagletmt/neco-ghc', {'type': 'opt'}],
      \ ['ekalinin/Dockerfile.vim', {'type': 'opt'}],
      \ ['fatih/vim-go', {'type': 'opt'}],
      \ ['flowtype/vim-flow', {'type': 'opt', 'do': 'silent! !npm i -g flow-bin'}],
      \ ['itchyny/vim-haskell-indent', {'type': 'opt'}],
      \ ['itchyny/vim-haskell-sort-import', {'type': 'opt'}],
      \ ['joshdick/onedark.vim', {'type': 'opt'}],
      \ ['kannokanno/previm', {'type': 'opt'}],
      \ ['kchmck/vim-coffee-script', {'type': 'opt'}],
      \ ['keremc/asyncomplete-racer.vim', {'type': 'opt'}],
      \ ['kristijanhusak/vim-hybrid-material', {'type': 'opt'}],
      \ ['kylef/apiblueprint.vim', {'type': 'opt'}],
      \ ['leafgarland/typescript-vim', {'type': 'opt'}],
      \ ['lifepillar/vim-solarized8', {'type': 'opt'}],
      \ ['morhetz/gruvbox', {'type': 'opt'}],
      \ ['neovimhaskell/haskell-vim', {'type': 'opt'}],
      \ ['othree/es.next.syntax.vim', {'type': 'opt'}],
      \ ['othree/javascript-libraries-syntax.vim', {'type': 'opt'}],
      \ ['pangloss/vim-javascript', {'type': 'opt'}],
      \ ['posva/vim-vue', {'type': 'opt'}],
      \ ['prabirshrestha/asyncomplete-flow.vim', {'type': 'opt'}],
      \ ['prabirshrestha/asyncomplete-necosyntax.vim', {'type': 'opt'}],
      \ ['prabirshrestha/asyncomplete-necovim.vim', {'type': 'opt'}],
      \ ['prabirshrestha/asyncomplete-tscompletejob.vim', {'type': 'opt'}],
      \ ['rhysd/rust-doc.vim', {'type': 'opt'}, executable('cargo')],
      \ ['rhysd/vim-gfm-syntax', {'type': 'opt'}],
      \ ['rust-lang/rust.vim', {'type': 'opt'}],
      \ ['stephpy/vim-yaml', {'type': 'opt'}],
      \ ['thinca/vim-qfreplace', {'type': 'opt'}],
      \ ]

      " \ ['prabirshrestha/asyncomplete-gocode.vim', {'type': 'opt'}],
      " \ ['racer-rust/vim-racer', {'type': 'opt'}, executable('cargo')],
      " \ ['zchee/deoplete-go', {'type': 'opt', 'do': 'silent! !make'}],
      " \ ['Quramy/tsuquyomi', {'type': 'opt'}],
      " \ ['euclio/vim-markdown-composer', {'type': 'opt', 'do': '!cargo build --release'}, executable('cargo') && has('nvim')],
      " \ ['euclio/vim-markdown-composer', {'type': 'opt', 'do': '!cargo build --release --no-default-features --features json-rpc'}, executable('cargo') && !has('nvim')],

" lazy load plugins. {{{2
let s:lazy_plugs = [
      \ ['Konfekt/FastFold', {'type': 'opt'}],
      \ ['LeafCage/yankround.vim', {'type': 'opt'}],
      \ ['Shougo/context_filetype.vim', {'type': 'opt'}],
      \ ['Shougo/echodoc.vim', {'type': 'opt'}],
      \ ['Shougo/junkfile.vim', {'type': 'opt'}],
      \ ['Shougo/neomru.vim', {'type': 'opt'}],
      \ ['Shougo/neosnippet-snippets', {'type': 'opt'}],
      \ ['Shougo/neosnippet.vim', {'type': 'opt'}],
      \ ['Shougo/vimproc.vim', {'type': 'opt', 'do': 'silent! !make'}],
      \ ['airblade/vim-rooter', {'type': 'opt'}],
      \ ['cohama/agit.vim', {'type': 'opt'}],
      \ ['ctrlpvim/ctrlp.vim', {'type': 'opt'}],
      \ ['gilligan/textobj-lastpaste', {'type': 'opt'}],
      \ ['glidenote/memolist.vim', {'type': 'opt'}],
      \ ['haya14busa/incsearch.vim', {'type': 'opt'}],
      \ ['haya14busa/vim-asterisk', {'type': 'opt'}],
      \ ['haya14busa/vim-operator-flashy', {'type': 'opt'}],
      \ ['itchyny/vim-highlighturl', {'type': 'opt'}],
      \ ['iyuuya/denite-ale', {'type': 'opt'}],
      \ ['junegunn/vim-easy-align', {'type': 'opt'}],
      \ ['justinmk/vim-dirvish', {'type': 'opt'}],
      \ ['kana/vim-operator-replace', {'type': 'opt'}],
      \ ['kana/vim-textobj-entire', {'type': 'opt'}],
      \ ['kana/vim-textobj-fold', {'type': 'opt'}],
      \ ['kana/vim-textobj-function', {'type': 'opt'}],
      \ ['kana/vim-textobj-indent', {'type': 'opt'}],
      \ ['kaneshin/ctrlp-filetype', {'type': 'opt'}],
      \ ['kaneshin/ctrlp-memolist', {'type': 'opt'}],
      \ ['kaneshin/ctrlp-sonictemplate', {'type': 'opt'}],
      \ ['kassio/neoterm', {'type': 'opt'}, has('nvim')],
      \ ['lambdalisue/gina.vim', {'type': 'opt'}],
      \ ['ludovicchabant/vim-gutentags', {'type': 'opt'}, executable('ctags')],
      \ ['majutsushi/tagbar', {'type': 'opt'}],
      \ ['mattn/ctrlp-launcher', {'type': 'opt'}],
      \ ['mattn/ctrlp-mark', {'type': 'opt'}],
      \ ['mattn/sonictemplate-vim', {'type': 'opt'}],
      \ ['mattn/webapi-vim', {'type': 'opt'}],
      \ ['osyo-manga/vim-anzu', {'type': 'opt'}],
      \ ['osyo-manga/vim-operator-blockwise', {'type': 'opt'}],
      \ ['osyo-manga/vim-operator-search', {'type': 'opt'}],
      \ ['osyo-manga/vim-textobj-multiblock', {'type': 'opt'}],
      \ ['prabirshrestha/asyncomplete-buffer.vim', {'type': 'opt'}],
      \ ['prabirshrestha/asyncomplete-emoji.vim', {'type': 'opt'}],
      \ ['prabirshrestha/asyncomplete-neosnippet.vim', {'type': 'opt'}],
      \ ['prabirshrestha/asyncomplete-tags.vim', {'type': 'opt'}],
      \ ['qpkorr/vim-renamer', {'type': 'opt'}],
      \ ['rhysd/vim-operator-surround', {'type': 'opt'}],
      \ ['simnalamburt/vim-mundo', {'type': 'opt'}],
      \ ['t9md/vim-quickhl', {'type': 'opt'}],
      \ ['taku-o/vim-zoom', {'type': 'opt'}],
      \ ['thinca/vim-submode', {'type': 'opt'}],
      \ ['tpope/vim-repeat', {'type': 'opt'}],
      \ ['tyru/capture.vim', {'type': 'opt'}],
      \ ['tyru/caw.vim', {'type': 'opt'}],
      \ ['tyru/open-browser.vim', {'type': 'opt'}],
      \ ['vim-scripts/autodate.vim', {'type': 'opt'}],
      \ ['vim-scripts/matchit.zip', {'type': 'opt'}],
      \ ['w0rp/ale', {'type': 'opt'}],
      \ ['y0za/vim-reading-vimrc', {'type': 'opt'}],
      \ ['yami-beta/asyncomplete-omni.vim', {'type': 'opt'}],
      \ ]

      " \ ['Shougo/neocomplete.vim', {'type': 'opt'}, !has('nvim')],
      " \ ['Shougo/deoplete.nvim', {'type': 'opt', 'do': 'silent! UpdateRemotePlugins'}, has('nvim')],

" minpac init. {{{1
if exists('*minpac#init')
  " minpac is loaded.
  call minpac#init()
  call minpac#add('k-takata/minpac', {'type': 'opt'})

  function! s:minpac_add(plugs)
    for plug in a:plugs
      let cond = len(plug) > 2 ? plug[2] : 1
      if cond
        " echom printf("call minpac#add('%s', %s)", plug[0], string(plug[1]))
        exe printf("call minpac#add('%s', %s)", plug[0], string(plug[1]))
      endif
    endfor
  endfunction

  " start. {{{2
  call <SID>minpac_add(s:start_plugs)

  " opt. {{{2
  call <SID>minpac_add(s:opt_plugs)

  " lazy. {{{2
  call <SID>minpac_add(s:lazy_plugs)

endif

" Async load lazy plugins. {{{1
let s:idx = 0
function! PackAddHandler(timer)
  let plug = s:lazy_plugs[s:idx]
  let name = split(plug[0], '/')[1]
  let cond = len(plug) > 2 ? plug[2] : 1
  if cond
    " exe printf("echom 'packadd %s (%d)'", name, s:idx)
    exe 'packadd ' . name
  endif
  let s:idx += 1
  " doautocmd BufReadPost
  au! lazy_load_bundle
  if s:idx == len(s:lazy_plugs)
    echom "lazy load done !"
  endif
endfunction

aug lazy_load_bundle
  au MyAutoCmd VimEnter * call timer_start(1, 'PackAddHandler', {'repeat': len(s:lazy_plugs)})
aug END

" Plugin settings. {{{1
" lightline. {{{2
let g:lightline = {
      \ 'colorscheme': 'jellybeans',
      \ 'mode_map': {
      \   'n' : 'N',
      \   'i' : 'I',
      \   'R' : 'R',
      \   'v' : 'V',
      \   'V' : 'V-L',
      \   'c' : 'C',
      \   "\<C-v>": 'V-B',
      \   's' : 'S',
      \   'S' : 'S-L',
      \   "\<C-s>": 'S-B'
      \   },
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'fugitive', 'filename', 'anzu' ] ]
      \ },
      \ 'component_function': {
      \   'fugitive': 'LightLineFugitive',
      \   'readonly': 'LightLineReadonly',
      \   'modified': 'LightLineModified',
      \   'filename': 'LightLineFilename',
      \   'filetype': 'LightLineFiletype',
      \   'fileformat': 'LightLineFileformat',
      \   'anzu': 'anzu#search_status',
      \ },
      \ 'separator': { 'left': '', 'right': '' },
      \ 'subseparator': { 'left': '', 'right': '' }
      \ }

function! LightLineModified()
  if &filetype == "help"
    return ""
  elseif &modified
    return "+"
  elseif &modifiable
    return ""
  else
    return ""
  endif
endfunction

function! LightLineReadonly()
  if &filetype == "help"
    return ""
  elseif &readonly
    return ""
  else
    return ""
  endif
endfunction

function! LightLineFugitive()
  if exists("*fugitive#head")
    let _ = fugitive#head()
    return strlen(_) ? ''._ : ''
  endif
  return ''
endfunction

function! LightLineFilename()
  return ('' != LightLineReadonly() ? LightLineReadonly() . ' ' : '') .
        \ ('' != expand('%:t') ? expand('%:t') : '[No Name]') .
        \ ('' != LightLineModified() ? ' ' . LightLineModified() : '')
endfunction

function! LightLineFiletype()
  return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype . ' ' . WebDevIconsGetFileTypeSymbol() : 'no ft') : ''
endfunction

function! LightLineFileformat()
  return winwidth(0) > 70 ? (&fileformat . ' ' . WebDevIconsGetFileFormatSymbol()) : ''
endfunction

" let g:lightline = {
"       \ 'colorscheme': 'jellybeans',
"       \ 'mode_map': {
"       \   'n' : 'N',
"       \   'i' : 'I',
"       \   'R' : 'R',
"       \   'v' : 'V',
"       \   'V' : 'V-L',
"       \   'c' : 'C',
"       \   "\<C-v>": 'V-B',
"       \   's' : 'S',
"       \   'S' : 'S-L',
"       \   "\<C-s>": 'S-B'
"       \   },
"       \ 'active': {
"       \   'left': [ [ 'mode', 'paste' ], [ 'filename', 'anzu' ] ],
"       \   'right': [ [ 'lineinfo' ], [ 'percent' ], [ 'fileformat', 'fileencoding', 'bomb', 'filetype' ],
"       \              [ 'absolutepath', 'charcode' ] ]
"       \ },
"       \ 'component': {
"       \   'charcode': '[%03.3b, 0x%02.2B]'
"       \ },
"       \ 'component_function': {
"       \   'modified': 'MyModified',
"       \   'readonly': 'MyReadonly',
"       \   'fugitive': 'MyFugitive',
"       \   'git_branch': 'MyGitBranch',
"       \   'git_traffic': 'MyGitTraffic',
"       \   'git_status': 'MyGitStatus',
"       \   'filename': 'MyFilename',
"       \   'fileformat': 'MyFileformat',
"       \   'filetype': 'MyFiletype',
"       \   'fileencoding': 'MyFileencoding',
"       \   'bomb': 'MyBomb',
"       \   'absolutepath': 'MyAbsolutePath',
"       \   'mode': 'MyMode',
"       \   'anzu': 'anzu#search_status',
"       \ }
"       \ }
" 
" function! MyModified()
"   return &ft =~ 'help\|vimfiler\|gundo' ? '' : &modified ? '+' : &modifiable ? '' : '-'
" endfunction
" 
" function! MyReadonly()
"   if g:is_windows
"     return &ft !~? 'help\|vimfiler\|gundo' && &readonly ? 'R' : ''
"   else
"     return &ft !~? 'help\|vimfiler\|gundo' && &readonly ? '⭤' : ''
"   endif
" endfunction
" 
" function! MyFilename()
"   return ('' != MyReadonly() ? MyReadonly() . ' ' : '') .
"         \ ('' != expand('%:t') ? expand('%:t') : '[No Name]') .
"         \ ('' != MyModified() ? ' ' . MyModified() : '')
" endfunction
" 
" function! MyGitBranch()
"   return winwidth(0) > 70 ? gita#statusline#preset('branch_fancy') : ''
" endfunction
" function! MyGitTraffic()
"   return winwidth(0) > 70 ? gita#statusline#preset('traffic_fancy') : ''
" endfunction
" function! MyGitStatus()
"   return winwidth(0) > 70 ? gita#statusline#preset('status') : ''
" endfunction
" 
" function! MyFugitive()
"   if &ft !~? 'vimfiler\|gundo' && exists("*fugitive#head")
"     let _ = fugitive#head()
"     if g:is_windows
"       return strlen(_) ? '| '._ : ''
"     else
"       return strlen(_) ? '⭠ '._ : ''
"     endif
"   endif
"   return ''
" endfunction
" 
" function! MyFileformat()
"   return winwidth('.') > 70 ? &fileformat : ''
" endfunction
" 
" function! MyFiletype()
"   return winwidth('.') > 70 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
" endfunction
" 
" function! MyFileencoding()
"   return winwidth('.') > 70 ? (strlen(&fenc) ? &fenc : &enc) : ''
" endfunction
" 
" function! MyBomb()
"   return &bomb ? 'b' : 'nb'
" endfunction
" 
" function! MyMode()
"   return winwidth('.') > 60 ? lightline#mode() : ''
" endfunction
" 
" function! MyAbsolutePath()
"   return (winwidth('.') - strlen(expand('%:p')) > 90) ? expand('%:p') : ((winwidth('.') - strlen(expand('%')) > 70) ? expand('%') : '')
" endfunction

" vim-airline. {{{2
let g:airline_powerline_fonts = 1
let g:airline_detect_iminsert = 1
let g:airline_symbols_ascii = 0
let g:airline_mode_map = {
      \ '__' : '-',
      \ 'n'  : 'N',
      \ 'i'  : 'I',
      \ 'R'  : 'R',
      \ 'c'  : 'C',
      \ 'v'  : 'V',
      \ 'V'  : 'V',
      \ '' : 'V',
      \ 's'  : 'S',
      \ 'S'  : 'S',
      \ '' : 'S',
      \ }

if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

" powerline symbols
" let g:airline_left_sep = ''
" let g:airline_left_alt_sep = ''
" let g:airline_right_sep = ''
" let g:airline_right_alt_sep = ''
" let g:airline_symbols.branch = ''
" let g:airline_symbols.readonly = ''
" let g:airline_symbols.linenr = '☰'
" let g:airline_symbols.maxlinenr = ''

" unicode symbols
" let g:airline_left_sep = '»'
" let g:airline_left_sep = '▶'
" let g:airline_right_sep = '«'
" let g:airline_right_sep = '◀'
" let g:airline_symbols.crypt = '🔒'
" let g:airline_symbols.linenr = '☰'
" let g:airline_symbols.linenr = '␊'
" let g:airline_symbols.linenr = '␤'
" let g:airline_symbols.linenr = '¶'
" let g:airline_symbols.maxlinenr = ''
" let g:airline_symbols.maxlinenr = '㏑'
" let g:airline_symbols.branch = '⎇'
" let g:airline_symbols.paste = 'ρ'
" let g:airline_symbols.paste = 'Þ'
" let g:airline_symbols.paste = '∥'
" let g:airline_symbols.spell = 'Ꞩ'
" let g:airline_symbols.notexists = '∄'
" let g:airline_symbols.whitespace = 'Ξ'

" extensions
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#switch_buffers_and_tabs = 1

" theme
let g:airline_theme = 'zenburn'


" indentLine. {{{2
let g:indentLine_faster = 1
let g:indentLine_fileTypeExclude = ['help', 'nerdtree', 'calendar', 'thumbnail', 'denite', 'vimfiler', 'tweetvim']
nnoremap <silent><Leader>i :<C-u>IndentLinesToggle<CR>

" deoplete.nvim. {{{2
let g:deoplete#enable_at_startup = 1

" neocomplete.vim. {{{2
let g:neocomplete#enable_at_startup = 1

" neosnippet.vim {{{2
imap <C-k> <Plug>(neosnippet_expand_or_jump)
smap <C-k> <Plug>(neosnippet_expand_or_jump)
xmap <C-k> <Plug>(neosnippet_expand_target)
" Tell Neosnippet about the other snippets
let g:neosnippet#snippets_directory = $VIM_PATH . '/snippets'

" For snippet_complete marker.
if has('conceal')
  set conceallevel=2 concealcursor=i
endif

" vim-rooter. {{{2
let g:rooter_use_lcd = 1
let g:rooter_silent_chdir = 1
let g:rooter_manual_only = 1

" vim-submode. {{{2
let g:submode_leave_with_key = 1

au MyAutoCmd VimEnter * call <SID>vim_submode_aft()
function! s:vim_submode_aft() abort
  packadd vim-submode
  call submode#enter_with('bufmove', 'n', '', 's>', '<C-w>>')
  call submode#enter_with('bufmove', 'n', '', 's<', '<C-w><')
  call submode#enter_with('bufmove', 'n', '', 's+', '<C-w>+')
  call submode#enter_with('bufmove', 'n', '', 's-', '<C-w>-')
  call submode#map('bufmove', 'n', '', '>', '<C-w>>')
  call submode#map('bufmove', 'n', '', '<', '<C-w><')
  call submode#map('bufmove', 'n', '', '+', '<C-w>+')
  call submode#map('bufmove', 'n', '', '-', '<C-w>-')
endfunction

" FastFold. {{{2
let g:fastfold_savehook = 0

" vim-easy-align. {{{2
vmap <Enter> <Plug>(EasyAlign)

let g:easy_align_delimiters = {
      \ '>': {
      \       'pattern': '>>\|=>\|>.\+',
      \       'right_margin': 0,
      \       'delimiter_align': 'l'
      \   },
      \ '/': {
      \       'pattern': '//\+\|/\*\|\*/',
      \       'delimiter_align': 'l',
      \       'ignore_groups': ['!Comment']
      \   },
      \ ']': {
      \       'pattern': '[[\]]',
      \       'left_margin': 0,
      \       'right_margin': 0,
      \       'stick_to_left': 0
      \   },
      \ ')': {
      \       'pattern': '[()]',
      \       'left_margin': 0,
      \       'right_margin': 0,
      \       'stick_to_left': 0
      \   },
      \ 'd': {
      \       'pattern': ' \(\S\+\s*[;=]\)\@=',
      \       'left_margin': 0,
      \       'right_margin': 0
      \   },
      \ 'p': {
      \       'pattern': 'pos=\|size=',
      \       'right_margin': 0
      \   },
      \ 's': {
      \       'pattern': 'sys=\|Trns=',
      \       'right_margin': 0
      \   },
      \ 'k': {
      \       'pattern': 'key=\|cmt=',
      \       'right_margin': 0
      \   },
      \ 'c': {
      \       'pattern': 'cmt=',
      \       'right_margin': 0
      \   },
      \ ':': {
      \       'pattern': ':',
      \       'left_margin': 1,
      \       'right_margin': 1,
      \       'stick_to_left': 0,
      \       'ignore_groups': []
      \   },
      \ 't': {
      \       'pattern': "\<tab>",
      \       'left_margin': 0,
      \       'right_margin': 0
      \   },
      \ ';': {
      \       'pattern': ';',
      \       'left_margin': 1,
      \       'right_margin': 1,
      \       'stick_to_left': 0,
      \       'ignore_groups': []
      \   }
      \ }

" yankround.vim. {{{2
nmap p <Plug>(yankround-p)
nmap P <Plug>(yankround-P)
nmap <C-p> <Plug>(yankround-prev)
nmap <C-n> <Plug>(yankround-next)
let g:yankround_max_history = 100

" vim-operator-replace. {{{2
map _ <Plug>(operator-replace)

" vim-operator-surround. {{{2
map sA <Plug>(operator-surround-append)
map sD <Plug>(operator-surround-delete)
map sR <Plug>(operator-surround-replace)

" vim-operator-blockwise. {{{2
" nmap YY <Plug>(operator-blockwise-yank-head)
" nmap DD <Plug>(operator-blockwise-delete-head)
" nmap CC <Plug>(operator-blockwise-change-head)

" vim-operator-search. {{{2
nmap [Space]/ <Plug>(operator-search)

" vim-operator-flashy. {{{2
map y <Plug>(operator-flashy)
nmap Y <Plug>(operator-flashy)$

" vim-textobj-multiblock. {{{2
omap ab <Plug>(textobj-multiblock-a)
omap ib <Plug>(textobj-multiblock-i)
xmap ab <Plug>(textobj-multiblock-a)
xmap ib <Plug>(textobj-multiblock-i)

" vim-textobj-entire. {{{2
omap ae <Plug>(textobj-entire-a)
xmap ae <Plug>(textobj-entire-a)
omap ie <Plug>(textobj-entire-i)
xmap ie <Plug>(textobj-entire-i)

" vim-textobj-fold. {{{2
omap az <Plug>(textobj-fold-a)
xmap az <Plug>(textobj-fold-a)
omap iz <Plug>(textobj-fold-i)
xmap iz <Plug>(textobj-fold-i)

" vim-textobj-function. {{{2
omap af <Plug>(textobj-function-a)
xmap af <Plug>(textobj-function-a)
omap if <Plug>(textobj-function-i)
xmap if <Plug>(textobj-function-i)
omap aF <Plug>(textobj-function-A)
xmap aF <Plug>(textobj-function-A)
omap iF <Plug>(textobj-function-I)
xmap iF <Plug>(textobj-function-I)

" vim-textobj-indent. {{{2
omap ai <Plug>(textobj-indent-a)
xmap ai <Plug>(textobj-indent-a)
omap ii <Plug>(textobj-indent-i)
xmap ii <Plug>(textobj-indent-i)
omap aI <Plug>(textobj-indent-same-a)
xmap aI <Plug>(textobj-indent-same-a)
omap iI <Plug>(textobj-indent-same-i)
xmap iI <Plug>(textobj-indent-same-i)

" textobj-lastpaste. {{{2
let g:textobj_comment_no_default_key_mappings = 1
omap iP <Plug>(textobj-lastpaste-i)
xmap iP <Plug>(textobj-lastpaste-i)

" memolist.vim. {{{2
if isdirectory($HOME . '/Dropbox')
  let g:memolist_path = $HOME . '/Dropbox/memolist'
else
  let g:memolist_path = $HOME . '/.memolist'
endif

call Mkdir(g:memolist_path)

let g:memolist_denite = 0
let g:memolist_memo_suffix = "md"
let g:memolist_prompt_tags = 1

nnoremap <Leader>mn :<C-u>MemoNew<CR>
nnoremap <Leader>ml :<C-u>MemoList<CR>
nnoremap <Leader>mg :<C-u>MemoGrep<CR>


" sonictemplate-vim. {{{2
let g:sonictemplate_vim_template_dir = $HOME . '/.vim/template'
let g:sonictemplate_vim_vars = {
      \ '_': {
      \   'author': 'yukimemi',
      \   'mail': 'yukimemi@gmail.com',
      \ }
      \ }

" autodate.vim {{{2
let g:autodate_format = "%Y/%m/%d %H:%M:%S"
let g:autodate_keyword_pre  = "Last Change *:"
let g:autodate_keyword_post = "."

" vim-mundo. {{{2
nnoremap [Space]u :MundoToggle<CR>

" ale. {{{2
let g:ale_linters = {
      \ 'go': ['golint', 'go vet', 'goimports'],
      \ 'haskell': ['hlint']
      \ }
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_enter = 0
let g:ale_lint_on_insert_leave = 0
let g:ale_lint_on_save = 1
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

let g:ale_fix_on_save = 1
let g:ale_fixers = {
      \ 'javascript': ['prettier'],
      \ 'javascript.jsx': ['prettier'],
      \ 'typescript': ['prettier'],
      \ 'typescript.tsx': ['prettier'],
      \ }

" Rust.
let g:ale_rust_ignore_error_codes = ['E0432', 'E0433']

" vim-dirvish. {{{2
" Don't use netrw.
let g:loaded_netrwPlugin = 1
nnoremap [Space]v :<C-u>Dirvish<CR>

" neoterm. {{{2
if ! g:is_windows
  let g:neoterm_autoinsert = 1
  nnoremap [Space]s :<C-u>terminal<CR>
  tnoremap sj <C-\><C-n><C-w>j
  tnoremap sk <C-\><C-n><C-w>k
  tnoremap sl <C-\><C-n><C-w>l
  tnoremap sh <C-\><C-n><C-w>h
endif

" vim-findent. {{{2
let g:findent#enable_messages = 0
let g:findent#enable_warnings = 0
au MyAutoCmd BufRead * Findent

" echodoc.vim {{{2
let g:echodoc_enable_at_startup = 1

" denite.nvim {{{2
" Use plefix s
nnoremap sdc :<C-u>Denite colorscheme -auto-preview<CR>
nnoremap sdb :<C-u>Denite buffer<CR>
nnoremap sdf :<C-u>Denite file<CR>
nnoremap sdF :<C-u>Denite file_rec<CR>
" nnoremap sdu :<C-u>Denite buffer file_old<CR>
nnoremap sdd :<C-u>Denite buffer file_mru file_rec<CR>
nnoremap sdo :<C-u>Denite outline -no-quit -mode=normal<CR>
nnoremap sdh :<C-u>Denite help<CR>
nnoremap sdr :<C-u>Denite register<CR>
nnoremap sdg :<C-u>Denite -no-empty grep<CR>
nnoremap sd/ :<C-u>Denite line -no-quit<CR>
nnoremap sdR :<C-u>Denite -resume<CR>

noremap sdl :<C-u>Denite command_history<CR>

" Incremental search in cmdline history.
inoremap <C-l> <ESC>:<C-u>Denite command<CR>

" Load after settings.
au MyAutoCmd VimEnter * call <SID>denite_aft()
function! s:denite_aft() abort
  packadd denite.nvim
  " Default options.
  call denite#custom#option('default', {
        \ 'prompt': '»',
        \ 'cursor_wrap': v:true,
        \ 'auto_resize': v:true,
        \ 'highlight_mode_insert': 'WildMenu'
        \ })

  if executable('rg')
    " Ripgrep command on grep source
    call denite#custom#var('grep', 'command', ['rg'])
    call denite#custom#var('grep', 'default_opts',
          \ ['--vimgrep', '--no-heading'])
    call denite#custom#var('grep', 'recursive_opts', [])
    call denite#custom#var('grep', 'pattern_opt', ['--regexp'])
    call denite#custom#var('grep', 'separator', ['--'])
    call denite#custom#var('grep', 'final_opts', [])

  elseif executable('jvgrep')
    " jvgrep command on grep source
    call denite#custom#var('grep', 'command', ['jvgrep'])
    call denite#custom#var('grep', 'default_opts', [])
    call denite#custom#var('grep', 'recursive_opts', ['-R'])
    call denite#custom#var('grep', 'pattern_opt', [])
    call denite#custom#var('grep', 'separator', [])
    call denite#custom#var('grep', 'final_opts', [])

  elseif executable('pt')
    " Pt command on grep source
    call denite#custom#var('grep', 'command', ['pt'])
    call denite#custom#var('grep', 'default_opts',
          \ ['--nogroup', '--nocolor', '--smart-case'])
    call denite#custom#var('grep', 'recursive_opts', [])
    call denite#custom#var('grep', 'pattern_opt', [])
    call denite#custom#var('grep', 'separator', ['--'])
    call denite#custom#var('grep', 'final_opts', [])
  endif
  " custom mappings.
  call denite#custom#map('insert', '<C-n>', '<denite:move_to_next_line>', 'noremap')
  call denite#custom#map('insert', '<C-p>', '<denite:move_to_previous_line>', 'noremap')
  call denite#custom#map('insert', '<C-[>', '<denite:enter_mode:normal>', 'noremap')
  call denite#custom#map('normal', '<C-[>', '<denite:quit>', 'noremap')
endfunction


" incsearch.vim. {{{2
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)

let g:incsearch#auto_nohlsearch = 1
map n   <Plug>(incsearch-nohl)<Plug>(anzu-n)zv
map N   <Plug>(incsearch-nohl)<Plug>(anzu-N)zv
map *   <Plug>(incsearch-nohl)<Plug>(asterisk-*)zv
map g*  <Plug>(incsearch-nohl)<Plug>(asterisk-g*)zv
map #   <Plug>(incsearch-nohl)<Plug>(asterisk-#)zv
map g#  <Plug>(incsearch-nohl)<Plug>(asterisk-g#)zv

map z*  <Plug>(incsearch-nohl0)<Plug>(asterisk-z*)
map gz* <Plug>(incsearch-nohl0)<Plug>(asterisk-gz*)
map z#  <Plug>(incsearch-nohl0)<Plug>(asterisk-z#)
map gz# <Plug>(incsearch-nohl0)<Plug>(asterisk-gz#)

" vim-quickhl. {{{2
let g:quickhl_manual_enable_at_startup = 1

nmap [Space]m <Plug>(quickhl-manual-this)
xmap [Space]m <Plug>(quickhl-manual-this)
nmap [Space]M <Plug>(quickhl-manual-reset)
xmap [Space]M <Plug>(quickhl-manual-reset)

let g:quickhl_manual_keywords = [
      \ "失敗",
      \ "警告",
      \ "エラー",
      \ "異常",
      \ "warn",
      \ "WARN",
      \ "error",
      \ "ERROR",
      \ ]

" vim-parenmatch. {{{2
let g:loaded_matchparen = 1

" vim-cursorword. {{{2
function! s:ToggleCursorWord() abort
  let b:cursorword = !get(b:, 'cursorword', 1)
endfunction

com! ToggleCursorWord call s:ToggleCursorWord()

" vim-qfreplace. {{{2
au MyAutoCmd FileType quickfix,qf packadd vim-qfreplace

" deoplete-go. {{{2
" au MyAutoCmd FileType go packadd deoplete-go
" let g:deoplete#sources#go#use_cache = 1
" let g:deoplete#sources#go#json_directory = '~/.cache/deoplete/go/$GOOS_$GOARCH'
" let g:deoplete#sources#go#gocode_binary = $GOPATH.'/bin/gocode'
" let g:deoplete#sources#go#sort_class = ['package', 'func', 'type', 'var', 'const']

" caw.vim. {{{2
nmap gc <Plug>(caw:prefix)
xmap gc <Plug>(caw:prefix)
nmap gcc <Plug>(caw:hatpos:toggle)
xmap gcc <Plug>(caw:hatpos:toggle)

" gina.vim. {{{2
nnoremap [Space]gs :<C-u>Gina status<CR>
nnoremap [Space]gb :<C-u>Gina branch<CR>
nnoremap [Space]gg :<C-u>Gina grep<CR>
nnoremap [Space]gd :<C-u>Gina diff<CR>
nnoremap [Space]gl :<C-u>Gina ls-files<CR>
nnoremap [Space]gp :<C-u>Gina push<CR>

" vim-go. {{{2
let g:go_auto_type_info = 1
let g:go_snippet_engine = "neosnippet"
let g:go_fmt_command = "goimports"

let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_fields = 1
let g:go_highlight_structs = 1
let g:go_highlight_interfaces = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1

let g:go_metalinter_autosave = 1
let g:go_fmt_autosave = 0
let g:go_gocode_unimported_packages = 1
" au MyAutoCmd BufWritePost *.go GoMetaLinter
" au MyAutoCmd BufWritePre *.go silent GoFmt

au MyAutoCmd BufNew,BufRead *.go call <SID>vim_go_cfg()

function! s:vim_go_cfg() abort
  packadd vim-go
  setl foldmethod=syntax
  setl tabstop=4
  setl shiftwidth=4
  setl softtabstop=0
  setl noexpandtab

  nmap <buffer> <Leader>gd <Plug>(go-doc)
  nmap <buffer> <Leader>gs <Plug>(go-doc-split)
  nmap <buffer> <Leader>gv <Plug>(go-doc-vertical)
  nmap <buffer> <Leader>gb <Plug>(go-doc-browser)
  nmap <buffer> <Leader>gr <Plug>(go-rename)

  " nmap <buffer> <Leader>r <Plug>(go-run)
  nmap <buffer> <Leader>gb <Plug>(go-build)
  nmap <buffer> <Leader>gt <Plug>(go-test)
  nmap <buffer> <Leader>gc <Plug>(go-coverage)

  nmap <buffer> <Leader>ds <Plug>(go-def-split)
  nmap <buffer> <Leader>dv <Plug>(go-def-vertical)
  nmap <buffer> <Leader>dt <Plug>(go-def-tab)
  nnoremap <buffer> <Leader>gi :<C-u>GoImport<Space>

  setl completeopt=menu,preview
endfunction

" vim-ps1. {{{2
au MyAutoCmd BufNew,BufRead *.ps1 packadd vim-ps1
function! s:addHeaderPs1(flg)
  setl fenc=cp932
  setl ff=dos
  let lines = []
  if a:flg
    call add(lines, "@set scriptPath=%~f0&@powershell -NoProfile -ExecutionPolicy ByPass -InputFormat None \"$s=[scriptblock]::create((gc \\\"%~f0\\\"|?{$_.readcount -gt 2})-join\\\"`n\\\");&$s\" %*")
  else
    call add(lines, "@set scriptPath=%~f0&@powershell -Version 2.0 -NoProfile -ExecutionPolicy ByPass -InputFormat None \"$s=[scriptblock]::create((gc \\\"%~f0\\\"|?{$_.readcount -gt 2})-join\\\"`n\\\");&$s\" %*&@ping -n 30 localhost>nul")
  endif
  call add(lines, "@exit /b %errorlevel%")
  call extend(lines, readfile(expand("%")))
  let i = 0
  for line in lines
    if len(lines) != (i + 1)
      let lines[i] .= "\r"
    endif
    let i += 1
  endfor
  " let s:basedir = expand("%:p:h") . "/../cmd/"
  let s:basedir = expand("%:p:h") . "/"
  let s:cmdFile = expand("%:p:t:r") . ".cmd"
  call Mkdir(s:basedir)
  call writefile(lines,  s:basedir . s:cmdFile, "b")
  echo "Write " . s:basedir . expand("%:p:t:r") . ".cmd"
endfunction
" au MyAutoCmd BufWritePost *.ps1 call <SID>addHeaderPs1(0)
au MyAutoCmd FileType ps1 nnoremap <buffer> <expr><Leader>m <SID>addHeaderPs1(1)
au MyAutoCmd FileType ps1 nnoremap <buffer> <expr><Leader>b <SID>addHeaderPs1(0)

" vim-toml. {{{2
au MyAutoCmd FileType toml packadd vim-toml

" vim-yaml. {{{2
au MyAutoCmd FileType yaml packadd vim-yaml

" plantuml-syntax. {{{2
au MyAutoCmd FileType plantuml packadd plantuml-syntax

" vim-log-syntax. {{{2
" au MyAutoCmd FileType log packadd vim-log-syntax

" vim-vue. {{{2
au MyAutoCmd FileType vue packadd vim-vue

" vim-javascript. {{{2
au MyAutoCmd FileType javascript,javascript.jsx packadd vim-javascript


" javascript-libraries-syntax.vim. {{{2
au MyAutoCmd FileType javascript,javascript.jsx packadd javascript-libraries-syntax.vim

" es.next.syntax.vim. {{{2
au MyAutoCmd FileType javascript,javascript.jsx packadd es.next.syntax.vim

" vim-flow. {{{2
au MyAutoCmd FileType javascript,javascript.jsx packadd vim-flow
let g:flow#autoclose = 1

" typescript-vim. {{{2
au MyAutoCmd BufNew,BufRead *.ts setl ft=typescript
au MyAutoCmd BufNew,BufRead *.tsx setl ft=typescript.tsx
au MyAutoCmd FileType typescript,typescript.tsx packadd typescript-vim

" vim-coffee-script. {{{2
au MyAutoCmd FileType coffee packadd vim-coffee-script

" vim-fish. {{{2
au MyAutoCmd BufNew,BufRead *.fish setl ft=fish
au MyAutoCmd FileType fish packadd vim-fish

" vim-gfm-syntax. {{{2
au MyAutoCmd FileType markdown packadd vim-gfm-syntax

" Dockerfile.vim. {{{2
au MyAutoCmd FileType dockerfile packadd Dockerfile.vim

" rust.vim. {{{2
au MyAutoCmd FileType rust packadd rust.vim
let g:rust_bang_comment_leader = 1
let g:rust_conceal = 0
let g:rust_conceal_mod_path = 0
let g:rust_conceal_pub = 0
let g:rust_fold = 1
let g:rust_recommended_style = 1
let g:rustfmt_autosave = 1

" vim-racer. {{{2
" au MyAutoCmd FileType rust call <SID>vim_racer_aft()
let g:racer_experimental_completer = 1

function! s:vim_racer_aft() abort
  packadd vim-racer
  setl completeopt=menu,preview
  nmap <buffer> gd <Plug>(rust-def)
  nmap <buffer> gs <Plug>(rust-def-split)
  nmap <buffer> gx <Plug>(rust-def-vertical)
  nmap <buffer> K <Plug>(rust-doc)
endfunction

" rust-doc.vim. {{{2
au MyAutoCmd FileType rust packadd rust-doc.vim

" ghcmod-vim. {{{2
au MyAutoCmd FileType haskell call <SID>ghcmod_vim_aft()

function! s:ghcmod_vim_aft() abort
  packadd ghcmod-vim
  setl completeopt=menu,preview
  nnoremap <buffer> K :<C-u>GhcModInfoPreview<CR>
endfunction

" neco-ghc. {{{2
au MyAutoCmd FileType haskell packadd neco-ghc | setl omnifunc=necoghc#omnifunc

" vim-haskell-indent. {{{2
au MyAutoCmd FileType haskell packadd vim-haskell-indent

" vim-haskell-sort-import. {{{2
au MyAutoCmd FileType haskell packadd vim-haskell-sort-import
au MyAutoCmd BufWritePre *.hs HaskellSortImport

" haskell-vim. {{{2
au MyAutoCmd FileType haskell,cabal packadd haskell-vim
let g:haskell_enable_quantification = 1   " to enable highlighting of `forall`
let g:haskell_enable_recursivedo = 1      " to enable highlighting of `mdo` and `rec`
let g:haskell_enable_arrowsyntax = 1      " to enable highlighting of `proc`
let g:haskell_enable_pattern_synonyms = 1 " to enable highlighting of `pattern`
let g:haskell_enable_typeroles = 1        " to enable highlighting of type roles
let g:haskell_enable_static_pointers = 1  " to enable highlighting of `static`
let g:haskell_backpack = 1                " to enable highlighting of backpack keywords

" vim-hindent. {{{2
au MyAutoCmd FileType haskell packadd vim-hindent
let g:hindent_on_save = 1
let g:hindent_indent_size = 2
let g:hindent_line_length = 100

" vim-sqlfmt. {{{2
au MyAutoCmd FileType sql packadd vim-sqlfmt
let g:sqlfmt_command = "sqlformat"
let g:sqlfmt_options = "-r -k upper"

" apiblueprint.vim. {{{2
au MyAutoCmd FileType apiblueprint packadd apiblueprint.vim

" vim-renamer. {{{2
nmap <Leader>r <Plug>RenamerStart

" tagbar. {{{2
nnoremap <F8> :<C-u>TagbarToggle<CR>
let g:tagbar_type_rust = {
      \ 'ctagstype' : 'rust',
      \   'kinds' : [
      \     'T:types,type definitions',
      \     'f:functions,function definitions',
      \     'g:enum,enumeration names',
      \     's:structure names',
      \     'm:modules,module names',
      \     'c:consts,static constants',
      \     't:traits',
      \     'i:impls,trait implementations',
      \   ]
      \ }

let g:tagbar_type_markdown = {
      \ 'ctagstype' : 'markdown',
      \   'kinds' : [
      \     'h:Heading_L1',
      \     'i:Heading_L2',
      \     'k:Heading_L3'
      \   ]
      \ }


" vim-startify. {{{2
let g:startify_bookmarks = [
      \ '~/.vimrc',
      \ '~/.config/nvim/minpac.vim',
      \ '~/.config/nvim/dein.toml',
      \ '~/.zshrc',
      \ '~/.zshenv',
      \ ]

" ctrlp.vim. {{{2
let g:ctrlp_map = '<nop>'
let g:ctrlp_use_caching = 1
let g:ctrlp_show_hidden = 1
let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_lazy_update = 1
let g:ctrlp_extensions = ['line', 'changes', 'mixed', 'bookmarkdir', 'memolist']
nnoremap scp :<C-u>CtrlP<CR>
nnoremap scb :<C-u>CtrlPBuffer<CR>
nnoremap scd :<C-u>CtrlPCurWD<CR>
nnoremap scu :<C-u>CtrlPMRU<CR>
nnoremap scm :<C-u>CtrlPMark<CR>
" nnoremap scl :<C-u>CtrlPLine<CR>
nnoremap scg :<C-u>CtrlPChange<CR>
nnoremap scc :<C-u>CtrlPMixed<CR>
nnoremap scf :<C-u>CtrlPFiletype<CR>
" nnoremap scl :<C-u>CtrlPLauncher<CR>
nnoremap sct :<C-u>CtrlPSonictemplate<CR>

nnoremap scl :<C-u>CtrlPMemolist<CR>

if executable('rg')
  let g:ctrlp_user_command ='rg -F --files %s'
endif



" vim-devicons. {{{2
let g:WebDevIconsUnicodeDecorateFolderNodes = 1

" asyncomplete.vim. {{{2
let g:asyncomplete_auto_popup = 1
let g:asyncomplete_remove_duplicates = 1
let g:asyncomplete_force_refresh_on_context_changed = 1

" asyncomplete-buffer.vim. {{{3
au MyAutoCmd User asyncomplete_setup packadd asyncomplete-buffer.vim | call asyncomplete#register_source(asyncomplete#sources#buffer#get_source_options({
      \ 'name': 'buffer',
      \ 'whitelist': ['*'],
      \ 'blacklist': ['go'],
      \ 'priority': 1,
      \ 'completor': function('asyncomplete#sources#buffer#completor'),
      \ }))

" asyncomplete-emoji.vim. {{{3
au MyAutoCmd User asyncomplete_setup packadd asyncomplete-emoji.vim | call asyncomplete#register_source(asyncomplete#sources#emoji#get_source_options({
      \ 'name': 'emoji',
      \ 'whitelist': ['*'],
      \ 'priority': 1,
      \ 'completor': function('asyncomplete#sources#emoji#completor'),
      \ }))

" asyncomplete-tags.vim. {{{3
au MyAutoCmd User asyncomplete_setup packadd asyncomplete-tags.vim | call asyncomplete#register_source(asyncomplete#sources#tags#get_source_options({
      \ 'name': 'tags',
      \ 'whitelist': ['*'],
      \ 'priority': 2,
      \ 'completor': function('asyncomplete#sources#tags#completor'),
      \ 'config': {
      \    'max_file_size': 20000000,
      \ }
      \ }))

" asyncomplete-omni.vim. {{{3
au MyAutoCmd User asyncomplete_setup packadd asyncomplete-omni.vim | call asyncomplete#register_source(asyncomplete#sources#omni#get_source_options({
      \ 'name': 'omni',
      \ 'whitelist': ['*'],
      \ 'blacklist': ['go', 'rust'],
      \ 'priority': 3,
      \ 'completor': function('asyncomplete#sources#omni#completor')
      \ }))

" asyncomplete-neosnippet.vim. {{{3
au MyAutoCmd User asyncomplete_setup packadd asyncomplete-neosnippet.vim | call asyncomplete#register_source(asyncomplete#sources#neosnippet#get_source_options({
      \ 'name': 'neosnippet',
      \ 'whitelist': ['*'],
      \ 'priority': 3,
      \ 'completor': function('asyncomplete#sources#neosnippet#completor'),
      \ }))

" vim-lsp. {{{3
" Docker. {{{4
if executable('docker-langserver')
  au MyAutoCmd User lsp_setup call lsp#register_server({
        \ 'name': 'docker-langserver',
        \ 'cmd': {server_info->[&shell, &shellcmdflag, 'docker-langserver --stdio']},
        \ 'priority': 4,
        \ 'whitelist': ['dockerfile'],
        \ })
endif

" go. {{{4
if executable('go-langserver')
  au MyAutoCmd User lsp_setup call lsp#register_server({
        \ 'name': 'go-langserver',
        \ 'cmd': {server_info->['go-langserver', '-mode', 'stdio']},
        \ 'priority': 4,
        \ 'whitelist': ['go'],
        \ })
endif

" python. {{{4
if executable('pyls')
  au MyAutoCmd User lsp_setup call lsp#register_server({
        \ 'name': 'pyls',
        \ 'cmd': {server_info->['pyls']},
        \ 'priority': 4,
        \ 'whitelist': ['python'],
        \ })
endif

" rust. {{{4
if executable('rls')
  au MyAutoCmd User lsp_setup call lsp#register_server({
        \ 'name': 'rls',
        \ 'cmd': {server_info->['rustup', 'run', 'nightly', 'rls']},
        \ 'priority': 4,
        \ 'whitelist': ['rust'],
        \ })
endif

" flow. {{{4
if executable('flow-language-server')
  au MyAutoCmd User lsp_setup call lsp#register_server({
        \ 'name': 'flow-language-server',
        \ 'cmd': {server_info->[&shell, &shellcmdflag, 'flow-language-server --stdio']},
        \ 'priority': 4,
        \ 'root_uri':{server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), '.flowconfig'))},
        \ 'whitelist': ['javascript'],
        \ })
endif

" asyncomplete-necovim.vim. {{{3
au MyAutoCmd FileType vim call <SID>asyncomplete_necovim_aft()
function! s:asyncomplete_necovim_aft() abort
  packadd asyncomplete-necovim.vim
  call asyncomplete#register_source(asyncomplete#sources#necovim#get_source_options({
        \ 'name': 'necovim',
        \ 'whitelist': ['vim'],
        \ 'priority': 4,
        \ 'completor': function('asyncomplete#sources#necovim#completor'),
        \ }))
endfunction

" asyncomplete-necosyntax.vim. {{{3
au MyAutoCmd FileType vim call <SID>asyncomplete_necosyntax_aft()
function! s:asyncomplete_necosyntax_aft() abort
  packadd asyncomplete-necosyntax.vim
  call asyncomplete#register_source(asyncomplete#sources#necosyntax#get_source_options({
        \ 'name': 'necosyntax',
        \ 'whitelist': ['*'],
        \ 'priority': 4,
        \ 'completor': function('asyncomplete#sources#necosyntax#completor'),
        \ }))
endfunction

" asyncomplete-racer.vim. {{{3
if !executable('rls')
  au MyAutoCmd FileType rust call <SID>asyncomplete_racer_aft()
endif
function! s:asyncomplete_racer_aft() abort
  packadd asyncomplete-racer.vim
  call asyncomplete#register_source(asyncomplete#sources#racer#get_source_options({
        \ 'priority': 4,
        \ }))
endfunction

" asyncomplete-flow.vim. {{{3
if !executable('flow-language-server')
  au MyAutoCmd FileType javascript,json call <SID>asyncomplete_flow_aft()
endif
function! s:asyncomplete_flow_aft() abort
  packadd asyncomplete-flow.vim
  call asyncomplete#register_source(asyncomplete#sources#flow#get_source_options({
        \ 'name': 'flow',
        \ 'whitelist': ['javascript'],
        \ 'priority': 4,
        \ 'completor': function('asyncomplete#sources#flow#completor'),
        \ 'config': {
        \    'prefer_local': 1
        \  },
        \ }))
endfunction

" asyncomplete-gocode.vim. {{{3
if !executable('go-langserver')
  au MyAutoCmd FileType go call <SID>asyncomplete_gocode_aft()
endif
function! s:asyncomplete_gocode_aft() abort
  packadd asyncomplete-gocode.vim
  call asyncomplete#register_source(asyncomplete#sources#gocode#get_source_options({
        \ 'name': 'gocode',
        \ 'whitelist': ['go'],
        \ 'priority': 4,
        \ 'completor': function('asyncomplete#sources#gocode#completor'),
        \ }))
endfunction

" vim-singleton. {{{2
if !has('nvim') && has('clientserver')
  packl | call singleton#enable()
endif

" vim-table-mode. {{{2
au MyAutoCmd FileType markdown packadd vim-table-mode

" previm. {{{2
au MyAutoCmd FileType markdown packadd previm
let g:previm_enable_realtime = 0
let g:previm_disable_default_css = 1

" vim-edgemotion. {{{2
map <C-j> <Plug>(edgemotion-j)
map <C-k> <Plug>(edgemotion-k)

" vim-markdown-composer. {{{2
if executable('cargo')
  " au MyAutoCmd FileType markdown packadd vim-markdown-composer
endif

" vim-reading-vimrc. {{{2
au MyAutoCmd CmdUndefined ReadingVimrc* packadd vim-reading-vimrc
vmap <Leader><CR> <Plug>(reading_vimrc-update_clipboard)

" gruvbox. {{{2
let g:gruvbox_contrast_dark = "hard"

" Define user commands for updating/cleaning the plugins. {{{1
" Each of them loads minpac, reloads .vimrc to register the
" information of plugins, then performs the task.
com! PackClean     packadd minpac | source $MYVIMRC | call minpac#clean()
com! PackUpdate    packadd minpac | source $MYVIMRC | call minpac#clean() | call minpac#update()
com! PackListStart packadd minpac | source $MYVIMRC | Capture echo minpac#getpackages("", "start")
com! PackListOpt   packadd minpac | source $MYVIMRC | Capture echo minpac#getpackages("", "opt")
com! PackNameStart packadd minpac | source $MYVIMRC | Capture echo minpac#getpackages("", "start", "", 1)
com! PackNameOpt   packadd minpac | source $MYVIMRC | Capture echo minpac#getpackages("", "opt", "", 1)

