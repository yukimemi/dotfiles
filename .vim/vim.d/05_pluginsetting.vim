if neobundle#tap('neobundle.vim')"{{{
  " mapping for NeoBundle
  nnoremap [Space]bi :<C-u>NeoBundleInstall<CR>

  call neobundle#untap()
endif
"}}}

if neobundle#tap('lightline.vim')"{{{
  let g:lightline = {
        \ 'colorscheme': 'wombat',
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
        \   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename', 'anzu' ] ],
        \   'right': [ [ 'lineinfo' ], [ 'percent' ], [ 'fileformat', 'fileencoding', 'filetype' ],
        \              [ 'absolutepath' ] ]
        \ },
        \ 'component_function': {
        \   'modified': 'MyModified',
        \   'readonly': 'MyReadonly',
        \   'fugitive': 'MyFugitive',
        \   'filename': 'MyFilename',
        \   'fileformat': 'MyFileformat',
        \   'filetype': 'MyFiletype',
        \   'fileencoding': 'MyFileencoding',
        \   'absolutepath': 'MyAbsolutePath',
        \   'mode': 'MyMode',
        \   'anzu': 'anzu#search_status'
        \ }
        \ }

  function! MyModified()"{{{
    return &ft =~ 'help\|vimfiler\|gundo' ? '' : &modified ? '+' : &modifiable ? '' : '-'
  endfunction"}}}

  function! MyReadonly()"{{{
    if g:is_windows
      return &ft !~? 'help\|vimfiler\|gundo' && &readonly ? 'R' : ''
    else
      return &ft !~? 'help\|vimfiler\|gundo' && &readonly ? '⭤' : ''
    endif
  endfunction"}}}

  function! MyFilename()"{{{
    return ('' != MyReadonly() ? MyReadonly() . ' ' : '') .
          \ (&ft == 'vimfiler' ? vimfiler#get_status_string() :
          \  &ft == 'unite' ? unite#get_status_string() :
          \  &ft == 'vimshell' ? vimshell#get_status_string() :
          \ '' != expand('%:t') ? expand('%:t') : '[No Name]') .
          \ ('' != MyModified() ? ' ' . MyModified() : '')
  endfunction"}}}

  function! MyFugitive()"{{{
    if &ft !~? 'vimfiler\|gundo' && exists("*fugitive#head")
      let _ = fugitive#head()
      if g:is_windows
        return strlen(_) ? '| '._ : ''
      else
        return strlen(_) ? '⭠ '._ : ''
      endif
    endif
    return ''
  endfunction"}}}

  function! MyFileformat()"{{{
    return winwidth('.') > 70 ? &fileformat : ''
  endfunction"}}}

  function! MyFiletype()"{{{
    return winwidth('.') > 70 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
  endfunction"}}}

  function! MyFileencoding()"{{{
    return winwidth('.') > 70 ? (strlen(&fenc) ? &fenc : &enc) : ''
  endfunction"}}}

  function! MyMode()"{{{
    return winwidth('.') > 60 ? lightline#mode() : ''
  endfunction"}}}

  function! MyAbsolutePath()"{{{
    return (winwidth('.') - strlen(expand('%')) > 70) ? expand('%') : ''
  endfunction"}}}

  call neobundle#untap()
endif
"}}}

if neobundle#tap('neocomplete.vim')"{{{
  function! neobundle#hooks.on_source(bundle)
    let g:neocomplete#enable_at_startup = 1
    let g:neocomplete#enable_smart_case = 1
    let g:neocomplete#sources#syntax#min_keyword_length = 1
    " let g:neocomplete#skip_auto_completion_time = 5
    let g:neocomplete#enable_auto_close_preview = 0
    " Define dictionary.
    let g:neocomplete#sources#dictionary#dictionaries = {
          \ 'default': '',
          \ 'vimshell': $HOME . '/.vimshell_hist',
          \ 'scheme': $HOME . '/.gosh_completions',
          \ 'coffee': $MY_VIMRUNTIME . '/dict/coffee.dict',
          \ 'vbs': $MY_VIMRUNTIME . '/dict/vbs.dict',
          \ 'dosbatch': $MY_VIMRUNTIME . '/dict/dosbatch.dict',
          \ 'scala': $MY_VIMRUNTIME . '/dict/scala.dict',
          \ 'ps1': $MY_VIMRUNTIME . '/dict/ps1.dict',
          \ 'javascript': $MY_VIMRUNTIME . '/dict/wsh.dict',
          \ 'ruby': $MY_VIMRUNTIME . '/dict/ruby.dict'
          \ }

    if !exists('g:neocomplete#sources#omni#functions')
      let g:neocomplete#sources#omni#functions = {}
    endif
    " SQL
    let g:neocomplete#sources#omni#functions.sql = 'sqlcomplete#Complete'
    " typescript
    " let g:neocomplete#sources#omni#functions.typescript = 'TSScompleteFunc'

    if !exists('g:neocomplete#force_omni_input_patterns')
      let g:neocomplete#force_omni_input_patterns = {}
    endif
    let g:neocomplete#force_omni_input_patterns.typescript = '[^.[:digit:] *\t]\%(\.\|->\)\w*\|\h\w*::\w*'
    let g:neocomplete#force_omni_input_patterns.ruby = '[^. *\t]\.\w*\|\h\w*::'
  endfunction

  call neobundle#untap()
endif
"}}}

if neobundle#tap('echodoc.vim')"{{{
  function! neobundle#hooks.on_source(bundle)
    let g:echodoc_enable_at_startup = 1
  endfunction
  call neobundle#untap()
endif
"}}}

if neobundle#tap('vim-gitgutter')"{{{
  let g:gitgutter_sign_added = '✚'
  let g:gitgutter_sign_modified = '➜'
  let g:gitgutter_sign_removed = '✘'

  call neobundle#untap()
endif
"}}}

if neobundle#tap('vim-submode')"{{{
  let g:submode_leave_with_key = 1

  " user prefix 's' http://qiita.com/tekkoc/items/98adcadfa4bdc8b5a6ca
  nnoremap s <Nop>
  nnoremap sj <C-w>j
  nnoremap sk <C-w>k
  nnoremap sl <C-w>l
  nnoremap sh <C-w>h
  " nnoremap sJ <C-w>J
  " nnoremap sK <C-w>K
  " nnoremap sL <C-w>L
  " nnoremap sH <C-w>H
  nnoremap sn gt
  nnoremap sp gT
  nnoremap sr <C-w>r
  nnoremap s= <C-w>=
  nnoremap sw <C-w>w
  nnoremap so <C-w>_<C-w>|
  nnoremap s0 :<C-u>only<CR>
  nnoremap sO :<C-u>tabonly<CR>
  nnoremap sN :<C-u>bn<CR>
  nnoremap sP :<C-u>bp<CR>
  nnoremap st :<C-u>tabnew<CR>
  nnoremap ss :<C-u>sp<CR>
  nnoremap sv :<C-u>vs<CR>
  nnoremap sq :<C-u>q<CR>
  nnoremap sQ :<C-u>bd<CR>

  nnoremap sbk :<C-u>bd!<CR>
  nnoremap sbq :<C-u>q!<CR>

  call submode#enter_with('bufmove', 'n', '', 's>', '<C-w>>')
  call submode#enter_with('bufmove', 'n', '', 's<', '<C-w><')
  call submode#enter_with('bufmove', 'n', '', 's+', '<C-w>+')
  call submode#enter_with('bufmove', 'n', '', 's-', '<C-w>-')
  call submode#map('bufmove', 'n', '', '>', '<C-w>>')
  call submode#map('bufmove', 'n', '', '<', '<C-w><')
  call submode#map('bufmove', 'n', '', '+', '<C-w>+')
  call submode#map('bufmove', 'n', '', '-', '<C-w>-')

  call neobundle#untap()
endif
"}}}

if neobundle#tap('vim-anzu')"{{{

  au MyAutoCmd WinLeave,TabLeave * call anzu#clear_search_status()

  call neobundle#untap()
endif
"}}}

