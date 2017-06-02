" =============================================================================
" File        : init.vim / .vimrc
" Author      : yukimemi
" Last Change : 2017/06/02 13:27:51.
" =============================================================================

" Init: {{{1
set encoding=utf-8
scriptencoding utf-8

" Release autogroup in MyAutoCmd.
augroup MyAutoCmd
  autocmd!
augroup END

" Echo startup time on start.
if has('vim_starting') && has('reltime')
  let s:startuptime = reltime()
  au MyAutoCmd VimEnter * let s:startuptime = reltime(s:startuptime) | redraw
        \ | echomsg 'startuptime: ' . reltimestr(s:startuptime)
endif

" True color.
if has('nvim')
  set termguicolors
endif

" Set mapleader.
let g:mapleader = ','
let g:maplocalleader = ','

" Utility: {{{1
" Judge os type. {{{2
let g:is_windows = has('win16') || has('win32') || has('win64')
let g:is_cygwin = has('win32unix')
let g:is_darwin = has('mac') || has('macunix') || has('gui_macvim')
let g:is_linux = !g:is_windows && !g:is_cygwin && !g:is_darwin

" Set path. {{{2
set shellslash
if has('nvim')
  let $VIM_PATH = expand('~/.config/nvim')
  let $MYVIMRC = expand('~/.config/nvim/init.vim')
else
  let $VIM_PATH = expand('~/.vim')
  let $MYVIMRC = expand('~/.vimrc')
  let $MYGVIMRC = expand('~/.gvimrc')
endif
let $CACHE = expand('~/.cache')
let $BACKUP_PATH = expand('$CACHE/vim/back')

" Add runtimepath for windows.
if g:is_windows
  execute 'set runtimepath+=' . $VIM_PATH
  execute 'set runtimepath+=' . $VIM_PATH . '/after'
endif

" Functions: {{{1
function! Mkdir(dir) "{{{2
  if !isdirectory(a:dir)
    call mkdir(a:dir, "p")
  endif
endfunction

function! s:str2byte(str) "{{{2
  return map(range(len(a:str)), 'char2nr(a:str[v:val])')
endfunction

function! s:byte2hex(bytes) "{{{2
  return join(map(copy(a:bytes), 'printf("%02X", v:val)'), '')
endfunction

function! s:auto_mkdir(dir, force) "{{{2
  " Hack #202: http://vim-users.jp/2011/02/hack202/
  if !isdirectory(a:dir) && (a:force ||
        \ input(printf('"%s" does not exist. Create? [y/N]', a:dir)) =~? '^y\%[es]$')
    call mkdir(iconv(a:dir, &encoding, &termencoding), 'p')
  endif
endfunction

function! s:format() "{{{2
  " auto indent format
  let save_view = winsaveview()
  normal gg=G
  call winrestview(save_view)
endfunction

function! s:addQuote() "{{{2
  normal gg2dd
  9,$s/^/> /
  normal gg
endfunction

function! s:cd_buffer_dir() "{{{2
  let filetype = getbufvar(bufnr('%'), '&filetype')
  if filetype ==# 'vimfiler'
    let dir = getbufvar(bufnr('%'), 'vimfiler').current_dir
  elseif filetype ==# 'vimshell'
    let dir = getbufvar(bufnr('%'), 'vimshell').save_dir
  else
    let dir = isdirectory(bufname('%')) ? bufname('%') : fnamemodify(bufname('%'), ':p:h')
  endif

  cd `=dir`
endfunction

function! s:removeFileIf0Byte() "{{{2
  " Remove file if 0 byte.
  " http://qiita.com/hykw/items/6dbb43bdcd8874a0daf7
  let filename = expand('%:p')
  if getfsize(filename) > 0
    " do nothing
    return
  endif

  let msg = printf("\n%s is empty, remove?(y/N)", filename)
  if input(msg) == 'y'
    call delete(filename)
    bdelete
  endif
endfunction

function! s:deleteOtherLine() "{{{2
" Delete other line
  %g!//d
endfunction

function s:updateColorScheme() "{{{2
  if &readonly && &buftype ==# ""
    colorscheme github
  endif
