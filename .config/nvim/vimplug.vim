" =============================================================================
" File        : vimplug.vim
" Author      : yukimemi
" Last Change : 2020/02/09 18:24:18.
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

" Helper function.
function! Cond(cond, ...)
  let opts = get(a:000, 0, {})
  return a:cond ? opts : { 'on': [], 'for': [] }
endfunction

" Plugin list. {{{2
call plug#begin(s:plug_dir)

" ==================== Visual ==================== {{{3
Plug 'joshdick/onedark.vim'
Plug 'aereal/vim-colors-japanesque'
Plug 'altercation/vim-colors-solarized'
Plug 'lifepillar/vim-solarized8'
Plug 'cocopon/iceberg.vim'
Plug 'endel/vim-github-colorscheme'
Plug 'itchyny/lightline.vim'
Plug 'itchyny/vim-cursorword'
Plug 'itchyny/vim-highlighturl'
Plug 'itchyny/vim-parenmatch'
Plug 'vim-scripts/matchit.zip'
" Plug 'vimtaku/hl_matchit.vim'
Plug 'taku-o/vim-zoom', Cond(has('gui'))
Plug 'Yggdroot/indentLine'
Plug 'kmtoki/lightline-colorscheme-simplicity'
" Plug 'osyo-manga/vim-precious'

" ==================== Completion ================ {{{3
Plug 'Shougo/deoplete.nvim', Cond(has('nvim'), { 'do': 'UpdateRemotePlugins' })
Plug 'Shougo/neocomplete.vim', Cond(!has('nvim'))
Plug 'Shougo/neosnippet-snippets'
Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/context_filetype.vim'
Plug 'zchee/deoplete-go', Cond(has('nvim'), { 'for': 'go', 'do': 'make' })
Plug 'sebastianmarkow/deoplete-rust', { 'for': 'rust' }
Plug 'carlitux/deoplete-ternjs', Cond(has('nvim'), { 'for': ['javascript', 'typescript'], 'do': 'npm install -g tern' })
" Plug 'maralla/completor.vim'
" Plug 'roxma/nvim-completion-manager', Cond(has('nvim'))
" Plug 'roxma/vim-hug-neovim-rpc', Cond(!has('nvim'))
" Plug 'roxma/nvim-cm-racer', Cond(has('nvim'), { 'for': 'rust' })
" Plug 'autozimu/LanguageClient-neovim', { 'do': ':UpdateRemotePlugins' }


" ==================== Utility =================== {{{3
Plug 'airblade/vim-rooter'
Plug 'thinca/vim-submode'
Plug 't9md/vim-choosewin'
Plug 'Konfekt/FastFold'
Plug 'Shougo/vimproc.vim', Cond(!has('kaoriya'), { 'do': function('MakeVimproc') })
Plug 'glidenote/memolist.vim', { 'on': ['MemoList', 'MemoNew'] }
Plug 'mattn/sonictemplate-vim', { 'on': 'Templete' }
Plug 'basyura/TweetVim', {'on': ['TweetVimHomeTimeline', 'TweetVimUserStream', 'TweetVimSay'] }
Plug 'basyura/twibill.vim', {'on': [] }
Plug 'mattn/webapi-vim', {'on': [] }
Plug 'tyru/open-browser.vim', {'on': [] }
Plug 'vim-scripts/autodate.vim'
Plug 'tpope/vim-repeat'
Plug 'tyru/capture.vim', { 'on': 'Capture' }
Plug 'taku-o/vim-ro-when-swapfound'
Plug 'scrooloose/nerdtree', { 'on': ['NERDTreeToggle', 'NERDTree'] }
Plug 'kassio/neoterm', Cond(has('nvim'), { 'on': ['T', 'Tnew'] })
Plug 'thinca/vim-qfreplace', { 'on': 'Qfreplace' }
Plug 'kannokanno/previm', { 'on': 'PrevimOpen', 'for': 'markdown' }
Plug 'simnalamburt/vim-mundo'


" ==================== Linter/Formatter ========== {{{3
Plug 'w0rp/ale'
Plug 'sbdchd/neoformat'
Plug 'junegunn/vim-easy-align', { 'on': '<Plug>(EasyAlign)' }
Plug 'lambdalisue/vim-findent', { 'on': 'Findent' }