if neobundle#tap('TweetVim')"{{{
  au MyAutoCmd FileType tweetvim call s:my_tweetvim_mappings()
  nnoremap [Space]ut :<C-u>Unite tweetvim<CR>
  nnoremap [Space]tu :<C-u>TweetVimUserStream<CR>
  nnoremap [Space]tl :<C-u>Unite tweetvim<CR>
  nnoremap [Space]ta :<C-u>Unite tweetvim/account<CR>

  function! s:my_tweetvim_mappings()
    " setl nowrap
    nnoremap <buffer> [Space]s :<C-u>TweetVimSay<CR>
  endfunction

  let g:tweetvim_default_account = "yukimemi"
  let g:tweetvim_tweet_per_page = 100
  let g:tweetvim_cache_size = 50
  "let g:tweetvim_display_username = 1
  let g:tweetvim_display_source = 1
  let g:tweetvim_display_time = 1
  "let g:tweetvim_display_icon = 1
  let g:tweetvim_async_post = 1

  call neobundle#untap()
endif
"}}}

if neobundle#tap('vim-indent-guides')"{{{
  let g:indent_guides_enable_on_vim_startup = 1
  let g:indent_guides_guide_size = 1
  let g:indent_guides_auto_colors = 1
  let g:indent_guides_start_level = 2
  let g:indent_guides_exclude_filetypes = ['help', 'nerdtree', 'calendar', 'thumbnail']

  call neobundle#untap()
endif
"}}}

if neobundle#tap('vimfiler.vim')"{{{
  nnoremap <Leader>f :<C-u>VimFiler -split -simple -find -toggle -winwidth=35 -no-quit<CR>
  nnoremap <C-e> :<C-u>VimFilerDouble<CR>
  nnoremap <expr><Leader>g <SID>git_root_dir()
  function! s:git_root_dir()
    " http://qiita.com/items/39134f75e9360e1e733d
    if(system('git rev-parse --is-inside-work-tree') == "true\n")
      return ':VimFiler ' . '-split ' . '-simple ' . '-winwidth=35 ' . '-no-quit '
            \ . system('git rev-parse --show-cdup') . '\<CR>'
    else
      echoerr '!!!current directory is outside git working tree!!!'
    endif
  endfunction
  function! neobundle#hooks.on_source(bundle)
    let g:vimfiler_as_default_explorer = 1
    let g:vimfiler_enable_auto_cd = 1
    if g:is_windows
      let g:unite_kind_file_use_trashbox = 1
    endif
  endfunction

  call neobundle#untap()
endif
"}}}

if neobundle#tap('vimshell.vim')"{{{
  function! neobundle#hooks.on_source(bundle)"{{{
    au MyAutoCmd FileType vimshell
          \ if ! g:is_windows
          \ | call vimshell#altercmd#define('i', 'iexe')
          \ | call vimshell#altercmd#define('ll', 'ls -l')
          \ | call vimshell#altercmd#define('la', 'ls -a')
          \ | call vimshell#altercmd#define('lla', 'ls -al')
          \ | call vimshell#altercmd#define('lv', 'vim -R')
          \ | call vimshell#altercmd#define('vimfiler', 'vim -c VimFilerDouble')
          \ | call vimshell#altercmd#define('rm', 'rmtrash')
          \ | call vimshell#altercmd#define('s', ':UniteBookmarkAdd .')
          \ | call vimshell#altercmd#define('g', ':Unite bookmark -start-insert')
          \ | call vimshell#altercmd#define('l', ':Unite bookmark')
          \ | call vimshell#hook#add('chpwd', 'my_chpwd', 'MyChpwd')
          \ | else
            \ | call vimshell#altercmd#define('vimfiler', 'gvim -c VimFilerDouble')
            \ | endif

    function! MyChpwd(args, context)
      call vimshell#execute('ls')
    endfunction

    autocmd FileType int-* call s:interactive_settings()
    function! s:interactive_settings()
    endfunction

    " history
    let g:vimshell_max_command_history = 5000000
    " mapping
    "nnoremap [Space]s :<C-u>VimShell<CR>
    au MyAutoCmd FileType vimshell inoremap <buffer> <C-^> cd<Space>../<CR>
    au MyAutoCmd FileType vimshell imap <buffer> <C-l> <Plug>(vimshell_clear)
  endfunction
  "}}}

  call neobundle#untap()
endif
"}}}

if neobundle#tap('neosnippet.vim')"{{{

  " Plugin key-mappings.
  imap <C-k> <Plug>(neosnippet_expand_or_jump)
  smap <C-k> <Plug>(neosnippet_expand_or_jump)
  xmap <C-k> <Plug>(neosnippet_expand_target)
  function! neobundle#hooks.on_source(bundle)
    " Tell Neosnippet about the other snippets
    let g:neosnippet#snippets_directory = $HOME . '/.snippets'

    " For snippet_complete marker.
    if has('conceal')
      set conceallevel=2 concealcursor=i
    endif

    " for unite
    imap <C-s> <Plug>(neosnippet_start_unite_snippet)
  endfunction

  call neobundle#untap()
endif
"}}}