endfunction

" Plugin: {{{1
" Use vim-plug.
if has('nvim')
  let s:cache_home = expand('~/.cache/nvim')
else
  let s:cache_home = expand('~/.cache/vim')
endif


let s:plug_dir = s:cache_home . '/vim-plug'
let s:vim_plug_dir = s:plug_dir . '/vim-plug'
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
  return a:cond ? opts : extend(opts, { 'on': [], 'for': [], 'do': '' })
endfunction

call plug#begin(s:plug_dir)

let b:vim_plug_dir = s:vim_plug_dir . '/autoload'
Plug 'junegunn/vim-plug', { 'dir': b:vim_plug_dir }
Plug 'joshdick/onedark.vim'
Plug 'itchyny/lightline.vim'
Plug 'itchyny/vim-highlighturl'
Plug 'itchyny/vim-parenmatch'
Plug 'itchyny/vim-cursorword'
" Plug 'osyo-manga/vim-precious'
Plug 'osyo-manga/vim-anzu'
Plug 'Shougo/context_filetype.vim'
Plug 'Shougo/deoplete.nvim', Cond(has('nvim'))
Plug 'Shougo/neocomplete.vim', Cond(!has('nvim'))
Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neosnippet-snippets'
Plug 'Shougo/vimproc.vim', Cond(!has('kaoriya'), { 'do': 'make' })
Plug 'Shougo/denite.nvim', { 'on': 'Denite' }
Plug 'Shougo/neomru.vim'
Plug 'airblade/vim-rooter'
Plug 'junegunn/vim-easy-align', { 'on': '<Plug>(EasyAlign)' }
Plug 'Yggdroot/indentLine'
Plug 'glidenote/memolist.vim', { 'on': ['Memolist', 'MemoNew'] }
Plug 'thinca/vim-submode'
Plug 'vim-scripts/autodate.vim'
Plug 'tpope/vim-repeat'
Plug 'Chiel92/vim-autoformat'
Plug 'w0rp/ale'
Plug 'haya14busa/vim-asterisk'
Plug 'haya14busa/incsearch.vim'
Plug 't9md/vim-quickhl'
Plug 'taku-o/vim-ro-when-swapfound'
Plug 'tyru/capture.vim', { 'on': 'Capture' }
Plug 'scrooloose/nerdtree', { 'on': ['NERDTreeToggle', 'NERDTree'] }
Plug 'Konfekt/FastFold'
Plug 'scrooloose/nerdtree', { 'on':  ['NERDTreeToggle'] }
Plug 'tpope/vim-fireplace', { 'for': ['clojure'] }
Plug 'kana/vim-operator-user'
Plug 'kana/vim-operator-replace', { 'on': '<Plug>(operator-replace)' }
Plug 'rhysd/vim-operator-surround', { 'on': ['<Plug>(operator-surround-append)', '<Plug>(operator-surround-delete)',  '<Plug>(operator-surround-replace)'] }
Plug 'haya14busa/vim-operator-flashy', { 'on': '<Plug>(operator-flashy)' }
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-entire', { 'on': ['<Plug>(textobj-entire-a)', '<Plug>(textobj-entire-i)'] }
Plug 'kana/vim-textobj-fold', { 'on': ['<Plug>(textobj-fold-a)', '<Plug>(textobj-fold-i)'] }
Plug 'kana/vim-textobj-indent', { 'on': ['<Plug>(textobj-indent-a)', '<Plug>(textobj-indent-i)', '<Plug>(textobj-indent-same-a)', '<Plug>(textobj-indent-same-i)'] }
Plug 'gilligan/textobj-lastpaste', { 'on': '<Plug>(textobj-lastpaste-i)' }
Plug 'tyru/caw.vim'
Plug 'LeafCage/yankround.vim'
Plug 'cohama/agit.vim', { 'on': 'Agit' }
Plug 'rhysd/committia.vim'
Plug 'fatih/vim-go', { 'for': 'go' }
Plug 'PProvost/vim-ps1', { 'for': 'ps1' }
Plug 'cespare/vim-toml', { 'for': 'toml' }
Plug 'stephpy/vim-yaml', { 'for': 'yaml' }
Plug 'aklt/plantuml-syntax', { 'for': 'uml' }
Plug 'dzeban/vim-log-syntax', { 'for': 'log' }
Plug 'posva/vim-vue', { 'for': 'vue' }
Plug 'dag/vim-fish', { 'for': 'fish' }
Plug 'rhysd/vim-gfm-syntax', { 'for': 'markdown' }
Plug 'ekalinin/Dockerfile.vim', { 'for': 'Dockerfile' }
Plug 'rust-lang/rust.vim', Cond(executable('cargo'), { 'for': 'rust' })
Plug 'racer-rust/vim-racer', Cond(executable('racer'), { 'for': 'rust' })
Plug 'rhysd/rust-doc.vim', { 'for': 'rust' }
Plug 'b4b4r07/vim-sqlfmt', { 'for': 'sql', 'do': 'go get github.com/jackc/sqlfmt' }