" ==================== Search ==================== {{{3
Plug 'haya14busa/vim-asterisk', { 'on': ['<Plug>(asterisk-*)', '<Plug>(asterisk-g*)', '<Plug>(asterisk-#)', '<Plug>(asterisk-g#)', '<Plug>(asterisk-z*)', '<Plug>(asterisk-gz*)', '<Plug>(asterisk-z#)', '<Plug>(asterisk-gz#)'] }
Plug 'osyo-manga/vim-anzu', { 'on': ['<Plug>(anzu-n)', '<Plug>(anzu-N)'] }
Plug 'haya14busa/incsearch.vim'
Plug 't9md/vim-quickhl'


" ==================== Operators ================= {{{3
Plug 'kana/vim-operator-user'
Plug 'haya14busa/vim-operator-flashy', { 'on': '<Plug>(operator-flashy)' }
Plug 'kana/vim-operator-replace', { 'on': '<Plug>(operator-replace)' }
Plug 'rhysd/vim-operator-surround', { 'on': ['<Plug>(operator-surround-append)', '<Plug>(operator-surround-delete)',  '<Plug>(operator-surround-replace)'] }


" ==================== Textobjs ================== {{{3
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-entire', { 'on': ['<Plug>(textobj-entire-a)', '<Plug>(textobj-entire-i)'] }
Plug 'kana/vim-textobj-fold', { 'on': ['<Plug>(textobj-fold-a)', '<Plug>(textobj-fold-i)'] }
Plug 'kana/vim-textobj-indent', { 'on': ['<Plug>(textobj-indent-a)', '<Plug>(textobj-indent-i)', '<Plug>(textobj-indent-same-a)', '<Plug>(textobj-indent-same-i)'] }
Plug 'gilligan/textobj-lastpaste', { 'on': '<Plug>(textobj-lastpaste-i)' }


" ==================== Comment =================== {{{3
Plug 'tyru/caw.vim'


" ==================== Yank/Paste ================ {{{3
Plug 'LeafCage/yankround.vim'


" ==================== Git ======================= {{{3
Plug 'lambdalisue/gina.vim', { 'on': 'Gina' }
Plug 'cohama/agit.vim', { 'on': 'Agit' }
Plug 'rhysd/committia.vim'


" ==================== Denite ==================== {{{3
Plug 'Shougo/denite.nvim', { 'on': 'Denite' }
Plug 'Shougo/neomru.vim', { 'on': [] }


" ==================== Filetype (go) ============= {{{3
Plug 'fatih/vim-go', { 'for': 'go' }


" ==================== Filetype (ps1) ============ {{{3
Plug 'PProvost/vim-ps1', { 'for': 'ps1' }


" ==================== Filetype (toml) =========== {{{3
Plug 'cespare/vim-toml', { 'for': 'toml' }


" ==================== Filetype (yaml) =========== {{{3
Plug 'stephpy/vim-yaml', { 'for': 'yaml' }


" ==================== Filetype (plantuml) ======= {{{3
Plug 'aklt/plantuml-syntax', { 'for': 'uml' }


" ==================== Filetype (log) ============ {{{3
Plug 'dzeban/vim-log-syntax', { 'for': 'log' }


" ==================== Filetype (Vue) ============ {{{3
Plug 'posva/vim-vue', { 'for': 'vue' }


" ==================== Filetype (javascript) ===== {{{3
Plug 'pangloss/vim-javascript', { 'for': ['javascript', 'javascript.jsx'] }
Plug 'maxmellon/vim-jsx-pretty', { 'for': ['javascript', 'javascript.jsx', 'typescript'] }
Plug 'othree/javascript-libraries-syntax.vim', { 'for': ['javascript', 'javascript.jsx', 'typescript'] }
Plug 'othree/es.next.syntax.vim', { 'for': ['javascript', 'javascript.jsx', 'typescript'] }
Plug 'flowtype/vim-flow', { 'for': ['javascript', 'javascript.jsx'], 'do': 'npm install -g flow-bin' }
Plug 'leafgarland/typescript-vim', { 'for': 'typescript' }
Plug 'Quramy/tsuquyomi', { 'for': 'typescript' }
Plug 'kchmck/vim-coffee-script', { 'for': 'coffee' }