if neobundle#tap('unite.vim')"{{{
  " Use plefix s
  nnoremap suc :<C-u>Unite colorscheme -auto-preview<CR>
  nnoremap suy :<C-u>Unite history/yank<CR>
  nnoremap sub :<C-u>Unite buffer<CR>
  if g:is_windows
    nnoremap suf :<C-u>Unite file_rec<CR>
    nnoremap suF :<C-u>Unite file_rec<CR>
  else
    nnoremap suf :<C-u>Unite file_rec/async<CR>
    nnoremap suF :<C-u>Unite file_rec/async<CR>
  endif
  nnoremap suB :<C-u>Unite bookmark -default-action=cd<CR>
  nnoremap suo :<C-u>Unite outline -no-quit -no-start-insert -vertical -winwidth=40<CR>
  nnoremap suq :<C-u>Unite quickfix -no-quit<CR>
  nnoremap suh :<C-u>Unite help<CR>
  nnoremap sur :<C-u>Unite register<CR>
  " nnoremap sum :<C-u>Unite neomru/file -auto-preview<CR>
  nnoremap su/ :<C-u>Unite line -no-quit<CR>
  nnoremap sug :<C-u>Unite grep -no-quit<CR>
  nnoremap sut :<C-u>Unite tab<CR>
  nnoremap suu :<C-u>Unite buffer neomru/file<CR>
  nnoremap sua :<C-u>Unite buffer neomru/file bookmark file file_rec/async<CR>
  nnoremap suM :<C-u>Unite mapping<CR>
  nnoremap suR :<C-u>UniteResume<CR>

  " NeoBundle
  nnoremap sui :<C-u>Unite neobundle/update -no-start-insert -no-split<CR>
  nnoremap sus :<C-u>Unite neobundle/search<CR>
  " grep ~/.vim_junk
  nnoremap suj :<C-u>Unite grep:~/.cache/junkfile<CR>

  " Incremental search in cmdline history.
  " http://d.hatena.ne.jp/osyo-manga/20140825
  inoremap <C-l> <ESC>:Unite history/command -start-insert -default-action=edit<CR>

  " http://d.hatena.ne.jp/osyo-manga/20131217/1387292034"{{{
  let g:unite_source_alias_aliases = {
        \ "startup_neomru": {
        \   "source": "neomru/file"
        \ },
        \ "startup_directory_mru": {
        \   "source": "directory_mru"
        \ }
        \}

  call unite#custom_max_candidates("startup_neomru", 10)
  call unite#custom_max_candidates("startup_directory_mru", 10)

  if !exists("g:unite_source_menu_menus")
    let g:unite_source_menu_menus = {}
  endif
  let g:unite_source_menu_menus.startup = {
        \ "description": "startup menu",
        \   "command_candidates": [
        \     ["vimrc",  "edit " . $MYVIMRC],
        \     ["gvimrc", "edit " . $MYGVIMRC],
        \     ["unite-neomru", "Unite neomru/file"],
        \     ["unite-directory_mru", "Unite directory_mru"],
        \   ]
        \ }
  command! UniteStartup
        \ Unite
        \ output:echo:"===:file:mru:===":! startup_neomru
        \ output:echo:":":!
        \ output:echo:"===:directory:mru:===":! startup_directory_mru
        \ output:echo:":":!
        \ output:echo:"===:menu:===":! menu:startup
        \ -hide-source-names
        \ -no-split
        \ -quick-match
  " Auto start if arguments is nothing
  if has('vim_starting') && expand("%") == ""
    " au MyAutoCmd VimEnter * nested :UniteStartup
  endif
  "}}}

  " grep source setting
  if executable('jvgrep')
    let g:unite_source_grep_command = 'jvgrep'
    let g:unite_source_grep_default_opts = '-i --color=never'
    let g:unite_source_grep_recursive_opt = '-R'
  elseif executable('pt')
    let g:unite_source_grep_command = 'pt'
    let g:unite_source_grep_default_opts = '--nogroup --nocolor'
    let g:unite_source_grep_recursive_opt = ''
  elseif executable('ag')
    let g:unite_source_grep_command = 'ag'
    let g:unite_source_grep_default_opts = '--nocolor --nogroup --column'
    let g:unite_source_grep_recursive_opt = ''
  endif

  " Like ctrlp.vim settings.
  let s:unite_default_context = {
        \ 'start_insert': 1,
        \ 'winheight': 10,
        \ 'direction': 'botright'
        \ }
  call extend(s:unite_default_context, {
        \ 'prompt': '» ',
        \ 'marked_icon': '✗'
        \ })
  call unite#custom#profile('default', 'context', s:unite_default_context)

  " use vimfiler to open directory
  call unite#custom#default_action("source/bookmark/directory", "vimfiler")
  call unite#custom#default_action("directory", "vimfiler")
  call unite#custom#default_action("directory_mru", "vimfiler")
  "call unite#custom#default_action("file", "tabdrop")

  au MyAutoCmd FileType unite call s:unite_settings()
  function! s:unite_settings()
    nmap <buffer> <Esc> <Plug>(unite_exit)
    nmap <buffer> <C-n> <Plug>(unite_select_next_line)
    nmap <buffer> <C-p> <Plug>(unite_select_previous_line)
  endfunction

  call neobundle#untap()
endif
"}}}

if neobundle#tap('open-browser.vim')"{{{

  " http://vim-users.jp/2011/08/hack225/
  nmap gx <Plug>(openbrowser-smart-search)
  vmap gx <Plug>(openbrowser-smart-search)

  call neobundle#untap()
endif
"}}}

if neobundle#tap('vim-fugitive') "{{{
  nnoremap [Space]gd :<C-u>Gdiff<Enter>
  nnoremap [Space]gs :<C-u>Gstatus<Enter>
  nnoremap [Space]gl :<C-u>Glog<Enter>
  nnoremap [Space]ga :<C-u>Gwrite<Enter>
  nnoremap [Space]gc :<C-u>Gcommit<Enter>
  nnoremap [Space]gC :<C-u>Git commit --amend<Enter>
  nnoremap [Space]gp :<C-u>Git pull --rebase<Enter>
  nnoremap [Space]gb :<C-u>Gblame<Enter>

  call neobundle#untap()
endif
"}}}

if neobundle#tap('vim-quickrun')"{{{

  nmap <Leader>r <Plug>(quickrun)
  nmap <Leader>a :<C-u>QuickRun<Space>-args<Space>

  " echo quickrun command output {{{
  " http://d.hatena.ne.jp/osyo-manga/searchdiary?word=quickrun
  let s:hook = {
        \   "name": "output_command",
        \   "kind": "hook",
        \   "config": {
        \     "enable": 0,
        \     "log": 0
        \   }
        \ }

  function! s:hook.on_ready(session, context)
    " HierClear
    for command in a:session.commands
      execute self.config.log ? "echom command" : "echo command"
    endfor
  endfunction

  call quickrun#module#register(s:hook, 1)
  unlet s:hook
  "}}}

  " TypeScript compile according to the reference path {{{
  let s:hook = {
        \ "name": "typescript_compile",
        \ "kind": "hook",
        \ "config": {
        \     "enable": 0
        \  }
        \ }
  function! s:hook.on_module_loaded(session, context)
    let references = []
    for line in readfile(a:session.config.srcfile, '', 15)
      if line =~ '^///<reference path='
        "echom 'reference : ' . line[stridx(line, '"') + 1 : -4]
        if line[stridx(line, '"') + 1 : -4] !~ 'lib.d.ts'
          call add(references, line[stridx(line, '"') + 1 : -4])
        endif
      endif
    endfor
    "echom 'exec : %c --nolib %s ' . join(references, ' ') . ' --out %s:p:r.js'
    let a:session.config.exec = '%c --nolib %s ' . join(references, ' ') . ' --out %s:p:r.js'
  endfunction
  call quickrun#module#register(s:hook, 1)
  unlet s:hook"}}}

  " coffeescript compile {{{
  let s:hook = {
        \ "name": "coffeescript_compile",
        \ "kind": "hook",
        \ "config": {
        \     "enable": 0
        \  }
        \ }
  function! s:hook.on_module_loaded(session, context)
    let imports = []
    for line in readfile(a:session.config.srcfile, '', 15)
      if line =~ '^# import'
        "echom 'import : ' . line[10 : -2]
        call add(imports, line[10 : -2])
      endif
    endfor
    "echom 'exec : %c -j %s:p:r.js -cb ' . join(imports, ' ') . ' %s'
    let a:session.config.exec = '%c -j %s:p:r.js -cb ' . join(imports, ' ') . ' %s'
  endfunction
  call quickrun#module#register(s:hook, 1)
  unlet s:hook
  "}}}

  " add wsh header {{{
  let s:hook = {
        \ "name": "js2cmd",
        \ "kind": "hook",
        \ "config": {
        \     "enable": 0
        \  }
        \ }
  function! s:hook.on_success(session, context)
    let list = []
    call add(list, "@if(0)==(0) ECHO OFF")
    for line in readfile(a:session.config.srcfile, '', 10)
      if line =~ '^//' || line =~ '^#'
        if line[3 : 4] =~ 'OP' || line[2 : 3] =~ 'OP'
          "echom 'option : ' . line[stridx(line, '"') + 1 : -2]
          if line[stridx(line, '"') + 1 : -2] =~ '^pushd'
            call add(list, "  pushd \"%~dp0\" > nul")
            call add(list, "  CScript.exe //NoLogo //E:JScript \"%~f0\" %*")
            call add(list, "  popd > nul")
            break
          else
            call add(list, "  CScript.exe //NoLogo //E:JScript \"%~f0\" %*")
            break
          endif
        endif
      endif
    endfor
    call add(list, "pause")
    call add(list, "GOTO :EOF")
    call add(list, "@end")
    call add(list, "")
    let inJs = fnamemodify(a:session.config.srcfile, ":p:r") . '.js'
    let outCmd = fnamemodify(a:session.config.srcfile, ":p:h") . '/_cmd/'
          \ . fnamemodify(a:session.config.srcfile, ":t:r") .'.cmd'
    "echom inJs
    "echom outCmd
    let utf8List = list + readfile(inJs, 'b')
    let cp932List = []
    for line in utf8List
      "call add(cp932List, iconv(line, "UTF-8", "CP932"))
      call add(cp932List, iconv(substitute(line, "\n", "\r\n", "",), "UTF-8", "CP932"))
    endfor
    if isdirectory(fnamemodify(a:session.config.srcfile, ":p:h") . '/_cmd')
      call writefile(cp932List, outCmd, 'b')
      if has('win32') || has('win64')
        "call {s:system}('del ' . inJs)
        call {s:system}('unix2dos ' . outCmd)
      else
        "call {s:system}('rm ' . inJs)
        call {s:system}('nkf --windows --overwrite ' . outCmd)
      endif
    else
      echom fnamemodify(a:session.config.srcfile, ":p:h") . '/_cmd' . 'is not found !'
    endif
  endfunction

  call quickrun#module#register(s:hook, 1)
  unlet s:hook
  "}}}

  let g:quickrun_config = {}
  let g:quickrun_config = {
        \   "_": {
        \     "hook/output_command/enable": 1,
        \     "hook/output_command/log": 1,
        \     "hook/close_unite_quickfix/enable_hook_loaded": 1,
        \     "hook/unite_quickfix/enable_failure": 1,
        \     "hook/close_quickfix/enable_exit": 1,
        \     "hook/close_buffer/enable_failure": 1,
        \     "hook/close_buffer/enable_empty_data": 1,
        \     "hook/echo/enable": 1,
        \     "hook/echo/output_success": "success!!!",
        \     "hook/echo/output_failure": "failure...",
        \     "outputter": "multi:buffer:quickfix",
        \     "outputter/buffer/split": ":botright 18sp",
        \     "runner": "vimproc",
        \     "runner/vimproc/updatetime": 40
        \   },
        \ "typescript": {
        \     "commad": "tsc",
        \     "cmdopt": "--nolib --out",
        \     "exec"  : "%c %s _lib.ts %o %s:p:r.js",
        \     "hook/typescript_compile/enable": 1,
        \     "hook/js2cmd/enable": 1,
        \     "hook/output_command/log": 1
        \   },
        \ "plantuml": {
        \     "command": "java",
        \     "cmdopt": "-jar ../bin/plantuml.jar -tpng",
        \     "exec": "%c %o %s"
        \   },
        \ "mermaid": {
        \     "command": "mermaid",
        \     "exec": "%c %s"
        \   },
        \ "blockdiag": {
        \     "command": "blockdiag",
        \     "cmdopt": "-Tsvg",
        \     "exec": "%c %o %s"
        \   },
        \ "rst": {
        \     "command": "make",
        \     "cmdopt": "html",
        \     "exec": "%c %o"
        \ },
        \ "ps1": {
        \     'hook/output_encode/enable': 1,
        \     'hook/output_encode/encoding': "cp932"
        \ },
        \ "markdown": {
        \     "type": "markdown/pandoc",
        \     "outputter": "browser"
        \ },
        \ "ruby": {
        \     "command": "ruby",
        \     "cmdopt": "bundle exec",
        \     "exec": "%o %c %s"
        \ }
        \ }

  " stop quickrun
  nnoremap <expr><silent> <C-c> quickrun#is_running() ? quickrun#sweep_sessions() : "\<C-c>"
  call neobundle#untap()
endif
"}}}

if neobundle#tap('vim-coffee-script')"{{{
  let coffee_compile_vert = 1
  let coffee_make_options = '--bare'

  call neobundle#untap()
endif
"}}}

if neobundle#tap('jedi-vim')"{{{

  function! neobundle#hooks.on_source(bundle)
    let g:jedi#auto_initialization = 1
    let g:jedi#auto_vim_configuration = 0
    let g:jedi#goto_assignments_command = '<Leader>G'
    let g:jedi#popup_select_first = 0
    let g:jedi#rename_command = '<Leader>R'
    let g:jedi#show_call_signatures = 1
    "let g:jedi#popup_on_dot = 1
    au MyAutoCmd FileType python let b:did_ftplugin = 1
  endfunction
  call neobundle#untap()
endif
"}}}

if neobundle#tap('vim-ref')"{{{
  function! s:unite_ref_doc()
    if &filetype =~ 'perl'
      Unite ref/perldoc
    elseif &filetype =~ 'python'
      Unite -start-insert ref/pydoc
    elseif &filetype =~ 'ruby'
      Unite -start-insert ref/ri
    else
      Unite ref/man
    endif
  endfunction
  " nnoremap sur :<C-u>call s:unite_ref_doc()<CR>
  command! UniteRef call <SID>unite_ref_doc()
  call neobundle#untap()
endif
"}}}

if neobundle#tap('ctrlp.vim')"{{{
  let g:ctrlp_map = '<Leader>p'
  nnoremap <Leader>p :<C-u>CtrlP<CR>
  call neobundle#untap()
endif
"}}}

if neobundle#tap('vim-automatic')"{{{
  " http://blog.supermomonga.com/articles/vim/automatic.html

  nnoremap <silent> <Plug>(quit) :<C-u>q<CR>
  function! s:my_temporary_window_init(config, context)
    nmap <buffer> <C-[> <Plug>(quit)
  endfunction

  let g:automatic_enable_autocmd_Futures = {}
  let g:automatic_default_match_config = {
        \   'is_open_other_window': 1
        \ }
  let g:automatic_default_set_config = {
        \   'height': '40%',
        \   'move': "bottom",
        \   'apply': function('s:my_temporary_window_init')
        \ }
  let g:automatic_config = [
        \   {'match': {'buftype': 'help'}},
        \   {'match': {'bufname': '^.vimshell'}},
        \   {'match': {'bufname': 'MacDict.*'}},
        \   {
        \     'match': {
        \       'autocmd_history_pattern' : 'BufWinEnterFileType$',
        \       'filetype' : 'unite'
        \     },
        \     'set': {
        \       'unsettings': ['move', 'resize']
        \     }
        \   },
        \   {
        \     'match': {
        \       'filetype': 'qf',
        \       'autocmds': ['FileType']
        \     },
        \     'set': {
        \       'height': 8
        \     }
        \   },
        \   {
        \     'match': {
        \       'filetype': '\v^ref-.+',
        \       'autocmds': ['FileType']
        \     }
        \   },
        \   {
        \     'match': {
        \       'bufname': '\[quickrun output\]'
        \     },
        \     'set': {
        \       'height': 8
        \     }
        \   },
        \   {
        \     'match': {
        \       'autocmds': ['CmdwinEnter']
        \     },
        \     'set': {
        \       'is_close_focus_out': 1,
        \       'unsettings': ['move', 'resize']
        \     }
        \   }
        \ ]

  call neobundle#untap()
endif
"}}}

if neobundle#tap('vim-go')"{{{

  let g:go_auto_type_info = 1
  let g:go_snippet_engine = "neosnippet"
  " let g:go_play_open_browser = 0
  " let g:go_fmt_fail_silently = 0
  " let g:go_fmt_autosave = 0
  " let g:go_fmt_command = "gofmt"
  " let g:go_disable_autoinstall = 1

  au MyAutoCmd FileType go call s:my_golang_settings()

  function! s:my_golang_settings()
    nmap <buffer> <Leader>gd <Plug>(go-doc)
    nmap <buffer> <Leader>gs <Plug>(go-doc-split)
    nmap <buffer> <Leader>gv <Plug>(go-doc-vertical)
    nmap <buffer> <Leader>gb <Plug>(go-doc-browser)

    " nmap <buffer> <leader>r <Plug>(go-run)
    nmap <buffer> <leader>gb <Plug>(go-build)
    nmap <buffer> <leader>gt <Plug>(go-test)
    nmap <buffer> <leader>gc <Plug>(go-coverage)

    nmap <buffer> <Leader>ds <Plug>(go-def-split)
    nmap <buffer> <Leader>dv <Plug>(go-def-vertical)
    nmap <buffer> <Leader>dt <Plug>(go-def-tab)

    nnoremap <buffer> <Leader>gi :<C-u>GoImport<Space>

    autocmd MyAutoCmd FileType go :highlight goErr cterm=bold ctermfg=214
    autocmd MyAutoCmd FileType go :match goErr /\<err\>/

    setl completeopt=menu,preview
  endfunction

  call neobundle#untap()
endif
"}}}

if neobundle#tap('ghcmod-vim')"{{{
  function! neobundle#hooks.on_source(bundle)
    au MyAutoCmd BufWritePost <buffer> GhcModCheckAsync
  endfunction

  call neobundle#untap()
endif
"}}}

if neobundle#tap('neco-ghc')"{{{
  let g:necoghc_enable_detailed_browse = 1

  call neobundle#untap()
endif
"}}}

if neobundle#tap('yankround.vim')"{{{
  nmap p <Plug>(yankround-p)
  nmap P <Plug>(yankround-P)
  nmap <C-p> <Plug>(yankround-prev)
  nmap <C-n> <Plug>(yankround-next)
  let g:yankround_max_history = 100

  nnoremap <silent>g<C-p> :<C-u>CtrlPYankRound<CR>
  call neobundle#untap()
endif
"}}}

if neobundle#tap('vim-over')"{{{

  nnoremap <silent> <Leader>o :<C-u>OverCommandLine<CR>%s/
  call neobundle#untap()
endif
"}}}

if neobundle#tap('foldCC')"{{{
  set foldmethod=marker
  set foldtext=FoldCCtext()
  set foldcolumn=0
  set fillchars=vert:\|
  nnoremap <expr>l  foldclosed('.') != -1 ? 'zo' : 'l'
  nnoremap <silent><C-_> :<C-u>call <SID>smart_foldcloser()<CR>
  function! s:smart_foldcloser() "{{{
    if foldlevel('.') == 0
      norm! zM
      return
    endif

    let foldc_lnum = foldclosed('.')
    norm! zc
    if foldc_lnum == -1
      return
    endif

    if foldclosed('.') != foldc_lnum
      return
    endif
    norm! zM
  endfunction
  "}}}
  nnoremap  z[   :<C-u>call <SID>put_foldmarker(0)<CR>
  nnoremap  z]   :<C-u>call <SID>put_foldmarker(1)<CR>
  function! s:put_foldmarker(foldclose_p) "{{{
    let crrstr = getline('.')
    let padding = crrstr=='' ? '' : crrstr=~'\s$' ? '' : ' '
    let [cms_start, cms_end] = ['', '']
    let outside_a_comment_p = synIDattr(synID(line('.'), col('$')-1, 1), 'name') !~? 'comment'
    if outside_a_comment_p
      let cms_start = matchstr(&cms,'\V\s\*\zs\.\+\ze%s')
      let cms_end = matchstr(&cms,'\V%s\zs\.\+')
    endif
    let fmr = split(&fmr, ',')[a:foldclose_p]. (v:count ? v:count : '')
    exe 'norm! A'. padding. cms_start. fmr. cms_end
  endfunction
  "}}}
  nnoremap <silent>z<C-_>  zMzvzc
  nnoremap <silent>z0  :<C-u>set foldlevel=<C-r>=foldlevel('.')<CR><CR>

  call neobundle#untap()
endif
"}}}

if neobundle#tap('vim-ps1')"{{{
  function! neobundle#hooks.on_source(bundle)
    function! s:addHeaderPs1(flg)
      let list = []
      if ! a:flg
        call add(list, "@powershell -NoProfile -ExecutionPolicy Unrestricted \"$s=[scriptblock]::create((gc \\\"%~f0\\\"|?{$_.readcount -gt 1})-join\\\"`n\\\");&$s\" %*&@goto :eof\r")
      else
        call add(list, "@powershell -NoProfile -ExecutionPolicy Unrestricted \"$s=[scriptblock]::create((gc \\\"%~f0\\\"|?{$_.readcount -gt 1})-join\\\"`n\\\");&$s\" %*&@goto :eof&@pause\r")
      endif
      call extend(list, readfile(expand("%"), "b"))
      let s:basedir = expand("%:p:h") . "/cmd/"
      call Mkdir(s:basedir)
      call writefile(list,  s:basedir . expand("%:p:t:r") . ".cmd", "b")
    endfunction
    au MyAutoCmd BufWritePost *.ps1 call s:addHeaderPs1(0)
    au MyAutoCmd FileType ps1 nnoremap <buffer> <expr><Leader>m <SID>addHeaderPs1(1)
  endfunction

  call neobundle#untap()
endif
"}}}

if neobundle#tap('vim-splash')"{{{
  " clone splash gist "{{{
  function! s:clone_splash()
    let s:splash_dir = $HOME . "/.vim-splash"
    if !isdirectory(s:splash_dir)
      echom "cloning vim splash ..."
      let s:com = "git clone https://gist.github.com/7630711.git " . s:splash_dir
      echom s:com
      call system(s:com)
    endif
  endfunction
  "}}}
  call s:clone_splash()

  let g:splash#path = s:splash_dir . '/vim_intro.txt'

  call neobundle#untap()
endif
"}}}

if neobundle#tap('vim-quickhl')"{{{
  nmap [Space]m <Plug>(quickhl-manual-this)
  xmap [Space]m <Plug>(quickhl-manual-this)
  "nmap <F9>   <Plug>(quickhl-manual-toggle)
  "xmap <F9>   <Plug>(quickhl-manual-toggle)

  nmap [Space]M <Plug>(quickhl-manual-reset)
  xmap [Space]M <Plug>(quickhl-manual-reset)

  nmap [Space]j <Plug>(quickhl-cword-toggle)
  nmap [Space]] <Plug>(quickhl-tag-toggle)

  "map H <Plug>(operator-quickhl-manual-this-motion)

  call neobundle#untap()
endif
"}}}

if neobundle#tap('vim-visualstar')"{{{
  map * <Plug>(visualstar-*)
  map # <Plug>(visualstar-#)

  call neobundle#untap()
endif
"}}}

if neobundle#tap('vim-javascript')"{{{
  function! neobundle#hooks.on_source(bundle)
    function! s:addHeaderJavascript(flg)
      if &fileencoding == 'cp932'
        let list = []
        call add(list, "@set @junk=1 /*\r")
        if ! a:flg
          call add(list, "@cscript //nologo //e:jscript \"%~f0\" %* & @ping -n 10 localhost > nul & @goto :eof\r")
        else
          call add(list, "@cscript //nologo //e:jscript \"%~f0\" %* & @ping -n 10 localhost > nul & @goto :eof&@pause\r")
        endif
        call add(list, "*/\r")
        call extend(list, readfile(expand("%"), "b"))
        let s:basedir = expand("%:p:h") . "/cmd/"
        call Mkdir(s:basedir)
        call writefile(list,  s:basedir . expand("%:p:t:r") . ".cmd", "b")
      endif
    endfunction
    au MyAutoCmd BufWritePost *.js call s:addHeaderJavascript(0)
    au MyAutoCmd FileType javascript nnoremap <buffer> <expr><Leader>m <SID>addHeaderJavascript(1)
  endfunction

  call neobundle#untap()
endif
"}}}

if neobundle#tap('calendar.vim')"{{{

  let g:calendar_google_calendar = 1
  let g:calendar_google_task = 1
  nnoremap [Space]c :<C-u>Calendar<CR>

  call neobundle#untap()
endif
"}}}

if neobundle#tap('vim-choosewin')"{{{
  nmap - <Plug>(choosewin)

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

  let g:choosewin_blink_on_land    = 0
  let g:choosewin_statusline_replace = 0
  let g:choosewin_tabline_replace  = 0

  call neobundle#untap()
endif
"}}}

if neobundle#tap('indentLine')"{{{

  let g:indentLine_faster = 1
  let g:indentLine_fileTypeExclude = ['help', 'nerdtree', 'calendar', 'thumbnail']
  " let g:indentLine_char = '┊'

  call neobundle#untap()
endif
"}}}

if neobundle#tap('vimplenote-vim')"{{{
  nnoremap <Leader>vl :<C-u>VimpleNote -l<CR>
  nnoremap <Leader>vn :<C-u>VimpleNote -n<CR>

  call neobundle#untap()
endif
"}}}

if neobundle#tap('neomru.vim')"{{{
  let g:neomru#file_mru_limit = 5000

  call neobundle#untap()
endif
"}}}

if neobundle#tap('rainbow_parentheses.vim')"{{{
  let g:rbpt_colorpairs = [
        \ ['brown',       'RoyalBlue3'],
        \ ['Darkblue',    'SeaGreen3'],
        \ ['darkgray',    'DarkOrchid3'],
        \ ['darkgreen',   'firebrick3'],
        \ ['darkcyan',    'RoyalBlue3'],
        \ ['darkred',     'SeaGreen3'],
        \ ['darkmagenta', 'DarkOrchid3'],
        \ ['brown',       'firebrick3'],
        \ ['gray',        'RoyalBlue3'],
        \ ['black',       'SeaGreen3'],
        \ ['darkmagenta', 'DarkOrchid3'],
        \ ['Darkblue',    'firebrick3'],
        \ ['darkgreen',   'RoyalBlue3'],
        \ ['darkcyan',    'SeaGreen3'],
        \ ['darkred',     'DarkOrchid3'],
        \ ['red',         'firebrick3']
        \ ]

  au MyAutoCmd VimEnter * RainbowParenthesesToggle
  au MyAutoCmd Syntax * RainbowParenthesesLoadRound
  au MyAutoCmd Syntax * RainbowParenthesesLoadSquare
  au MyAutoCmd Syntax * RainbowParenthesesLoadBraces

  call neobundle#untap()
endif
"}}}

if neobundle#tap('vim-easymotion')"{{{
  " Disable default mappings
  let g:EasyMotion_do_mapping = 0
  let g:EasyMotion_use_migemo = 1

  " `JK` Motions: Extend line motions
  map <Leader>j <Plug>(easymotion-j)
  map <Leader>k <Plug>(easymotion-k)
  " keep cursor column with `JK` motions
  let g:EasyMotion_startofline = 0
  " Turn on case sensitive feature
  let g:EasyMotion_smartcase = 1


  "let g:EasyMotion_keys = ';HKLYUIOPNM,QWERTASDGZXCVBJF'

  " Show target key with upper case to improve readability
  let g:EasyMotion_use_upper = 1
  " Jump to first match with enter & space
  let g:EasyMotion_enter_jump_first = 1
  let g:EasyMotion_space_jump_first = 1

  nmap [Space]s <Plug>(easymotion-s2)

  " map f <Plug>(easymotion-fl)
  " map t <Plug>(easymotion-tl)
  " map F <Plug>(easymotion-Fl)
  " map T <Plug>(easymotion-Tl)

  call neobundle#untap()
endif
"}}}

if neobundle#tap('tern_for_vim')"{{{

  au MyAutoCmd FileType coffee call tern#Enable()
  au MyAutoCmd FileType coffee setlocal omnifunc=tern#Complete

  call neobundle#untap()
endif
"}}}

if neobundle#tap('memolist.vim')"{{{
  if isdirectory($HOME . '/Dropbox')
    let g:memolist_path = $HOME . '/Dropbox/memolist'
  else
    let g:memolist_path = $HOME . '/.memolist'
  endif

  call Mkdir(g:memolist_path)

  "let g:memolist_vimfiler = 1
  let g:memolist_unite = 1
  let g:memolist_unite_source = "file_rec"

  " mappings
  nnoremap <Leader>mn :<C-u>MemoNew<CR>
  nnoremap <Leader>ml :<C-u>MemoList<CR>
  nnoremap <Leader>mg :<C-u>MemoGrep<CR>

  call neobundle#untap()
endif
"}}}

if neobundle#tap('ZoomWin')"{{{
  nmap so <Plug>ZoomWin

  call neobundle#untap()
endif
"}}}

if neobundle#tap('lingr-vim')"{{{
  let g:lingr_vim_user = 'yukimemi'

  call neobundle#untap()
endif
"}}}

if neobundle#tap('caw.vim')"{{{
  nmap <Leader>c <Plug>(caw:I:toggle)
  vmap <Leader>c <Plug>(caw:I:toggle)

  call neobundle#untap()
endif
"}}}

if neobundle#tap('unite-haddock')"{{{

  au MyAutoCmd FileType haskell call s:my_haskell_mappings()
  function! s:my_haskell_mappings()
    nnoremap <buffer> K :<C-u>UniteWithCursorWord hoogle<CR>
    nnoremap <buffer> [Space]h :<C-u>Unite hoogle<CR>
  endfunction

  call neobundle#untap()
endif
"}}}

if neobundle#tap('vim-gista')"{{{
  let g:gista#github_user = 'yukimemi'

  call neobundle#untap()
endif
"}}}

if neobundle#tap('vim-jplus') "{{{
  nmap J <Plug>(jplus)
  vmap J <Plug>(jplus)

  call neobundle#untap()
endif "}}}

if neobundle#tap('vim-watchdogs')"{{{
  call neobundle#config({
        \ 'autoload': {
        \   'commands': ['WatchdogsRunSweep', {'complete': 'customlist,quickrun#complete', 'name': 'WatchdogsRun'},
        \                {'complete': 'customlist,quickrun#complete', 'name': 'WatchdogsRunSilent'}]
        \ }
        \ })

  if !exists('g:watchdogs_config')
    let g:watchdogs_config = {}
  endif
  let g:watchdogs_config = {
        \ "watchdogs_checker/_": {
        \   "hook/qfsigns_update/enable_exit": 1,
        \   "hook/qfsigns_update/priority_exit": 3
        \ },
        \
        \ "cpp/wandbox": {
        \   "runner": "wandbox",
        \   "runner/wandbox/compiler": "clang-head",
        \   "runner/wandbox/options": "warning,c++1y,boost-1.55"
        \ },
        \
        \ "cpp/g++": {
        \   "cmdopt": "-std=c++0x -Wall"
        \ },
        \
        \ "cpp/clang++": {
        \   "cmdopt": "-std=c++0x -Wall"
        \ },
        \
        \ "cpp/watchdogs_checker": {
        \   "type": "watchdogs_checker/clang++"
        \ },
        \
        \ "watchdogs_checker/g++": {
        \   "cmdopt": "-Wall"
        \ },
        \
        \ "watchdogs_checker/clang++": {
        \   "cmdopt": "-Wall"
        \ },
        \ "xml/watchdogs_checker": {
        \   "type": "watchdogs_checker/xmllint"
        \ },
        \ "watchdogs_checker/xmllint": {
        \   "command": "xmllint",
        \   "exec": "%c %o %s",
        \   "cmdopt": "--recover"
        \ }
        \ }
  call extend(g:quickrun_config, g:watchdogs_config)
  call watchdogs#setup(g:quickrun_config)

  " auto check at save
  let g:watchdogs_check_BufWritePost_enable = 1

  let g:watchdogs_check_BufWritePost_enables = {
        \ "javascript": 0,
        \ "xml": 1
        \ }

  cal neobundle#untap()
endif
"}}}

if neobundle#tap('CamelCaseMotion')"{{{
  nmap <silent> W <Plug>CamelCaseMotion_w
  xmap <silent> W <Plug>CamelCaseMotion_w
  omap <silent> W <Plug>CamelCaseMotion_w
  nmap <silent> B <Plug>CamelCaseMotion_b
  xmap <silent> B <Plug>CamelCaseMotion_b
  omap <silent> B <Plug>CamelCaseMotion_b

  call neobundle#untap()
endif
"}}}

if neobundle#tap('vim-jade')"{{{
  call neobundle#config({
        \ 'autoload': {
        \   'filetypes': 'jade'
        \ }
        \ })

  call neobundle#untap()
endif
"}}}

if neobundle#tap('vim-stylus')"{{{
  call neobundle#config({
        \ 'autoload': {
        \   'filetypes': 'stylus'
        \ }
        \ })

  call neobundle#untap()