call plug#end()

" After dein.
filetype plugin indent on
syntax enable

" Plugin settings: {{{1
"" lightline. {{{2
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

" indentLine. {{{2
let g:indentLine_faster = 1
nnoremap <silent><Leader>i :<C-u>IndentLinesToggle<CR>
let g:indentLine_fileTypeExclude = ['help', 'nerdtree', 'calendar', 'thumbnail', 'denite', 'tweetvim']
au MyAutoCmd User PreciousFileType execute 'IndentLinesReset'

" vim-rooter. {{{2
let g:rooter_use_lcd = 1

" vim-submode. {{{2
let g:submode_leave_with_key = 1
call submode#enter_with('bufmove', 'n', '', 's>', '<C-w>>')
call submode#enter_with('bufmove', 'n', '', 's<', '<C-w><')
call submode#enter_with('bufmove', 'n', '', 's+', '<C-w>+')
call submode#enter_with('bufmove', 'n', '', 's-', '<C-w>-')
call submode#map('bufmove', 'n', '', '>', '<C-w>>')
call submode#map('bufmove', 'n', '', '<', '<C-w><')
call submode#map('bufmove', 'n', '', '+', '<C-w>+')
call submode#map('bufmove', 'n', '', '-', '<C-w>-')

" FastFold. {{{2
let g:fastfold_savehook = 0

" deoplete. {{{2
let g:deoplete#enable_at_startup = 1

" neocomplete. {{{2
let g:neocomplete#enable_at_startup = 1

" neosnippet. {{{2
imap <C-k> <Plug>(neosnippet_expand_or_jump)
smap <C-k> <Plug>(neosnippet_expand_or_jump)
xmap <C-k> <Plug>(neosnippet_expand_target)
" Tell Neosnippet about the other snippets
let g:neosnippet#snippets_directory = $VIM_PATH . '/snippets'

" For snippet_complete marker.
if has('conceal')
  set conceallevel=2 concealcursor=i
endif

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
      \   }
      \ }

" memolist. {{{2
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

" autodate. {{{2
let g:autodate_format = "%Y/%m/%d %H:%M:%S"
let g:autodate_keyword_pre  = "Last Change *:"
let g:autodate_keyword_post = "."

" vim-autoformat. {{{2
let g:autoformat_autoindent = 0
let g:autoformat_retab = 0
let g:autoformat_remove_trailing_spaces = 1
au MyAutoCmd BufWrite *.js,*.jsx :Autoformat
au MyAutoCmd FileType vim,toml let b:autoformat_autoindent = 0
nnoremap [Space]f :<C-u>Autoformat<CR>

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

" Rust.
let g:ale_rust_ignore_error_codes = ['E0432', 'E0433']

" vim-ro-when-swapfound. {{{2
function! s:swapChoice() abort
  ToggleSwapCheck
  :e
endfunction
com! SwapChoice call s:swapChoice()

" nerdtree. {{{2
nnoremap [Space]v :NERDTreeToggle<CR>
au MyAutoCmd StdinReadPre * let s:std_in=1
au MyAutoCmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif

" denite. {{{2
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
nnoremap sug :<C-u>Denite grep -no-empty<CR>
nnoremap su/ :<C-u>Denite line -no-quit<CR>
nnoremap suR :<C-u>Denite -resume<CR>

noremap sul :<C-u>Denite command_history<CR>

" Incremental search in cmdline history.
inoremap <C-l> <ESC>:<C-u>Denite command<CR>

au! User denite.nvim call s:my_denite_settings()

function! s:my_denite_settings() abort
  " Default options.
  call denite#custom#option('default', {
        \ 'prompt': '»',
        \ 'cursor_wrap': v:true,
        \ 'auto_resize': v:true,
        \ 'highlight_mode_insert': 'WildMenu'
        \ })
  " Pt command on grep source
  if executable('pt')
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

