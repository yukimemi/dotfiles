" =============================================================================
" File        : myspacevim.vim
" Author      : yukimemi
" Last Change : 2021/01/24 19:55:10.
" =============================================================================

function! myspacevim#before() abort
  " Init:
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

  let g:mapleader = ','

  " PATH.
  let $SPACE_VIM = expand("~/.SpaceVim.d")

  " Utility:
  " Judge os type.
  let g:is_windows = has("win16") || has("win32") || has("win64")
  let g:is_cygwin = has("win32unix")
  let g:is_darwin = has("mac") || has("macunix") || has("gui_macvim")
  let g:is_linux = !g:is_windows && !g:is_cygwin && !g:is_darwin

  " Functions:
  " dein install check func
  function! IsInstalled(name) abort
    silent! return !dein#check_install(a:name)
  endfunction

  " Statusline.
  function! s:show_bomb() abort
    return &bomb ? 'bomb' : ''
  endfunction
  call SpaceVim#layers#core#statusline#register_sections('bomb', function('s:show_bomb'))

endfunction

function! myspacevim#after() abort

  " Functions:
  function! s:open_current_dir() abort
    if g:is_windows
      setl noshellslash
      silent! exe printf("!start \"%s\"", expand("%:h"))
      setl shellslash
    else
      silent! exe printf("!open \"%s\"", expand("%:h"))
    endif
  endfunction

  function! IsInstalled(name) abort
    silent! return !dein#check_install(a:name)
  endfunction

  " Basic:
  " Options.
  set cmdheight=2
  set virtualedit+=block
  set wildmenu wildignorecase wildmode=longest:full,full
  set ignorecase smartcase infercase

  " Clipboard.
  set clipboard=unnamed,unnamedplus

  " encode.
  set fileencodings=ucs-bom,utf-8,cp932,utf-16le,iso-8859-15

  " grep.
  if executable("jvgrep")
    set grepprg=jvgrep
  endif

  " Commands:
  " VimShowHlGroup: Show highlight group name under a cursor
  " https://rcmdnk.com/blog/2013/12/01/computer-vim/
  command! VimShowHlGroup echo synIDattr(synIDtrans(synID(line('.'), col('.'), 1)), 'name')
  " VimShowHlItem: Show highlight item name under a cursor
  command! VimShowHlItem echo synIDattr(synID(line("."), col("."), 1), "name")

  " https://qiita.com/1000k/items/6d4953d2dd52fdd86556
  command! RemoveAnsi %s/<1b>\[[0-9;]*m//g

  " https://daisuzu.hatenablog.com/entry/2018/12/13/012608
  command! -bar ToScratch
        \ setlocal buftype=nofile bufhidden=hide noswapfile

  command! -nargs=1 -complete=command L
        \ <mods> new | ToScratch |
        \ call setline(1, split(execute(<q-args>), '\n'))

  " Mappings:
  nnoremap <silent> ,, :<c-u>update<cr>

  inoremap <silent> jj <esc>
  nnoremap <silent> j gj
  nnoremap <silent> k gk
  xnoremap <silent> j gj
  xnoremap <silent> k gk
  nnoremap <silent> <Down> gj
  nnoremap <silent> <Up>   gk
  nnoremap <silent> h <Left>
  nnoremap <silent> l <Right>
  inoremap <silent> <c-l> <c-g>U<Right>

  " For window.
  nnoremap <silent> sj <c-w>j
  nnoremap <silent> sk <c-w>k
  nnoremap <silent> sl <c-w>l
  nnoremap <silent> sh <c-w>h
  nnoremap <silent> sJ <c-w>J
  nnoremap <silent> sK <c-w>K
  nnoremap <silent> sL <c-w>L
  nnoremap <silent> sH <c-w>H
  nnoremap <silent> sr <c-w>r
  nnoremap <silent> s= <c-w>=
  nnoremap <silent> sw <c-w>w
  nnoremap <silent> so <c-w>_<c-w>|
  nnoremap <silent> s0 :<c-u>only<cr>
  nnoremap <silent> sO :<c-u>tabonly<cr>
  nnoremap <silent> sn :<c-u>bn<cr>
  nnoremap <silent> sp :<c-u>bp<cr>
  nnoremap <silent> st :<c-u>tabnew<cr>
  nnoremap <silent> ss :<c-u>sp<cr>
  nnoremap <silent> sv :<c-u>vs<cr>
  nnoremap <silent> sq :<c-u>q<cr>
  nnoremap <silent> sQ :<c-u>qa<cr>
  nnoremap <silent> sbk :<c-u>bd!<cr>
  nnoremap <silent> sbq :<c-u>q!<cr>

  " For tab.
  nnoremap <silent><c-l> gt
  nnoremap <silent><c-h> gT

  " nohlsearch.
  nnoremap <silent> <esc><esc> :<c-u>nohlsearch<cr>

  " Open folding in "l"
  nnoremap <expr> l foldlevel(line('.')) ? "\<Right>zo" : "\<Right>"

  noremap <silent> gh ^
  noremap <silent> gl $
  nnoremap <silent> Y y$

  nnoremap <silent> ,o :<c-u>call <SID>open_current_dir()<cr>
  inoremap <silent> <esc> <esc>:set iminsert=0<cr>

  cnoremap <c-p> <Up>
  cnoremap <c-n> <Down>

  " Autocmd:
  " https://lambdalisue.hatenablog.com/entry/2017/12/24/165759
  au MyAutoCmd BufWritePost *
        \ if &filetype ==# '' && exists('b:ftdetect') |
        \   unlet! b:ftdetect |
        \   filetype detect |
        \ endif

  " For swap.
  " http://itchyny.hatenablog.com/entry/2014/12/25/090000
  au MyAutoCmd SwapExists * let v:swapchoice = 'o'

  " Escape cmd win.
  au MyAutoCmd CmdwinEnter * nnoremap <silent><buffer><nowait> <esc> :q<cr>
  " Escape quickfix.
  au MyAutoCmd FileType quickfix,qf nnoremap <silent><buffer><nowait> <esc> :q<cr>

  " Escape E211.
  au MyAutoCmd FileChangedShell * execute

  " Auto open quickfix.
  au MyAutoCmd QuickfixCmdPost make,grep,grepadd,vimgrep copen

  " For all filetype.
  au MyAutoCmd FileType * setlocal fo-=t fo-=c fo-=r fo-=o

  " Hilight cursorline, cursorcolumn {{{2
  " https://github.com/mopp/dotfiles/blob/14fc5fba2429a1d70aac2b904e46c5c2930063ae/.vimrc#L468-L472
  let s:cur_f = 0
  au MyAutoCmd WinEnter,BufEnter,CmdwinLeave * setlocal cursorline cursorcolumn | let s:cur_f = 1
  au MyAutoCmd WinLeave * setlocal nocursorline nocursorcolumn | let s:cur_f = 0
  au MyAutoCmd CursorHold,CursorHoldI * setlocal cursorline cursorcolumn | let s:cur_f = 1
  au MyAutoCmd CursorMoved,CursorMovedI * if s:cur_f | setlocal nocursorline nocursorcolumn | let s:cur_f = 0 | endif


  " Plugins:
  " denite
  if IsInstalled('denite.nvim')
    au MyAutoCmd FileType denite call <SID>denite_my_custom_settings()
    au MyAutoCmd FileType denite-filter call <SID>denite_filter_my_custom_settings()
    function! s:denite_my_custom_settings() abort
      nnoremap <silent><buffer><nowait><expr> <esc> denite#do_map('quit')
    endfunction

    function! s:denite_filter_my_custom_settings() abort
      nmap <silent><buffer><nowait> <esc> <Plug>(denite_filter_quit)
      inoremap <silent><buffer> <c-j> <esc><c-w>p:call cursor(line('.')+1,0)<cr><c-w>pA
      inoremap <silent><buffer> <c-k> <esc><c-w>p:call cursor(line('.')-1,0)<cr><c-w>pA
    endfunction
    nnoremap <leader>fc :<c-u>Denite command_history<cr>
    nnoremap <leader>fH :<c-u>Denite help<cr>
    nnoremap <leader>ff :<c-u>Denite filetype<cr>
  endif

  " ctrlp
  if IsInstalled('ctrlp.vim')
    " let g:ctrlp_clear_cache_on_exit = 0
    let g:ctrlp_key_loop = 1
    " let g:ctrlp_lazy_update = 200
    let g:ctrlp_line_prefix = '» '
    let g:ctrlp_map = '<nop>'
    let g:ctrlp_match_current_file = 1
    " let g:ctrlp_match_window = 'bottom,order:btt,min:1,max:20,results:100'
    " let g:ctrlp_mruf_max = 100000
    let g:ctrlp_show_hidden = 1
    let g:ctrlp_use_caching = 1
    let g:ctrlp_user_command_async = 1
    nnoremap <silent> <leader>ff :<c-u>CtrlPFiletype<cr>
    nnoremap <silent> <leader>fl :<c-u>CtrlPLauncher<cr>
    nnoremap <silent> <leader>f/ :<c-u>CtrlPSearchHistory<cr>
    nnoremap <silent> <leader>fc :<c-u>CtrlPCmdHistory<cr>
    " nnoremap <silent> <leader>fc :<c-u>CtrlPCommandLine<cr>
    nnoremap <silent> <leader>fM :<c-u>CtrlPMemolist<cr>
    nnoremap <silent> <leader>fs :<c-u>CtrlP ~/src<cr>
    nnoremap <silent> <leader>fd :<c-u>CtrlP ~/.dotfiles<cr>

    command! CtrlPCommandLine silent! packadd vim-ctrlp-commandline | call ctrlp#init(ctrlp#commandline#id())

    if exists('*matchfuzzy')
      " Use ctrlp-matchfuzzy.
      let g:ctrlp_match_func = {'match': 'ctrlp_matchfuzzy#matcher'}
    elseif has('python')
      " Use fruzzy.
      let g:fruzzy#usenative = 1
      let g:ctrlp_match_func = {'match': 'fruzzy#ctrlp#matcher'}
    endif
  endif

  " others
  " source $SPACE_VIM/rc/LeaderF.vim
  source $SPACE_VIM/rc/coc.nvim
  source $SPACE_VIM/rc/indentLine.vim

  " GUI:
  let g:spacevim_guifont = "Cica:h10"

  if has('clientserver')
    call dein#call_hook('source')
  endif

endfunction