endif
"}}}

if neobundle#tap('unite-quickfix')"{{{
  call neobundle#config({
        \ 'autoload': {
        \   'unite_sources': ['location_list', 'quickfix']
        \ }
        \ })

  call neobundle#untap()
endif
"}}}

if neobundle#tap('J6uil.vim')"{{{
  call neobundle#config({
        \ 'autoload': {
        \   'unite_sources': ['J6uil_members', 'J6uil_rooms'],
        \   'mappings': [['n', '<Plug>(J6uil_']],
        \   'commands': ['J6uilReconnect', 'J6uilNextRoom', 'J6uilPrevRoom', 'J6uilDisconnect',
        \                {'complete': 'custom,J6uil#complete#room', 'name': 'J6uil'}]
        \ }
        \ })

  let g:J6uil_user = 'yukimemi'
  let g:J6uil_multi_window = 1

  call neobundle#untap()
endif
"}}}

if neobundle#tap('clever-f.vim')"{{{
  map f <Plug>(clever-f-f)
  map F <Plug>(clever-f-F)
  map t <Plug>(clever-f-t)
  map T <Plug>(clever-f-T)

  let g:clever_f_smart_case = 1
  let g:clever_f_use_migemo = 1

  call neobundle#untap()
endif
"}}}

if neobundle#tap('quickfixstatus')"{{{
  call neobundle#config({
        \ 'autoload': {
        \   'commands': ['QuickfixStatusDisable', 'QuickfixStatusEnable']
        \ }
        \ })

  function! neobundle#hooks.on_source(bundle)
    QuickfixStatusEnable
  endfunction

  call neobundle#untap()