" incsearch. {{{2
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

" vim-operator-replace. {{{2
map _ <Plug>(operator-replace)

" vim-operator-surround. {{{2
map sA <Plug>(operator-surround-append)
map sD <Plug>(operator-surround-delete)
map sR <Plug>(operator-surround-replace)

" vim-operator-flashy. {{{2
map y <Plug>(operator-flashy)
nmap Y <Plug>(operator-flashy)$

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
omap iP <Plug>(textobj-lastpaste-i)
xmap iP <Plug>(textobj-lastpaste-i)

" caw. {{{2
nmap gc <Plug>(caw:prefix)
xmap gc <Plug>(caw:prefix)
nmap gcc <Plug>(caw:hatpos:toggle)
xmap gcc <Plug>(caw:hatpos:toggle)

" yankround. {{[2
nmap p <Plug>(yankround-p)
nmap P <Plug>(yankround-P)
nmap <C-p> <Plug>(yankround-prev)
nmap <C-n> <Plug>(yankround-next)
let g:yankround_max_history = 100

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
let g:gofmt_command = "goimports"
au MyAutoCmd BufWritePre *.go silent Fmt

au MyAutoCmd BufNew,BufRead *.go call s:my_go_settings()

function! s:my_go_settings() abort
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
function! s:addHeaderPs1(flg)
  let lines = []
  if a:flg
    call add(lines, "@set scriptPath=%~f0&@powershell -NoProfile -ExecutionPolicy ByPass \"$s=[scriptblock]::create((gc \\\"%~f0\\\"|?{$_.readcount -gt 2})-join\\\"`n\\\");&$s\" %*")
  else
    call add(lines, "@set scriptPath=%~f0&@powershell -NoProfile -ExecutionPolicy ByPass \"$s=[scriptblock]::create((gc \\\"%~f0\\\"|?{$_.readcount -gt 2})-join\\\"`n\\\");&$s\" %*&@ping -n 30 localhost>nul")
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

" rust. {{{2
let g:rustfmt_autosave = 1

" vim-racer. {{{2
let g:racer_experimental_completer = 1
setl completeopt=menu,preview
au MyAutoCmd FileType rust nmap <buffer> gd <Plug>(rust-def)
au MyAutoCmd FileType rust nmap <buffer> gs <Plug>(rust-def-split)
au MyAutoCmd FileType rust nmap <buffer> gx <Plug>(rust-def-vertical)
au MyAutoCmd FileType rust nmap <buffer> <leader>gd <Plug>(rust-doc)

" vim-sqlfmt. {{{2
let g:sqlfmt_command = "sqlformat"
let g:sqlfmt_options = "-r -k upper"



" Basic: {{{1

" ctags.
set tags& tags-=tags tags+=./tags;

" undo, swap.
let s:undo_dir = $BACKUP_PATH . '/undo'
let s:backup_dir = $BACKUP_PATH . '/back'
let s:directory = $BACKUP_PATH . '/dir'
let s:view_dir = $BACKUP_PATH . '/view'
call Mkdir(s:undo_dir)
call Mkdir(s:backup_dir)
call Mkdir(s:directory)
call Mkdir(s:view_dir)

set undofile
exe 'set undodir=' . s:undo_dir
exe 'set backupdir=' . s:backup_dir
exe 'set directory=' . s:directory
exe 'set viewdir=' . s:view_dir