" ==================== Filetype (fish-shell) ===== {{{3
Plug 'dag/vim-fish', { 'for': 'fish' }


" ==================== Filetype (markdown) ======= {{{3
Plug 'rhysd/vim-gfm-syntax', { 'for': 'markdown' }


" ==================== Filetype (Dockerfile) ===== {{{3
Plug 'ekalinin/Dockerfile.vim', { 'for': 'Dockerfile' }


" ==================== Filetype (Rust) =========== {{{3
Plug 'rhysd/rust-doc.vim', { 'for': 'rust' }
Plug 'rust-lang/rust.vim', Cond(executable('cargo'), { 'for': 'rust' })
" Plug 'racer-rust/vim-racer', Cond(executable('racer'), { 'for': 'rust' })

" ==================== Filetype (Haskell) ======== {{{3
Plug 'eagletmt/ghcmod-vim', Cond(executable('stack'), { 'for': 'haskell', 'do': 'stack install ghc-mod' })
Plug 'eagletmt/neco-ghc', Cond(executable('stack'), { 'for': 'haskell' })
Plug 'itchyny/vim-haskell-indent', { 'for': 'haskell' }
Plug 'itchyny/vim-haskell-sort-import', { 'for': 'haskell' }


" ==================== Filetype (SQL) ============ {{{3
Plug 'b4b4r07/vim-sqlfmt', { 'for': 'sql', 'do': 'go get github.com/jackc/sqlfmt' }


" ==================== Filetype (Tmux) =========== {{{3
Plug 'tmux-plugins/vim-tmux'


call plug#end()


" Plugin settings: {{{1
let s:p = { 'plugs': get(g:, 'plugs', {}) }
function! s:p.is_installed(name) abort
  return has_key(self.plugs, a:name) ? isdirectory(self.plugs[a:name].dir) : 0
endfunction

" ==================== Visual ==================== {{{2
" lightline.vim {{{3
if s:p.is_installed('lightline.vim')
  let g:lightline = {
        \ 'colorscheme': 'onedark',
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
        \   'left': [ [ 'mode', 'paste' ], [ 'filename', 'anzu' ] ],
        \   'right': [ [ 'lineinfo' ], [ 'percent' ], [ 'fileformat', 'fileencoding', 'bomb', 'filetype' ],
        \              [ 'absolutepath', 'charcode' ] ]
        \ },
        \ 'component': {
        \   'charcode': '[%03.3b, 0x%02.2B]'
        \ },
        \ 'component_function': {
        \   'modified': 'MyModified',
        \   'readonly': 'MyReadonly',
        \   'fugitive': 'MyFugitive',
        \   'git_branch': 'MyGitBranch',
        \   'git_traffic': 'MyGitTraffic',
        \   'git_status': 'MyGitStatus',
        \   'filename': 'MyFilename',
        \   'fileformat': 'MyFileformat',
        \   'filetype': 'MyFiletype',
        \   'fileencoding': 'MyFileencoding',
        \   'bomb': 'MyBomb',
        \   'absolutepath': 'MyAbsolutePath',
        \   'mode': 'MyMode',
        \   'anzu': 'anzu#search_status',
        \ }
        \ }

  function! MyModified()
    return &ft =~ 'help\|vimfiler\|gundo' ? '' : &modified ? '+' : &modifiable ? '' : '-'
  endfunction

  function! MyReadonly()
    if g:is_windows
      return &ft !~? 'help\|vimfiler\|gundo' && &readonly ? 'R' : ''
    else
      return &ft !~? 'help\|vimfiler\|gundo' && &readonly ? '⭤' : ''
    endif
  endfunction

  function! MyFilename()
    return ('' != MyReadonly() ? MyReadonly() . ' ' : '') .
          \ ('' != expand('%:t') ? expand('%:t') : '[No Name]') .
          \ ('' != MyModified() ? ' ' . MyModified() : '')
  endfunction

  function! MyGitBranch()
    return winwidth(0) > 70 ? gita#statusline#preset('branch_fancy') : ''
  endfunction
  function! MyGitTraffic()
    return winwidth(0) > 70 ? gita#statusline#preset('traffic_fancy') : ''
  endfunction
  function! MyGitStatus()
    return winwidth(0) > 70 ? gita#statusline#preset('status') : ''
  endfunction

  function! MyFugitive()
    if &ft !~? 'vimfiler\|gundo' && exists("*fugitive#head")
      let _ = fugitive#head()
      if g:is_windows
        return strlen(_) ? '| '._ : ''
      else
        return strlen(_) ? '⭠ '._ : ''
      endif
    endif
    return ''
  endfunction

  function! MyFileformat()
    return winwidth('.') > 70 ? &fileformat : ''
  endfunction

  function! MyFiletype()
    return winwidth('.') > 70 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
  endfunction

  function! MyFileencoding()
    return winwidth('.') > 70 ? (strlen(&fenc) ? &fenc : &enc) : ''
  endfunction

  function! MyBomb()
    return &bomb ? 'b' : 'nb'
  endfunction

  function! MyMode()
    return winwidth('.') > 60 ? lightline#mode() : ''
  endfunction

  function! MyAbsolutePath()
    return (winwidth('.') - strlen(expand('%:p')) > 90) ? expand('%:p') : ((winwidth('.') - strlen(expand('%')) > 70) ? expand('%') : '')
  endfunction

  if g:is_windows && !has('gui')
    let g:lightline.colorscheme = 'simplicity'
  endif