endif
"}}}

if neobundle#tap('vim-marching')"{{{

  function! neobundle#hooks.on_source(bundle)
    let g:marching_clang_command = "clang"

    if !empty(g:marching_clang_command) && executable(g:marching_clang_command)
      " Sync
      " let g:marching_backend = "sync_clang_command"
    else
      " Not executable clang, use wandbox
      let g:marching_backend = "wandbox"
      let g:marching_clang_command = ""
    endif

    " Option settings
    let g:marching#clang_command#options = {
          \ "cpp" : "-std=gnu++1y"
          \}

    " Use neocomplete
    let g:marching_enable_neocomplete = 1

    if !exists('g:neocomplete#force_omni_input_patterns')
      let g:neocomplete#force_omni_input_patterns = {}
    endif

    let g:neocomplete#force_omni_input_patterns.cpp =
          \ '[^.[:digit:] *\t]\%(\.\|->\)\w*\|\h\w*::\w*'
  endfunction

  call neobundle#untap()
endif
"}}}

if neobundle#tap('typescript-tools')"{{{

  au MyAutoCmd BufNewFile,BufRead *.ts call s:my_typescript_settings()

  function! s:my_typescript_settings()
    setl omnifunc=TSScompleteFunc
    TSSstarthere
  endfunction

  call neobundle#untap()