" Encodings.
set fileencodings=utf-8,cp932,utf-16le,utf-16
set fileformat=unix
set fileformats=unix,dos,mac

" Clipboard.
set clipboard+=unnamedplus

" Indent.
set autoindent
set smartindent
set breakindent

set pastetoggle=
set switchbuf=useopen
set nrformats& nrformats-=octal
set timeoutlen=3500
set hidden
set history=10000
set formatoptions& formatoptions+=mM
set textwidth=0
set virtualedit=block
set whichwrap=b,s,[,],<,>
set backspace=indent,eol,start
set ambiwidth=double
set wildmenu
set wildmode=longest:full,full
set scrolloff=3
set mouse=a
set keywordprg=:help
set autoread

" Search.
set ignorecase
set smartcase
set infercase
set wrapscan
set incsearch
set hlsearch
set grepprg=jvgrep

set noerrorbells
set novisualbell
set visualbell t_vb=
set number
set showmatch matchtime=1

" Tab.
set tabstop=2
set shiftwidth=2
set softtabstop=0
set expandtab

set list
if g:is_windows
  set listchars=tab:\|\ ,trail:-,extends:>,precedes:<
else
  set listchars=tab:\¦\ ,trail:-,extends:»,precedes:«,nbsp:%
endif
set smarttab
set iminsert=0
set imsearch=-1
set cinoptions& cinoptions+=:0
set title
set cmdheight=2
set laststatus=2
set showcmd
set display=lastline
set foldmethod=marker
" set foldclose=all
" set t_Co=256

" Color: {{{1
set background=dark
" colorscheme japanesque
" colorscheme molokai
" colorscheme solarized8_dark
colorscheme onedark
" colorscheme iceberg

" hilight cursorline, cursorcolumn {{{2
" http://d.hatena.ne.jp/thinca/20090530/1243615055
au MyAutoCmd CursorMoved,CursorMovedI * call s:auto_cursorline('CursorMoved')
au MyAutoCmd CursorHold,CursorHoldI * call s:auto_cursorline('CursorHold')
au MyAutoCmd WinEnter,BufEnter,CmdwinLeave * call s:auto_cursorline('WinEnter,BufEnter,CmdwinLeave')
au MyAutoCmd WinLeave * call s:auto_cursorline('WinLeave')

let s:cursorline_lock = 0
function! s:auto_cursorline(event)
  if a:event ==# 'WinEnter,BufEnter,CmdwinLeave'
    setlocal cursorline
    setlocal cursorcolumn
    let s:cursorline_lock = 2
  elseif a:event ==# 'WinLeave'
    setlocal nocursorline
    setlocal nocursorcolumn
  elseif a:event ==# 'CursorMoved'
    if s:cursorline_lock
      if 1 < s:cursorline_lock
        let s:cursorline_lock = 1
      else
        setlocal nocursorline
        setlocal nocursorcolumn
        let s:cursorline_lock = 0
      endif
    endif
  elseif a:event ==# 'CursorHold'
    if &updatetime >= 4000
      setlocal cursorline
      setlocal cursorcolumn
    endif
    let s:cursorline_lock = 1
  endif
endfunction

" Markdown fenced {{{2
let g:markdown_fenced_languages = [
      \ 'css',
      \ 'erb=eruby',
      \ 'javascript',
      \ 'js=javascript',
      \ 'json=javascript',
      \ 'ruby',
      \ 'sass',
      \ 'xml',
      \ 'vim',
      \ ]


" Command: {{{1
" Diff original.
com! DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis | wincmd p | diffthis

" Save as root.
com! Wsu w !sudo tee > /dev/null %