endif


" vim-cursorword {{{3
if s:p.is_installed('vim-cursorword')
  function! s:ToggleCursorWord() abort
    let b:cursorword = !get(b:, 'cursorword', 1)
  endfunction

  com! ToggleCursorWord call s:ToggleCursorWord()
endif


" vim-parenmatch {{{3
if s:p.is_installed('vim-parenmatch')
  let g:loaded_matchparen = 1
endif


" hl_matchit.vim {{{3
if s:p.is_installed('hl_matchit.vim')
  let g:hl_matchit_enable_on_vim_startup = 1
  " let g:hl_matchit_hl_groupname = 'Search'

  " If 1 is set, sometimes do not highlight.
  " let g:hl_matchit_speed_level = 1
endif


" indentLine {{{3
if s:p.is_installed('indentLine')
  let g:indentLine_faster = 1
  nnoremap <silent><Leader>i :<C-u>IndentLinesToggle<CR>
  let g:indentLine_fileTypeExclude = ['help', 'nerdtree', 'calendar', 'thumbnail', 'denite', 'tweetvim']
endif


" ==================== Completion ================ {{{2
" deoplete.nvim {{{3
if s:p.is_installed('deoplete.nvim')
  let g:deoplete#enable_at_startup = 1
endif


" neocomplete.vim {{{3
if s:p.is_installed('neocomplete.vim')
  let g:neocomplete#enable_at_startup = 1
endif


" neosnippet.vim {{{3
if s:p.is_installed('neosnippet.vim')
  imap <C-k> <Plug>(neosnippet_expand_or_jump)
  smap <C-k> <Plug>(neosnippet_expand_or_jump)
  xmap <C-k> <Plug>(neosnippet_expand_target)
  " Tell Neosnippet about the other snippets
  let g:neosnippet#snippets_directory = $VIM_PATH . '/snippets'

  " For snippet_complete marker.
  set conceallevel=2 concealcursor=i
endif


" deoplete-go {{{3
if s:p.is_installed('deoplete-go')
  let g:deoplete#sources#go#use_cache = 1
  let g:deoplete#sources#go#json_directory = '~/.cache/deoplete/go/$GOOS_$GOARCH'
  let g:deoplete#sources#go#gocode_binary = $GOPATH.'/bin/gocode'
  let g:deoplete#sources#go#sort_class = ['package', 'func', 'type', 'var', 'const']
endif


" completor.vim {{{3
if s:p.is_installed('completor.vim')
  let g:completor_racer_binary = '~/.cargo/bin/racer.exe'
endif