endif
"}}}

if neobundle#tap('typescript-vim')"{{{
  let g:typescript_indent_disable = 1

  call neobundle#untap()
endif
"}}}

if neobundle#tap('incsearch.vim')"{{{
  call neobundle#config({
        \ 'autoload': {
        \   'mappings': [['sxno', '<Plug>(_incsearch-N)'], ['sxno', '<Plug>(incsearch-nohl-N)'],
        \                ['sxno', '<Plug>(_incsearch-#)'], ['sxno', '<Plug>(_incsearch-*)'],
        \                ['sxno', '<Plug>(incsearch-nohl-#)'], ['sxno', '<Plug>(incsearch-forward)'],
        \                ['sxno', '<Plug>(incsearch-nohl-*)'], ['sxno', '<Plug>(incsearch-stay)'],
        \                ['sxno', '<Plug>(incsearch-nohl)'], ['sxno', '<Plug>(_incsearch-n)'],
        \                ['sxno', '<Plug>(incsearch-nohl-n)'], ['sxno', '<Plug>(_incsearch-g*)'],
        \                ['sxno', '<Plug>(_incsearch-g#)'], ['sxno', '<Plug>(incsearch-backward)'],
        \                ['sxno', '<Plug>(incsearch-nohl-g#)'], ['sxno', '<Plug>(incsearch-nohl-g*)']],
        \   'commands': ['IncSearchNoreMap', 'IncSearchMap']
        \ }
        \ })

  map /  <Plug>(incsearch-forward)
  map ?  <Plug>(incsearch-backward)
  map g/ <Plug>(incsearch-stay)

  " set hlsearch
  " let g:incsearch#auto_nohlsearch = 1
  nmap n  <Plug>(anzu-jump-n)zv
  nmap N  <Plug>(anzu-jump-N)zv
  nmap *  <Plug>(anzu-jump-star)zv
  nmap #  <Plug>(anzu-jump-sharp)zv

  call neobundle#untap()
endif
"}}}

if neobundle#tap('vim-showmarks')"{{{
  call neobundle#config({
        \ 'autoload': {
        \   'commands': ['ShowMarksOnce', 'NoShowMarks', 'DoShowMarks', 'PreviewMarks']
        \ }
        \ })

  let g:showmarks_marks_notime = 1
  let g:unite_source_mark_marks = '01abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLNMOPQRSTUVWXYZ'
  let g:showmarks_enable = 0
  if !exists('g:markrement_char')
    let g:markrement_char = [
          \     'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M',
          \     'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z',
          \     'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm',
          \     'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z'
          \ ]
  en

  fu! s:AutoMarkrement()
    if !exists('b:markrement_pos')
      let b:markrement_pos = 0
    else
      let b:markrement_pos = (b:markrement_pos + 1) % len(g:markrement_char)
    en
    exe 'mark' g:markrement_char[b:markrement_pos]
    echo 'marked' g:markrement_char[b:markrement_pos]
  endf

  au MyAutoCmd BufReadPost * sil! ShowMarksOnce

  nn [Mark] <Nop>
  nm sm [Mark]
  nn sum :<C-u>Unite mark<CR>
  nn [Mark] :<C-u>call <SID>AutoMarkrement()<CR><CR>:ShowMarksOnce<CR>
  com! -bar MarksDelete sil :delm! | :delm 0-9A-Z | :wv! | :ShowMarksOnce
  nn <silent>[Mark]d :MarksDelete<CR>

  call neobundle#untap()
endif
"}}}

if neobundle#tap('rsense')"{{{
  call neobundle#config({
        \ 'autoload': {
        \   'filetypes': ['ruby']
        \ }
        \ })

  let g:rsenseUseOmniFunc = 1

  call neobundle#untap()
endif
"}}}

if neobundle#tap('neocomplete-rsense.vim')"{{{
  call neobundle#config({
        \ 'autoload': {
        \   'filetypes': ['ruby']
        \ }
        \ })

  call neobundle#untap()
endif
"}}}

if neobundle#tap('vim-qfsigns')"{{{

  " If syntax error, cursor is moved at line setting sign.
  let g:qfsigns#AutoJump = 1
  " If syntax error, view split and cursor is moved at line setting sign.
  " let g:qfsigns#AutoJump = 2

  call neobundle#untap()
endif
"}}}

if neobundle#tap('vim-ref-ri')"{{{
  call neobundle#config({
        \ 'autoload': {
        \   'unite_sources': ['ref/ri']
        \ }
        \ })

  call neobundle#untap()
endif
"}}}

if neobundle#tap('vim-itunes-bgm')"{{{
  call neobundle#config({
        \ 'autoload': {
        \   'commands': ['ITunesBGMStart', 'ITunesBGMStop', 'ITunesBGMNext'],
        \   'unite_sources': ['itunesbgm']
        \ }
        \ })

  call neobundle#untap()
endif
"}}}

if neobundle#tap('im_control.vim')"{{{
  " Use fcitx
  let IM_CtrlMode = 6
  inoremap <silent> <C-j> <C-r>=IMState('FixMode')<CR>
  set timeout timeoutlen=3000 ttimeoutlen=50
endif
"}}}

if neobundle#tap('tsuquyomi')"{{{
  call neobundle#config({
        \ 'autoload': {
        \   'commands': ['TsuquyomiReloadProject', 'TsuquyomiStartServer', 'TsuquyomiStatusServer',
        \                'TsuquyomiStopServer'],
        \   'filetypes': ['typescript']
        \ }
        \ })

  call neobundle#untap()
endif
"}}}

if neobundle#tap('qfixhowm')"{{{
  call neobundle#config({
        \ 'autoload': {
        \   'function_prefix': ['qfixmemo']
        \ }
        \ })

  nnoremap g,l :<C-U>call qfixmemo#ListRecent()<CR>
  nnoremap g,c :<C-U>call qfixmemo#EditNew()<CR>
  " use markdown
  " let howm_filename = '%Y/%m/%Y-%m-%d-%H%M%S.md'
  " filetype markdown
  " let QFixHowm_FileType = 'markdown'
  " let QFixHowm_Title = '#'
  " let QFixMRU_Title = {}
  " let QFixMRU_Title['md'] = '^###[^#]'
  " let QFixMRU_Title['md_regxp'] = '^###[^#]'
  if isdirectory($HOME . '/Dropbox')
    let howm_dir = $HOME . '/Dropbox/.howm'
  else
    let howm_dir = $HOME . '/.howm'
  endif
  call neobundle#untap()