" FileType: {{{1
" au MyAutoCmd BufNewFile,BufRead *.toml setl ft=toml
au MyAutoCmd BufNewFile,BufRead *.eml setl ft=mail
au MyAutoCmd BufNewFile,BufRead *.js setl ft=javascript
au MyAutoCmd BufNewFile,BufRead *.vim setl ft=vim
au MyAutoCmd BufNewFile,BufRead *.md setl ft=markdown
au MyAutoCmd BufNewFile,BufRead *.xml setl ft=xml
au MyAutoCmd BufNewFile,BufRead *.bat setl ft=dosbatch
au MyAutoCmd BufNewFile,BufRead *.html setl ft=html
au MyAutoCmd BufNewFile,BufRead *.json setl ft=json
au MyAutoCmd BufNewFile,BufRead *.fish setl ft=fish


" Mapping: {{{1
" Use verymagic.
" nnoremap / /\v
" inoremap %s/ %s/\v

" Use space.
map <Space> [Space]
noremap [Space] <Nop>

inoremap <silent> jj <ESC>
nnoremap j gj
nnoremap k gk
xnoremap j gj
xnoremap k gk
nnoremap <Down> gj
nnoremap <Up>   gk
nnoremap h <Left>
nnoremap l <Right>
" Open folding in "l"
nnoremap <expr> l foldlevel(line('.')) ? "\<Right>zo" : "\<Right>"

noremap gh ^
noremap gl $

" For tab.
nnoremap <silent><C-l> gt
nnoremap <silent><C-h> gT

" Benri scroll.
" http://itchyny.hatenablog.com/entry/2016/02/02/210000
noremap <expr> <C-b> max([winheight(0) - 2, 1]) . "\<C-u>" . (line('.') < 1         + winheight(0) ? 'H' : 'L')
noremap <expr> <C-f> max([winheight(0) - 2, 1]) . "\<C-d>" . (line('.') > line('$') - winheight(0) ? 'L' : 'H')
noremap <expr> <C-y> (line('w0') <= 1         ? 'k' : "\<C-y>")
noremap <expr> <C-e> (line('w$') >= line('$') ? 'j' : "\<C-e>")

" Useful save mappings.
nnoremap <silent> <Leader><Leader> :<C-u>update<CR>
" Paste continuously.
vnoremap <C-p> "0p<CR>

" Change current directory.
nnoremap [Space]cd :<C-u>call <SID>cd_buffer_dir()<CR>

" Auto mkdir.
au MyAutoCmd BufWritePre * call s:auto_mkdir(expand('<afile>:p:h'), v:cmdbang)

" Like emacs.
cnoremap <C-b> <Left>
cnoremap <C-f> <Right>
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
cnoremap <C-d> <Del>
cnoremap <C-y> <C-r>
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>

" Vim-users.jp - Hack #74: http://vim-users.jp/2009/09/hack74/
nnoremap <silent> [Space]ev  :<C-u>tabedit $MYVIMRC<CR>
nnoremap <silent> [Space]eg  :<C-u>tabedit $MYGVIMRC<CR>

" Cmdwin.
nnoremap : q:i
vnoremap : q:A

" Delete other line.
nnoremap [Space]d :<C-u>call <SID>deleteOtherLine()<CR>

" dein update.
nnoremap [Space]du :<C-u>call dein#update()<CR>

" nohlsearch.
nnoremap <silent> <ESC><ESC> :<C-u>nohlsearch<CR>

" Use prefix s.
nnoremap s <Nop>
nnoremap sj <C-w>j
nnoremap sk <C-w>k
nnoremap sl <C-w>l
nnoremap sh <C-w>h
nnoremap sJ <C-w>J
nnoremap sK <C-w>K
nnoremap sL <C-w>L
nnoremap sH <C-w>H
nnoremap sr <C-w>r
nnoremap s= <C-w>=
nnoremap sw <C-w>w
nnoremap so <C-w>_<C-w>|
nnoremap s0 :<C-u>only<CR>
nnoremap sO :<C-u>tabonly<CR>
nnoremap sn :<C-u>bn<CR>
nnoremap sp :<C-u>bp<CR>
nnoremap st :<C-u>tabnew<CR>
nnoremap ss :<C-u>sp<CR>
nnoremap sv :<C-u>vs<CR>
nnoremap sq :<C-u>q<CR>
nnoremap sQ :<C-u>bd<CR>
nnoremap sbk :<C-u>bd!<CR>
nnoremap sbq :<C-u>q!<CR>