" deoplete-rust {{{3
if s:p.is_installed('deoplete-rust')
  let g:deoplete#sources#rust#racer_binary = expand('~/.cargo/bin/racer')
  let g:deoplete#sources#rust#rust_source_path = expand('$RUST_SRC_PATH')
endif


" LanguageClient-neovim {{{3
if s:p.is_installed('LanguageClient-neoivm')
  let g:LanguageClient_serverCommands = {
        \ 'rust': ['rustup', 'run', 'nightly', 'rls'],
        \ }

  " Automatically start language servers.
  let g:LanguageClient_autoStart = 1

  nnoremap <silent> K :call LanguageClient_textDocument_hover()<CR>
  nnoremap <silent> gd :call LanguageClient_textDocument_definition()<CR>
  nnoremap <silent> <F2> :call LanguageClient_textDocument_rename()<CR>
endif


" ==================== Utility =================== {{{2
" vim-rooter {{{3
if s:p.is_installed('vim-rooter')
  let g:rooter_use_lcd = 1
endif


" vim-submode {{{3
if s:p.is_installed('vim-submode')
  let g:submode_leave_with_key = 1
  call submode#enter_with('bufmove', 'n', '', 's>', '<C-w>>')
  call submode#enter_with('bufmove', 'n', '', 's<', '<C-w><')
  call submode#enter_with('bufmove', 'n', '', 's+', '<C-w>+')
  call submode#enter_with('bufmove', 'n', '', 's-', '<C-w>-')
  call submode#map('bufmove', 'n', '', '>', '<C-w>>')
  call submode#map('bufmove', 'n', '', '<', '<C-w><')
  call submode#map('bufmove', 'n', '', '+', '<C-w>+')
  call submode#map('bufmove', 'n', '', '-', '<C-w>-')
endif


" vim-choosewin {{{3
if s:p.is_installed('vim-choosewin')
  " nmap - <Plug>(choosewin)

  let g:choosewin_overlay_enable = 1
  let g:choosewin_overlay_clear_multibyte = 1

  " color like tmux
  let g:choosewin_color_overlay = {
        \ 'gui': ['DodgerBlue3', 'DodgerBlue3' ],
        \ 'cterm': [ 25, 25 ]
        \ }
  let g:choosewin_color_overlay_current = {
        \ 'gui': ['firebrick1', 'firebrick1' ],
        \ 'cterm': [ 124, 124 ]
        \ }

  let g:choosewin_blink_on_land = 0
  let g:choosewin_statusline_replace = 0
  let g:choosewin_tabline_replace = 0
endif


" FastFold {{{3
if s:p.is_installed('FastFold')
  let g:fastfold_savehook = 0
endif


" memolist.vim {{{3
if s:p.is_installed('memolist.vim')
  if isdirectory($HOME . '/Dropbox')
    let g:memolist_path = $HOME . '/Dropbox/memolist'
  else
    let g:memolist_path = $HOME . '/.memolist'
  endif

  call Mkdir(g:memolist_path)

  let g:memolist_memo_suffix = "md"

  " mappings
  nnoremap <Leader>mn :<C-u>MemoNew<CR>
  nnoremap <Leader>ml :<C-u>MemoList<CR>
  nnoremap <Leader>mg :<C-u>MemoGrep<CR>
endif


" sonictemplate_vim {{{3
if s:p.is_installed('sonictemplate_vim')
  let g:sonictemplate_vim_template_dir = '$HOME/.vim/template'
  let g:sonictemplate_vim_vars = {
        \ '_': {
        \   'author': 'yukimemi',
        \   'mail': 'yukimemi@gmail.com',
        \ }
        \ }
endif


" TweetVim {{{3
if s:p.is_installed('TweetVim')
  nnoremap <space>tu :<C-u>TweetVimUserStream<CR>

  let g:tweetvim_default_account = "yukimemi"
  let g:tweetvim_tweet_per_page = 100
  let g:tweetvim_cache_size = 50
  "let g:tweetvim_display_username = 1
  let g:tweetvim_display_source = 1
  let g:tweetvim_display_time = 1
  "let g:tweetvim_display_icon = 1
  let g:tweetvim_async_post = 1

  au MyAutoCmd FileType tweetvim call s:tweetvim_cfg()
  function! s:tweetvim_cfg()
    setl nowrap
    nnoremap <buffer> <space>s :<C-u>TweetVimSay<CR>
  endfunction

  au! User TweetVim call plug#load('twibill.vim', 'webapi-vim', 'open-browser.vim')
endif


" autodate.vim {{{3
if s:p.is_installed('autodate.vim')
  let g:autodate_format = "%Y/%m/%d %H:%M:%S"
  let g:autodate_keyword_pre  = "Last Change *:"
  let g:autodate_keyword_post = "."
endif


" vim-ro-when-swapfound {{{3
if s:p.is_installed('vim-ro-when-swapfound')
  function! s:swapChoice() abort
    ToggleSwapCheck
    :e
  endfunction
  com! SwapChoice call s:swapChoice()
endif


" nerdtree {{{3
if s:p.is_installed('nerdtree')
  nnoremap <space>v :NERDTreeToggle<CR>
  au MyAutoCmd StdinReadPre * let s:std_in=1
  au MyAutoCmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif
endif


" neoterm {{{3
if s:p.is_installed('neoterm')
  if has('nvim')
    let g:neoterm_autoinsert = 1
    nnoremap <space>s :<C-u>terminal<CR>
    tnoremap sj <C-\><C-n><C-w>j
    tnoremap sk <C-\><C-n><C-w>k
    tnoremap sl <C-\><C-n><C-w>l
    tnoremap sh <C-\><C-n><C-w>h
  endif
endif


" previm {{{3
if s:p.is_installed('previm')
  au! User previm call plug#load('open-browser.vim')
endif


" ==================== Linter/Formatter ========== {{{2
" ale {{{3
if s:p.is_installed('ale')
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

  " Rust.
  let g:ale_rust_ignore_error_codes = ['E0432', 'E0433']
endif


" neoformat {{{3
if s:p.is_installed('neoformat')
  au MyAutoCmd BufWritePre * Neoformat
endif


" vim-easy-align {{{3
if s:p.is_installed('vim-easy-align')
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
        \   }
        \ }
endif


" ==================== Search ==================== {{{2
" incsearch.vim {{{3
if s:p.is_installed('incsearch.vim')
  map /  <Plug>(incsearch-forward)
  map ?  <Plug>(incsearch-backward)
  map g/ <Plug>(incsearch-stay)

  let g:incsearch#auto_nohlsearch = 1
  map n <Plug>(incsearch-nohl)<Plug>(anzu-n)zv
  map N <Plug>(incsearch-nohl)<Plug>(anzu-N)zv
  map *   <Plug>(incsearch-nohl)<Plug>(asterisk-*)zv
  map g*  <Plug>(incsearch-nohl)<Plug>(asterisk-g*)zv
  map #   <Plug>(incsearch-nohl)<Plug>(asterisk-#)zv
  map g#  <Plug>(incsearch-nohl)<Plug>(asterisk-g#)zv

  map z*  <Plug>(incsearch-nohl0)<Plug>(asterisk-z*)
  map gz* <Plug>(incsearch-nohl0)<Plug>(asterisk-gz*)
  map z#  <Plug>(incsearch-nohl0)<Plug>(asterisk-z#)
  map gz# <Plug>(incsearch-nohl0)<Plug>(asterisk-gz#)
endif

" vim-quickhl {{{3
if s:p.is_installed('vim-quickhl')
  let g:quickhl_manual_enable_at_startup = 1

  nmap <space>m <Plug>(quickhl-manual-this)
  xmap <space>m <Plug>(quickhl-manual-this)
  nmap <space>M <Plug>(quickhl-manual-reset)
  xmap <space>M <Plug>(quickhl-manual-reset)

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
endif


" ==================== Operators ================= {{{2
" vim-operator-flashy {{{3
if s:p.is_installed('vim-operator-flashy')
  map y <Plug>(operator-flashy)
  nmap Y <Plug>(operator-flashy)$
endif


" vim-operator-replace {{{3
if s:p.is_installed('vim-operator-replace')
  map _ <Plug>(operator-replace)
endif


" vim-operator-surround {{{3
if s:p.is_installed('vim-operator-surround')
  map sA <Plug>(operator-surround-append)
  map sD <Plug>(operator-surround-delete)
  map sR <Plug>(operator-surround-replace)
endif


" ==================== Textobjs ================== {{{2
" vim-textobj-entire {{{3
if s:p.is_installed('vim-textobj-entire')
  omap ae <Plug>(textobj-entire-a)
  xmap ae <Plug>(textobj-entire-a)
  omap ie <Plug>(textobj-entire-i)
  xmap ie <Plug>(textobj-entire-i)
endif


" vim-textobj-fold {{{3
if s:p.is_installed('vim-textobj-fold')
  omap az <Plug>(textobj-fold-a)
  xmap az <Plug>(textobj-fold-a)
  omap iz <Plug>(textobj-fold-i)
  xmap iz <Plug>(textobj-fold-i)
endif


" vim-textobj-indent {{{3
if s:p.is_installed('vim-textobj-indent')
  omap ai <Plug>(textobj-indent-a)
  xmap ai <Plug>(textobj-indent-a)
  omap ii <Plug>(textobj-indent-i)
  xmap ii <Plug>(textobj-indent-i)
  omap aI <Plug>(textobj-indent-same-a)
  xmap aI <Plug>(textobj-indent-same-a)
  omap iI <Plug>(textobj-indent-same-i)
  xmap iI <Plug>(textobj-indent-same-i)
endif


" textobj-lastpaste {{{3
if s:p.is_installed('textobj-lastpaste')
  omap iP <Plug>(textobj-lastpaste-i)
  xmap iP <Plug>(textobj-lastpaste-i)
endif


" ==================== Comment =================== {{{2
" caw.vim {{{3
if s:p.is_installed('caw.vim')
  nmap gc <Plug>(caw:prefix)
  xmap gc <Plug>(caw:prefix)
  nmap gcc <Plug>(caw:hatpos:toggle)
  xmap gcc <Plug>(caw:hatpos:toggle)
endif


" ==================== Yank/Paste ================ {{{2
" yankround.vim {{[3
if s:p.is_installed('yankround.vim')
  nmap p <Plug>(yankround-p)
  nmap P <Plug>(yankround-P)
  nmap <C-p> <Plug>(yankround-prev)
  nmap <C-n> <Plug>(yankround-next)
  let g:yankround_max_history = 100
endif


" ==================== Git ======================= {{{2
" gina.vim {{{3
if s:p.is_installed('gina.vim')
  nnoremap <space>gs :<C-u>Gina status<CR>
  nnoremap <space>gb :<C-u>Gina branch<CR>
  nnoremap <space>gg :<C-u>Gina grep<CR>
  nnoremap <space>gd :<C-u>Gina diff<CR>
  nnoremap <space>gl :<C-u>Gina ls-files<CR>
  nnoremap <space>gp :<C-u>Gina push<CR>
endif



" ==================== Denite ==================== {{{2
" denite.nvim {{{3
if s:p.is_installed('denite.nvim')
  " Use plefix s
  nnoremap suc :<C-u>Denite colorscheme -auto-preview<CR>
  nnoremap sub :<C-u>Denite buffer<CR>
  nnoremap suf :<C-u>Denite file<CR>
  nnoremap suF :<C-u>Denite file_rec<CR>
  " nnoremap suu :<C-u>Denite buffer file_old<CR>
  nnoremap suu :<C-u>Denite buffer file_mru<CR>
  nnoremap suo :<C-u>Denite outline -no-quit -mode=normal<CR>
  nnoremap suh :<C-u>Denite help<CR>
  nnoremap sur :<C-u>Denite register<CR>
  nnoremap sug :<C-u>Denite grep -no-empty -no-quit<CR>
  nnoremap su/ :<C-u>Denite line -no-quit<CR>
  nnoremap suR :<C-u>Denite -resume<CR>

  noremap sul :<C-u>Denite command_history<CR>

  " Incremental search in cmdline history.
  inoremap <C-l> <ESC>:<C-u>Denite command<CR>

  au! User denite.nvim call s:denite_cfg()

  function! s:denite_cfg() abort
    " Load dependent plugins.
    call plug#load('neomru.vim')
    " Default options.
    call denite#custom#option('default', {
          \ 'prompt': '»',
          \ 'cursor_wrap': v:true,
          \ 'auto_resize': v:true,
          \ 'highlight_mode_insert': 'WildMenu'
          \ })

    if executable('jvgrep')
      " jvgrep command on grep source
      call denite#custom#var('grep', 'command', ['jvgrep'])
      call denite#custom#var('grep', 'default_opts', [])
      call denite#custom#var('grep', 'recursive_opts', ['-R'])
      call denite#custom#var('grep', 'pattern_opt', [])
      call denite#custom#var('grep', 'separator', [])
      call denite#custom#var('grep', 'final_opts', [])

    elseif executable('rg')
      " Ripgrep command on grep source
      call denite#custom#var('grep', 'command', ['rg'])
      call denite#custom#var('grep', 'default_opts',
          \ ['--vimgrep', '--no-heading'])
      call denite#custom#var('grep', 'recursive_opts', [])
      call denite#custom#var('grep', 'pattern_opt', ['--regexp'])
      call denite#custom#var('grep', 'separator', ['--'])
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
endif


" ==================== Filetype (go) ============= {{{2
" vim-go {{{3
if s:p.is_installed('vim-go')
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
  " let g:gofmt_command = "goimports"
  " au MyAutoCmd BufWritePre *.go silent Fmt

  au MyAutoCmd BufNew,BufRead *.go call s:vim_go_cfg()

  function! s:vim_go_cfg() abort
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
endif


" ==================== Filetype (ps1) ============ {{{2
" vim-ps1 {{{3
if s:p.is_installed('vim-ps1')
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
endif



" ==================== Filetype (javascript) ===== {{{2
" vim-flow {{{3
if s:p.is_installed('vim-flow')
  let g:flow#autoclose = 1
endif


" tsuquyomi {{{3
if s:p.is_installed('tsuquyomi')
  au MyAutoCmd FileType typescript nnoremap <buffer> <Leader>t :<C-u>echo tsuquyomi#hint()<CR>
endif


" ==================== Filetype (fish-shell) ===== {{{2
" vim-fish {{{3
if s:p.is_installed('vim-fish')
  au MyAutoCmd BufNew,BufRead *.fish call s:vim_fish_cfg()

  function! s:vim_fish_cfg() abort
    setl tabstop=4
    setl shiftwidth=4
    setl softtabstop=0
  endfunction
endif


" ==================== Filetype (Rust) =========== {{{2
" rust.vim {{{3
if s:p.is_installed('rust.vim')
  let g:rustfmt_autosave = 1
endif


" vim-racer {{{3
if s:p.is_installed('vim-racer')
  let g:racer_experimental_completer = 1
  setl completeopt=menu,preview
  au MyAutoCmd FileType rust nmap <buffer> gd <Plug>(rust-def)
  au MyAutoCmd FileType rust nmap <buffer> gs <Plug>(rust-def-split)
  au MyAutoCmd FileType rust nmap <buffer> gx <Plug>(rust-def-vertical)
  au MyAutoCmd FileType rust nmap <buffer> <leader>gd <Plug>(rust-doc)
endif



" ==================== Filetype (Haskell) ======== {{{2
" ghcmod-vim {{{3
if s:p.is_installed('ghcmod-vim')
  au MyAutoCmd BufNew,BufRead *.hs call s:ghcmod_vim_cfg()

  function! s:ghcmod_vim_cfg() abort
    setl completeopt=menu,preview
    nnoremap <buffer> K :<C-u>GhcModInfoPreview<CR>
  endfunction
endif


" neco-ghc {{{3
if s:p.is_installed('neco-ghc')
  au MyAutoCmd FileType haskell setl omnifunc=necoghc#omnifunc
endif


" vim-haskell-sort-indent {{{3
if s:p.is_installed('vim-haskell-sort-indent')
  au MyAutoCmd BufWritePre *.hs HaskellSortImport
endif



" ==================== Filetype (SQL) ============ {{{2
" vim-sqlfmt {{{3
if s:p.is_installed('vim-sqlfmt')
  let g:sqlfmt_command = "sqlformat"
  let g:sqlfmt_options = "-r -k upper"
endif