endif"}}}

if neobundle#tap('qfixgrep')"{{{
  call neobundle#config({
        \ 'autoload': {
        \   'on_source': ['qfixhowm']
        \ }
        \ })
  call neobundle#untap()
endif
"}}}

if neobundle#tap('vim-reanimate')"{{{
  let g:reanimate_save_dir = "~/.vim/save"
  let g:reanimate_default_category = "default"
  let g:reanimate_default_save_name = "latest"
  let g:reanimate_sessionoptions = "curdir,folds,globals,help,localoptions,slash,tabpages,winsize"

  if !has("gui_running")
    let g:reanimate_disables = ["reanimate_window"]
  endif

  " Disable confirm
  let g:reanimate_event_disables = {
        \ "_" : {
        \   "reanimate_confirm" : 1
        \ }
        \ }

  au MyAutoCmd VimLeavePre * ReanimateSave
  if has('vim_starting') && expand("%") == ""
    au MyAutoCmd VimEnter * ReanimateLoad
  endif

  call neobundle#untap()
endif
"}}}

if neobundle#tap('vim-unite-history')"{{{
  call neobundle#config({
        \ 'autoload': {
        \   'unite_sources': ['history']
        \ }
        \ })

  call neobundle#untap()
endif
"}}}

if neobundle#tap('xmledit')"{{{
  call neobundle#config({
        \ 'autoload': {
        \   'filetypes': ['xml']
        \ }
        \ })

  call neobundle#untap()
endif
"}}}

if neobundle#tap('vim-easy-align')"{{{
  vmap <Enter> <Plug>(EasyAlign)

  let g:easy_align_delimiters = {
        \ '>': {
        \       'pattern': '>>\|=>\|>.\+',
        \       'right_margin':  0,
        \       'delimiter_align': 'l'
        \   },
        \ '/': {
        \       'pattern':         '//\+\|/\*\|\*/',
        \       'delimiter_align': 'l',
        \       'ignore_groups':   ['!Comment'] },
        \ ']': {
        \       'pattern':       '[[\]]',
        \       'left_margin':   0,
        \       'right_margin':  0,
        \       'stick_to_left': 0
        \   },
        \ ')': {
        \       'pattern':       '[()]',
        \       'left_margin':   0,
        \       'right_margin':  0,
        \       'stick_to_left': 0
        \   },
        \ 'd': {
        \       'pattern':      ' \(\S\+\s*[;=]\)\@=',
        \       'left_margin':  0,
        \       'right_margin': 0
        \   },
        \ 'p': {
        \       'pattern':      'pos\|size',
        \       'filter':       'g'
        \   },
        \ 's': {
        \       'pattern':      'sys=\|Trns='
        \   }
        \ }

  call neobundle#untap()
endif
"}}}

if neobundle#tap('vinarise.vim')"{{{

  call neobundle#untap()
endif
"}}}

if neobundle#tap('try-colorscheme.vim')"{{{
  call neobundle#config({
        \ 'autoload': {
        \   'commands': ['TryColorscheme']
        \ }
        \ })

  call neobundle#untap()
endif
"}}}

if neobundle#tap('vim-external')"{{{
  map <Leader>e <Plug>(external-editor)
  map <Leader>n <Plug>(external-explorer)
  map <Leader>b <Plug>(external-browser)

  call neobundle#untap()
endif
"}}}

if neobundle#tap('winmove')"{{{
  " Use submode
  let g:wm_move_down  = ''
  let g:wm_move_up    = ''
  let g:wm_move_left  = ''
  let g:wm_move_right = ''

  call submode#enter_with('move-window', 'n', '', ',w', '<Nop>')
  call submode#leave_with('move-window', 'n', '', '<Esc>')
  call submode#map('move-window', 'n', 'r', 'j', '<Plug>(winmove-down)')
  call submode#map('move-window', 'n', 'r', 'k', '<Plug>(winmove-up)')
  call submode#map('move-window', 'n', 'r', 'h', '<Plug>(winmove-left)')
  call submode#map('move-window', 'n', 'r', 'l', '<Plug>(winmove-right)')

  call neobundle#untap()
endif
"}}}

if neobundle#tap('accelerated-jk')"{{{
  nmap j <Plug>(accelerated_jk_gj)
  nmap k <Plug>(accelerated_jk_gk)
endif
"}}}

if neobundle#tap('vim-niceblock') "{{{
  xmap I  <Plug>(niceblock-I)
  xmap A  <Plug>(niceblock-A)

  call neobundle#untap()
endif
"}}}

if neobundle#tap('vim-textobj-user')"{{{
  " vim-textobj-multiblock
  omap ab <Plug>(textobj-multiblock-a)
  omap ib <Plug>(textobj-multiblock-i)
  xmap ab <Plug>(textobj-multiblock-a)
  xmap ib <Plug>(textobj-multiblock-i)
  " vim-textobj-entire
  map ae <Plug>(textobj-entire-a)
  nunmap ae
  map ie <Plug>(textobj-entire-i)
  nunmap ie
  " vim-textobj-fold
  map az <Plug>(textobj-fold-a)
  nunmap az
  map iz <Plug>(textobj-fold-i)
  nunmap iz
  " vim-textobj-function
  map af <Plug>(textobj-function-a)
  nunmap af
  map if <Plug>(textobj-function-i)
  nunmap if
  map aF <Plug>(textobj-function-A)
  nunmap aF
  map iF <Plug>(textobj-function-I)
  nunmap iF
  " vim-textobj-indent
  map ai <Plug>(textobj-indent-a)
  nunmap ai
  map ii <Plug>(textobj-indent-i)
  nunmap ii
  map aI <Plug>(textobj-indent-same-a)
  nunmap aI
  map iI <Plug>(textobj-indent-same-i)
  nunmap iI
  " textobj-lastpaste
  map iP <Plug>(textobj-lastpaste-i)
  nunmap iP

  call neobundle#untap()
endif
"}}}

if neobundle#tap('vim-operator-user')"{{{
  " vim-operator-blockwise
  nmap YY <Plug>(operator-blockwise-yank-head)
  nmap DD <Plug>(operator-blockwise-delete-head)
  nmap CC <Plug>(operator-blockwise-change-head)
  " vim-operator-surround
  map sA <Plug>(operator-surround-append)
  map sD <Plug>(operator-surround-delete)
  map sR <Plug>(operator-surround-replace)
  " vim-clang-format
  nmap <Leader>x <Plug>(operator-clang-format)
  " vim-operator-trailingspace-killer
  nmap <Leader>k <Plug>(operator-trailingspace-killer)
  " vim-operator-replace
  map _ <Plug>(operator-replace)
  " vim-operator-search
  nmap [Space]/ <Plug>(operator-search)
  " operator-star.vim
  nmap <Leader>*  <Plug>(operator-*)
  nmap <Leader>g* <Plug>(operator-g*)
  nmap <Leader>#  <Plug>(operator-#)
  nmap <Leader>g# <Plug>(operator-g#)

  call neobundle#untap()
endif
"}}}

if neobundle#tap('auto-ctags.vim')"{{{
  let g:auto_ctags = 1
  let g:auto_ctags_tags_name = '.tags'

  call neobundle#untap()
endif
"}}}

if neobundle#tap('vim-better-whitespace')"{{{
  let g:better_whitespace_filetypes_blacklist=['unite', 'vimfiler', 'tweetvim']

  au MyAutoCmd BufWritePre *.coffee,*.js,*.ps1,*.md,*.jade,Vagrantfile,.vimrc,*.vim StripWhitespace

  call neobundle#untap()
endif
"}}}

" disable plugin
let plugin_dicwin_disable = 1