"  for git mergetool {{{2
if &diff
  nnoremap <Leader>1 :diffget LOCAL<CR>
  nnoremap <Leader>2 :diffget BASE<CR>
  nnoremap <Leader>3 :diffget REMOTE<CR>
  nnoremap <Leader>u :<C-u>diffupdate<CR>
endif

" hilight over 100 column {{{2
" http://blog.remora.cx/2013/06/source-in-80-columns-2.html
noremap <Plug>(ToggleColorColumn)
      \ :<c-u>let &colorcolumn = len(&colorcolumn) > 0 ? '' :
      \   join(range(101, 9999), ',')<CR>

nmap <silent> cc <Plug>(ToggleColorColumn)

" http://postd.cc/how-to-boost-your-vim-productivity/
vnoremap <silent> s //e<C-r>=&selection=='exclusive'?'+1':''<CR><CR>
      \:<C-u>call histdel('search',-1)<Bar>let @/=histget('search',-1)<CR>gv
omap s :normal vs<CR>

inoremap <silent> <ESC> <ESC>:set iminsert=0<CR>

" Format.
" nnoremap [Space]f :<C-u>call <SID>format()<CR>

" Autocmd: {{{1
au MyAutoCmd WinEnter,CursorHold * checktime
" au MyAutoCmd CursorHold * setl nohlsearch
au MyAutoCmd CmdwinEnter * :silent! 1,$-50 delete _ | call cursor("$", 1)

" Reload .vimrc automatically.
au MyAutoCmd BufWritePost $MYVIMRC silent! nested source $MYVIMRC | redraw
au MyAutoCmd BufWritePost $MYGVIMRC silent! nested source $MYGVIMRC | redraw

" Auto open cwindow.
au MyAutoCmd QuickfixCmdPost make,grep,vimgrep if len(getqflist()) != 0 | copen | endif

" Auto change dir.
" au MyAutoCmd BufEnter * execute ":silent! lcd " . escape(expand("%:p:h"), ' ')

" For binary.
au MyAutoCmd BufReadPre  *.bin,*.dat let &bin=1
au MyAutoCmd BufReadPost *.bin,*.dat if &bin | %!xxd
au MyAutoCmd BufReadPost *.bin,*.dat set ft=xxd | endif
au MyAutoCmd BufWritePre *.bin,*.dat if &bin | %!xxd -r
au MyAutoCmd BufWritePre *.bin,*.dat endif
au MyAutoCmd BufWritePost *.bin,*.dat if &bin | %!xxd
au MyAutoCmd BufWritePost *.bin,*.dat set nomod | endif

au MyAutoCmd FileType mail nnoremap <silent><buffer> [Space]q :<C-u>silent! call <SID>addQuote()<CR>

"au MyAutoCmd BufWrite * call <SID>format()
au FileType * setlocal formatoptions-=ro

au MyAutoCmd BufWritePost * call <SID>removeFileIf0Byte()

" Restore last cursor position when open a file.
au MyAutoCmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif

" Save and load fold settings.
" http://vim-jp.org/vim-users-jp/2009/10/08/Hack-84.html
au MyAutoCmd BufWritePost * if expand('%') != '' && &buftype !~ 'nofile' | mkview! | endif
au MyAutoCmd BufRead * if expand('%') != '' && &buftype !~ 'nofile' | silent loadview | endif
" Don't save options.
set viewoptions-=options

" For swap.
" http://itchyny.hatenablog.com/entry/2014/12/25/090000
" au MyAutoCmd SwapExists * let v:swapchoice = 'o'

" Escape cmd win.
au MyAutoCmd CmdwinEnter * nnoremap <silent><buffer><nowait> <ESC> :q<CR>

" For git commit.
au MyAutoCmd VimEnter COMMIT_EDITMSG setl spell

" Change colorscheme for readonly.
" au MyAutoCmd BufReadPost,BufEnter * call s:updateColorScheme()

" vim:fdm=marker expandtab fdc=3 ft=vim ts=2 sw=2 sts=2:

