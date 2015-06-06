if neobundle#tap('neobundle.vim')"{{{
  " mapping for NeoBundle
  nnoremap [Space]bi :<C-u>NeoBundleInstall<CR>

  call neobundle#untap()
endif
"}}}

if neobundle#tap('lightline.vim')"{{{
  if g:is_windows || g:is_cygwin
    let g:lightline = {
          \ 'colorscheme': 'solarized',
          \ 'mode_map': { 'c': 'NORMAL' },
          \ 'active': {
          \   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename', 'anzu' ] ]
          \ },
          \ 'component_function': {
          \   'modified': 'MyModified',
          \   'readonly': 'MyReadonly',
          \   'fugitive': 'MyFugitive',
          \   'filename': 'MyFilename',
          \   'fileformat': 'MyFileformat',
          \   'filetype': 'MyFiletype',
          \   'fileencoding': 'MyFileencoding',
          \   'mode': 'MyMode',
          \   'anzu': 'anzu#search_status'
          \ }
          \ }
  else
    let g:lightline = {
          \ 'colorscheme': 'solarized',
          \ 'mode_map': { 'c': 'NORMAL' },
          \ 'active': {
          \   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename', 'anzu' ] ]
          \ },
          \ 'component_function': {
          \   'modified': 'MyModified',
          \   'readonly': 'MyReadonly',
          \   'fugitive': 'MyFugitive',
          \   'filename': 'MyFilename',
          \   'fileformat': 'MyFileformat',
          \   'filetype': 'MyFiletype',
          \   'fileencoding': 'MyFileencoding',
          \   'mode': 'MyMode',
          \   'anzu': 'anzu#search_status'
          \ },
          \ 'separator': { 'left': '⮀', 'right': '⮂' },
          \ 'subseparator': { 'left': '⮁', 'right': '⮃' }
          \ }
  endif
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

  call neobundle#untap()
endif
"}}}

if neobundle#tap('neocomplete.vim')"{{{
  call neobundle#config({
        \ 'autoload': {
        \   'insert': 1
        \ }
        \ })
  let g:neocomplete#enable_at_startup = 1
  let g:neocomplete#enable_smart_case = 1
  let g:neocomplete#sources#syntax#min_keyword_length = 1
  let g:neocomplete#skip_auto_completion_time = 5
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

  call neobundle#untap()
endif
"}}}

if neobundle#tap('echodoc.vim')"{{{
  call neobundle#config({
        \ 'autoload': {
        \   'insert': 1
        \ }
        \ })

  let g:echodoc_enable_at_startup = 1

  call neobundle#untap()
endif
"}}}

if neobundle#tap('vim-gitgutter')"{{{
  call neobundle#config({
        \ 'autoload': {
        \   'mappings': [['n', '<Plug>GitGutter']],
        \   'commands': ['GitGutterToggle', 'GitGutterPrevHunk', 'GitGutter',
        \        'GitGutterLineHighlightsToggle', 'GitGutterRevertHunk',
        \        'GitGutterPreviewHunk', 'GitGutterSignsEnable', 'GitGutterNextHunk',
        \        'GitGutterDisable', 'GitGutterStageHunk', 'GitGutterEnable',
        \        'GitGutterSignsToggle', 'GitGutterAll', 'GitGutterLineHighlightsEnable',
        \        'GitGutterLineHighlightsDisable', 'GitGutterDebug', 'GitGutterSignsDisable']
        \ }
        \ })

  if ! g:is_windows
    let g:gitgutter_sign_added = '✚'
    let g:gitgutter_sign_modified = '➜'
    let g:gitgutter_sign_removed = '✘'
  endif

  nnoremap [Space]gg :<C-u>GitGutterToggle<CR>

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
  call neobundle#config({
        \ 'autoload': {
        \   'commands': ['TweetVimVersion',
        \        'TweetVimAddAccount',
        \        'TweetVimSwitchAccount',
        \        'TweetVimHomeTimeline',
        \        'TweetVimMentions',
        \        'TweetVimListStatuses',
        \        'TweetVimUserTimeline',
        \        'TweetVimSay',
        \        'TweetVimUserStream',
        \        'TweetVimCommandSay',
        \        'TweetVimCurrentLineSay',
        \        'TweetVimSearch'],
        \   'unite_sources': ['tweetvim/account', 'tweetvim']
        \ }
        \ })

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
  call neobundle#config({
        \ 'autoload': {
        \   'unite_sources': ['vimfiler_drive', 'vimfiler_execute', 'vimfiler_history',
        \           'vimfiler_mask', 'vimfiler_popd', 'vimfiler_sort'],
        \   'mappings': [['n', '<Plug>(vimfiler_']],
        \   'commands': [{'complete': 'customlist,vimfiler#complete', 'name': 'Read'},
        \        {'complete': 'customlist,vimfiler#complete', 'name': 'VimFiler'},
        \        {'complete': 'customlist,vimfiler#complete', 'name': 'Edit'},
        \        {'complete': 'customlist,vimfiler#complete', 'name': 'VimFilerExplorer'},
        \        {'complete': 'customlist,vimfiler#complete', 'name': 'VimFilerSplit'},
        \        {'complete': 'customlist,vimfiler#complete', 'name': 'Write'},
        \        {'complete': 'customlist,vimfiler#complete', 'name': 'VimFilerDouble'},
        \        {'complete': 'customlist,vimfiler#complete', 'name': 'Source'}]
        \ }
        \ })

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
  call neobundle#config({
        \ 'augroup': 'vimshell', 'autoload': {
        \   'unite_sources': ['vimshell_external_history', 'vimshell_history', 'vimshell_zsh_complete'],
        \   'mappings': [['n', '<Plug>(vimshell_']],
        \   'commands': [{'complete': 'customlist,vimshell#complete', 'name': 'VimShell'},
        \                {'complete': 'customlist,vimshell#complete', 'name': 'VimShellPop'},
        \                {'complete': 'customlist,vimshell#complete', 'name': 'VimShellCreate'},
        \                {'complete': 'customlist,vimshell#complete', 'name': 'VimShellCurrentDir'},
        \                {'complete': 'customlist,vimshell#helpers#vimshell_execute_complete', 'name': 'VimShellExecute'},
        \                {'complete': 'customlist,vimshell#complete', 'name': 'VimShellBufferDir'}, 'VimShellSendString',
        \                {'complete': 'customlist,vimshell#complete', 'name': 'VimShellTab'},
        \                {'complete': 'customlist,vimshell#helpers#vimshell_execute_complete', 'name': 'VimShellTerminal'},
        \                {'complete': 'customlist,vimshell#helpers#vimshell_execute_complete', 'name': 'VimShellInteractive'},
        \                {'complete': 'buffer', 'name': 'VimShellSendBuffer'}]
        \ }
        \ })

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

if neobundle#tap('vimshell-pure.vim')"{{{
  call neobundle#config({
        \ 'autoload': {
        \   'on_source': ['vimshell.vim']
        \ }
        \ })
  call neobundle#untap()
endif
"}}}

if neobundle#tap('neosnippet.vim')"{{{
  call neobundle#config({
        \ 'autoload': {
        \   'insert': 1,
        \   'unite_sources': ['neosnippet_file', 'snippet', 'snippet_target'],
        \   'mappings': [['sxi', '<Plug>(neosnippet_']],
        \   'commands': ['NeoSnippetEdit', 'NeoSnippetSource']
        \ }
        \ })

  " Plugin key-mappings.
  imap <C-k>   <Plug>(neosnippet_expand_or_jump)
  smap <C-k>   <Plug>(neosnippet_expand_or_jump)
  xmap <C-k>   <Plug>(neosnippet_expand_target)
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
  call neobundle#config({
        \ 'autoload': {
        \   'unite_sources': ['action', 'alias', 'bookmark', 'buffer', 'change', 'command',
        \           'directory', 'file', 'file_point', 'find', 'function', 'grep',
        \           'history_input', 'history_yank', 'jump', 'jump_point',
        \           'launcher', 'line', 'mapping', 'menu', 'mru', 'output',
        \           'process', 'rec', 'register', 'resume', 'runtimepath',
        \           'source', 'tab', 'undo', 'vimgrep', 'window'],
        \   'commands': [{'complete': 'customlist,unite#complete#source', 'name': 'UniteWithCurrentDir'},
        \        {'complete': 'customlist,unite#complete#source', 'name': 'Unite'},
        \        {'complete': 'customlist,unite#complete#source', 'name': 'UniteWithInputDirectory'},
        \        {'complete': 'customlist,unite#complete#buffer_name', 'name': 'UniteClose'},
        \        {'complete': 'file', 'name': 'UniteBookmarkAdd'},
        \        {'complete': 'customlist,unite#complete#buffer_name', 'name': 'UniteResume'},
        \        {'complete': 'customlist,unite#complete#source', 'name': 'UniteWithBufferDir'},
        \        {'complete': 'customlist,unite#complete#source', 'name': 'UniteWithCursorWord'},
        \        {'complete': 'customlist,unite#complete#source', 'name': 'UniteWithInput'},
        \        'UniteStartup']
        \ }
        \ })

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
	  let g:unite_source_grep_default_opts = '-i --exclude ''\.(git|svn|hg|bzr)'''
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
        \ 'vertical': 0,
        \ 'short_source_names': 0,
        \ 'direction': 'botright'
        \ }
  if ! g:is_windows
    call extend(s:unite_default_context, {
          \ 'prompt': '» ',
          \ 'marked_icon': '✗'
          \ })
  endif
  call unite#custom#profile('default', 'context', s:unite_default_context)

  function! neobundle#hooks.on_source(bundle)
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
  endfunction

  call neobundle#untap()
endif
"}}}

if neobundle#tap('unite-help')"{{{
  call neobundle#config({
        \ 'autoload': {
        \   'unite_sources': ['help']
        \ }
        \ })
  call neobundle#untap()
endif
"}}}

if neobundle#tap('unite-colorscheme')"{{{
  call neobundle#config({
        \ 'autoload': {
        \   'unite_sources': ['colorscheme']
        \ }
        \ })

  call neobundle#untap()
endif
"}}}

if neobundle#tap('open-browser.vim')"{{{
  call neobundle#config({
        \ 'autoload': {
        \   'mappings': [['sxn', '<Plug>(openbrowser-']],
        \   'commands': [{'complete': 'customlist,openbrowser#_cmd_complete', 'name': 'OpenBrowserSearch'},
        \        {'complete': 'customlist,openbrowser#_cmd_complete', 'name': 'OpenBrowserSmartSearch'},
        \        'OpenBrowser']
        \ }
        \ })

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
  call neobundle#config({
        \ 'autoload': {
        \   'mappings': [['sxn', '<Plug>(quickrun']],
        \   'commands': {'complete': 'customlist,quickrun#complete', 'name': 'QuickRun'}
        \ }
        \ })
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
        \     "cmdopt": "-jar plantuml.jar -tpng",
        \     "exec": "%c %o %s"
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

if neobundle#tap('shabadou.vim')"{{{
  call neobundle#config({
        \ 'autoload': {
        \   'on_source': ['vim-quickrun']
        \ }
        \ })
  call neobundle#untap()
endif
"}}}

if neobundle#tap('vim-coffee-script')"{{{
  call neobundle#config({
        \ 'autoload': {
        \   'filetypes': ['coffee'],
        \   'commands': ['CoffeeCompile', 'CoffeeWatch', 'CoffeeRun', 'CoffeeLint']
        \ }
        \ })

  let coffee_compile_vert = 1
  let coffee_make_options = '--bare'

  call neobundle#untap()
endif
"}}}

if neobundle#tap('jedi-vim')"{{{
  call neobundle#config({
        \ 'autoload': {
        \   'commands': [{'complete': 'custom,jedi#py_import_completions', 'name': 'Pyimport'},
        \        'Python'],
        \   'filetypes': ['python', 'python3']
        \ }
        \ })
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

if neobundle#tap('ag.vim')"{{{
  call neobundle#config({
        \ 'autoload': {
        \   'commands': [{'complete': 'file', 'name': 'AgFromSearch'},
        \        {'complete': 'help', 'name': 'LAgHelp'},
        \        {'complete': 'file', 'name': 'LAg'},
        \        {'complete': 'file', 'name': 'LAgAdd'},
        \        {'complete': 'file', 'name': 'AgFile'},
        \        {'complete': 'file', 'name': 'AgAdd'},
        \        {'complete': 'file', 'name': 'Ag'},
        \        {'complete': 'help', 'name': 'AgHelp'}],
        \   'unite_sources': 'grep'
        \ }
        \ })

  call neobundle#untap()
endif
"}}}

if neobundle#tap('vim-ref')"{{{
  call neobundle#config({
        \ 'autoload': {
        \   'unite_sources': ['ref'],
        \   'mappings': [['sxn', '<Plug>(ref-keyword)']],
        \   'commands': [{'complete': 'customlist,ref#complete', 'name': 'Ref'}, 'RefHistory']
        \ }
        \ })

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
  call neobundle#config({
        \ 'autoload': {
        \   'commands': ['CtrlPMixed', 'CtrlPClearAllCaches', 'CtrlPCurWD', 'CtrlP',
        \        'CtrlPRTS', 'CtrlPBuffer', 'CtrlPMRUFiles', 'CtrlPBookmarkDirAdd',
        \        'CtrlPDir', 'CtrlPRoot', 'CtrlPChange', 'ClearCtrlPCache',
        \        'CtrlPLine', 'ClearAllCtrlPCaches', 'CtrlPBufTagAll',
        \        'CtrlPClearCache', 'CtrlPQuickfix', 'CtrlPBufTag', 'CtrlPTag',
        \        'CtrlPCurFile', 'CtrlPLastMode', 'CtrlPUndo', 'CtrlPChangeAll',
        \        'CtrlPBookmarkDir']
        \ }
        \ })

  nnoremap [Space]p :<C-u>CtrlP<CR>
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
  call neobundle#config({
        \ 'autoload': {
        \   'mappings': [['n', '<Plug>(go-']],
        \   'commands': ['GoErrCheck', 'GoOracleCallgraph', 'GoRun', 'GoDeps', 'GoInstall',
        \                'GoDef', 'GoOracleDescribe', 'GoUpdateBinaries', 'GoVet', 'GoTest',
        \                'GoOracleCallers', 'GoOracleChannelPeers', 'GoOracleCallees', 'GoOracleImplements',
        \                {'complete': 'customlist,go#package#Complete', 'name': 'GoDoc'},
        \                'GoFiles', 'GoBuild', 'GoInstallBinaries'],
        \   'filetypes': 'go'
        \ }
        \ })

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

    setl completeopt=menu,preview
  endfunction

  call neobundle#untap()
endif
"}}}

if neobundle#tap('ghcmod-vim')"{{{
  call neobundle#config({
        \ 'autoload': {
        \   'filetypes': 'haskell'
        \ }
        \ })
  function! neobundle#hooks.on_source(bundle)
    "au MyAutoCmd BufWritePost <buffer> GhcModCheckAsync
  endfunction

  call neobundle#untap()
endif
"}}}

if neobundle#tap('neco-ghc')"{{{
  call neobundle#config({
        \ 'autoload': {
        \   'commands': ['NecoGhcDiagnostics'],
        \   'filetypes': 'haskell'
        \ }
        \ })

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
  call neobundle#config({
        \ 'autoload': {
        \   'commands': ['OverCommandLineNoremap', 'OverCommandLine']
        \ }
        \ })
  nnoremap <silent> <Leader>o :<C-u>OverCommandLine<CR>%s/
  call neobundle#untap()
endif
"}}}

if neobundle#tap('nebula.vim')"{{{
  call neobundle#config({
        \ 'autoload': {
        \   'commands': ['NebulaPutLazy', 'NebulaPutFromClipboard', 'NebulaYankOptions',
        \        'NebulaPutConfig', 'NebulaYankTap']
        \ }
        \ })
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

if neobundle#tap('junkfile.vim')"{{{
  call neobundle#config({
        \ 'autoload': {
        \   'unite_sources': ['junkfile'],
        \   'commands': ['JunkfileOpen']
        \ }
        \ })

  call neobundle#untap()
endif
"}}}

if neobundle#tap('plantuml-syntax')"{{{
  call neobundle#config({
        \ 'autoload': {
        \   'filetypes': 'plantuml'
        \ }
        \ })

  call neobundle#untap()
endif
"}}}

if neobundle#tap('chalice')"{{{
  call neobundle#config({
        \ 'autoload': {
        \   'commands': 'Chalice'
        \ }
        \ })

  call neobundle#untap()
endif
"}}}

if neobundle#tap('vim-ps1')"{{{
  call neobundle#config({
        \ 'autoload': {
        \   'filetypes': 'ps1'
        \ }
        \ })

  function! neobundle#hooks.on_source(bundle)
    function! s:addHeader(flg)
      let list = []
      call add(list, "@echo off\r")
      call add(list, "pushd \"%~dp0\" > nul\r")
      call add(list, "set tm=%time: =0%\r")
      call add(list, "set ps1file=%~n0___%date:~-10,4%%date:~-5,2%%date:~-2,2%_%tm:~0,2%%tm:~3,2%%tm:~6,2%%tm:~9,2%.ps1\r")
      " call add(list, "for /f \"usebackq skip=10 delims=\" %%i in (\"%~f0\") do @echo %%i >> \"%ps1file%\"\r")
      " call add(list, "more +10 \"%~f0\" | sort /+10000000 | sort /+10000000 /o \"%ps1file%\"\r")
      call add(list, "more +10 \"%~f0\" >> \"%ps1file%\"\r")
      call add(list, "powershell -NoProfile -ExecutionPolicy unrestricted -File \"%ps1file%\" %*\r")
      call add(list, "del \"%ps1file%\"\r")
      call add(list, "popd > nul\r")
      if ! a:flg
        call add(list, "pause\r")
      endif
      call add(list, "exit %ERRORLEVEL%\r")
      call add(list, "\# ========== do ps1 file as a dosbatch ==========\r")
      call extend(list, readfile(expand("%"), "b"))
      let cp932List = []
      call writefile(list, expand("%:p:r") . ".cmd", "b")
    endfunction
    au MyAutoCmd BufWritePost *.ps1 call s:addHeader(0)
    au MyAutoCmd FileType ps1 nnoremap <buffer> <expr><Leader>m <SID>addHeader(1)
  endfunction

  call neobundle#untap()
endif
"}}}

if neobundle#tap('vim-alignta')"{{{
  call neobundle#config({
        \ 'autoload': {
        \   'unite_sources': ['alignta'],
        \   'commands': [{'complete': 'customlist,s:complete_command_option', 'name': 'Alignta'},
        \        {'complete': 'customlist,s:complete_command_option', 'name': 'Align'}]
        \ }
        \ })

  call neobundle#untap()
endif
"}}}

if neobundle#tap('vim-splash')"{{{
  call neobundle#config({
        \ 'augroup': 'plugin',
        \   'autoload': {
        \   'commands': {'complete': 'file', 'name': 'Splash'}
        \ }
        \ })
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

if neobundle#tap('splitjoin.vim')"{{{
  call neobundle#config({
        \ 'autoload': {
        \   'mappings': [['n', '<Plug>Splitjoin']],
        \   'commands': ['SplitjoinSplit', 'SplitjoinJoin']
        \ }
        \ })
  nmap sJ :SplitjoinSplit<cr>
  nmap sK :SplitjoinJoin<cr>

  call neobundle#untap()
endif
"}}}

if neobundle#tap('linediff.vim')"{{{
  call neobundle#config({
        \ 'autoload': {
        \   'commands': ['LinediffReset', 'Linediff']
        \ }
        \ })

  call neobundle#untap()
endif
"}}}

if neobundle#tap('emmet-vim')"{{{
  call neobundle#config({
        \ 'autoload': {
        \   'commands': ['Emmet', 'EmmetInstall'],
        \   'filetypes': ['html']
        \ }
        \ })

  call neobundle#untap()
endif
"}}}

if neobundle#tap('vim-fireplace')"{{{
  call neobundle#config({
        \ 'autoload': {
        \   'mappings': [['<Plug>Fireplace']],
        \   'commands': [{'complete': 'customlist,fireplace#eval_complete', 'name': 'Eval'},
        \        'Last',
        \        {'complete': 'customlist,s:connect_complete', 'name': 'FireplaceConnect'},
        \        {'complete': 'customlist,fireplace#ns_complete', 'name': 'Require'}],
        \   'filetypes': 'clojure'
        \ }
        \ })

  call neobundle#untap()
endif
"}}}

if neobundle#tap('vim-ft-clojure')"{{{
  call neobundle#config({
        \ 'autoload': {
        \   'filetypes': 'clojure'
        \ }
        \ })

  call neobundle#untap()
endif
"}}}

if neobundle#tap('capture.vim')"{{{
  call neobundle#config({
        \ 'autoload': {
        \   'commands': [{'complete': 'command', 'name': 'Capture'}]
        \ }
        \ })

  call neobundle#untap()
endif
"}}}

if neobundle#tap('restart.vim')"{{{
  call neobundle#config({
        \ 'autoload': {
        \   'commands': 'Restart'
        \ }
        \ })

  command!
        \ -bar
        \ RestartWithSession
        \ let g:restart_sessionoptions = 'blank,curdir,folds,help,localoptions,tabpages'
        \ | Restart

  call neobundle#untap()
endif
"}}}

if neobundle#tap('vim-prettyprint')"{{{
  call neobundle#config({
        \ 'autoload': {
        \   'commands': [{'complete': 'expression', 'name': 'PP'},
        \        {'complete': 'expression', 'name': 'PrettyPrint'}]
        \ }
        \ })

  call neobundle#untap()
endif
"}}}

if neobundle#tap('vim-quickhl')"{{{
  call neobundle#config({
        \ 'augroup': 'QuickhlManual', 'autoload': {
        \   'mappings': [['sxn', '<Plug>(quickhl-']],
        \   'commands': ['QuickhlManualUnlockWindow', 'QuickhlManualDelete',
        \        'QuickhlTagToggle', 'QuickhlManualDisable', 'QuickhlTagDisable',
        \        'QuickhlManualAdd', 'QuickhlManualColors', 'QuickhlManualReset',
        \        'QuickhlManualLockToggle', 'QuickhlManualLock',
        \        'QuickhlManualEnable', 'QuickhlManualList', 'QuickhlCwordEnable',
        \        'QuickhlManualUnlock', 'QuickhlCwordDisable', 'QuickhlTagEnable',
        \        'QuickhlManualLockWindowToggle', 'QuickhlManualLockWindow',
        \        'QuickhlCwordToggle']
        \ }
        \ })

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
  call neobundle#config({
        \ 'autoload': {
        \   'mappings': '<Plug>(visualstar-'
        \ }
        \ })

  map * <Plug>(visualstar-*)
  map # <Plug>(visualstar-#)
  call neobundle#untap()
endif
"}}}

if neobundle#tap('vim-operator-search')"{{{
  call neobundle#config({
        \ 'autoload': {
        \   'mappings': '<Plug>(operator-search'
        \ }
        \ })
  nmap [Space]/ <Plug>(operator-search)

  call neobundle#untap()
endif
"}}}

if neobundle#tap('gitv')"{{{
  call neobundle#config({
        \ 'autoload': {
        \   'commands': ['Gitv']
        \ }
        \ })

  call neobundle#untap()
endif
"}}}

if neobundle#tap('simple-javascript-indenter')"{{{
  call neobundle#config({
        \ 'autoload': {
        \   'filetypes': 'javascript'
        \ }
        \ })

  call neobundle#untap()
endif
"}}}

if neobundle#tap('vim-javascript-syntax')"{{{
  call neobundle#config({
        \ 'autoload': {
        \   'filetypes': 'javascript'
        \ }
        \ })

  call neobundle#untap()
endif
"}}}

if neobundle#tap('vim-javascript')"{{{
  call neobundle#config({
        \ 'autoload': {
        \   'filetypes': 'javascript'
        \ }
        \ })

  call neobundle#untap()
endif
"}}}

if neobundle#tap('vim-vimperator')"{{{
  call neobundle#config({
        \ 'autoload': {
        \   'filetypes': 'vimperator'
        \ }
        \ })

  call neobundle#untap()
endif
"}}}

if neobundle#tap('calendar.vim')"{{{
  call neobundle#config({
        \ 'autoload': {
        \   'commands': [{'complete': 'customlist,calendar#argument#complete', 'name': 'Calendar'}]
        \ }
        \ })

  let g:calendar_google_calendar = 1
  let g:calendar_google_task = 1

  nnoremap [Space]c :<C-u>Calendar<CR>

  call neobundle#untap()
endif
"}}}

if neobundle#tap('thumbnail.vim')"{{{
  call neobundle#config({
        \ 'autoload': {
        \   'commands': [{'complete': 'customlist,thumbnail#complete', 'name': 'Thumbnail'}]
        \ }
        \ })

  call neobundle#untap()
endif
"}}}

if neobundle#tap('vim-choosewin')"{{{
  call neobundle#config({
        \ 'autoload': {
        \   'mappings': '<Plug>(choosewin)',
        \   'commands': ['FontReview', 'FontPerfSmall', 'ChooseWin', 'FontPerfLarge']
        \ }
        \ })

  nmap  -  <Plug>(choosewin)

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
  call neobundle#config({
        \ 'autoload': {
        \   'commands': ['VimpleNote']
        \ }
        \ })

  nnoremap <Leader>vl :<C-u>VimpleNote -l<CR>
  nnoremap <Leader>vn :<C-u>VimpleNote -n<CR>

  call neobundle#untap()
endif
"}}}

if neobundle#tap('unite-vim_advent-calendar')"{{{
  call neobundle#config({
        \ 'autoload': {
        \   'unite_sources': ['vim_advent_calendar']
        \ }
        \ })

  call neobundle#untap()
endif
"}}}

if neobundle#tap('unite-advent_calendar')"{{{
  call neobundle#config({
        \ 'autoload': {
        \   'unite_sources': ['advent_calendar']
        \ }
        \ })

  call neobundle#untap()
endif
"}}}

if neobundle#tap('codic-vim')"{{{
  call neobundle#config({
        \ 'autoload': {
        \   'commands': [{'complete': 'customlist,codic#complete', 'name': 'Codic'}]
        \ }
        \ })

  call neobundle#untap()
endif
"}}}

if neobundle#tap('unite-codic.vim')"{{{
  call neobundle#config({
        \ 'autoload': {
        \   'unite_sources': ['codic']
        \ }
        \ })

  call neobundle#untap()
endif
"}}}

if neobundle#tap('vim-ft-help_fold')"{{{
  call neobundle#config({
        \ 'autoload': {
        \   'filetypes': 'help'
        \ }
        \ })

  call neobundle#untap()
endif
"}}}

if neobundle#tap('neomru.vim')"{{{
  call neobundle#config({
        \ 'autoload': {
        \   'unite_sources': ['mru', 'neomru', 'neomru/file'],
        \   'commands': [{'complete': 'file', 'name': 'NeoMRUImportFile'},
        \          'NeoMRUSave',
        \          {'complete': 'file', 'name': 'NeoMRUImportDirectory'},
        \          'NeoMRUReload']
        \ }
        \ })

  let g:neomru#file_mru_limit = 5000

  call neobundle#untap()
endif
"}}}

if neobundle#tap('vim-clojure-static')"{{{
  call neobundle#config({
        \ 'autoload': {
        \   'filetypes': 'clojure'
        \ }
        \ })

  call neobundle#untap()
endif
"}}}

if neobundle#tap('rainbow_parentheses.vim')"{{{
  call neobundle#config({
        \ 'autoload': {
        \   'commands': ['RainbowParenthesesLoadChevrons', 'RainbowParenthesesActivate',
        \        'RainbowParenthesesToggleAll', 'RainbowParenthesesLoadRound',
        \        'RainbowParenthesesLoadSquare', 'RainbowParenthesesLoadBraces',
        \        'RainbowParenthesesToggle'],
        \   'filetypes': 'clojure'
        \ }
        \ })

  let g:rbpt_colorpairs = [
        \ ['brown',     'RoyalBlue3'],
        \ ['Darkblue',  'SeaGreen3'],
        \ ['darkgray',  'DarkOrchid3'],
        \ ['darkgreen',   'firebrick3'],
        \ ['darkcyan',  'RoyalBlue3'],
        \ ['darkred',   'SeaGreen3'],
        \ ['darkmagenta', 'DarkOrchid3'],
        \ ['brown',     'firebrick3'],
        \ ['gray',    'RoyalBlue3'],
        \ ['black',     'SeaGreen3'],
        \ ['darkmagenta', 'DarkOrchid3'],
        \ ['Darkblue',  'firebrick3'],
        \ ['darkgreen',   'RoyalBlue3'],
        \ ['darkcyan',  'SeaGreen3'],
        \ ['darkred',   'DarkOrchid3'],
        \ ['red',     'firebrick3']
        \ ]

  au MyAutoCmd VimEnter * RainbowParenthesesToggle
  au MyAutoCmd Syntax * RainbowParenthesesLoadRound
  au MyAutoCmd Syntax * RainbowParenthesesLoadSquare
  au MyAutoCmd Syntax * RainbowParenthesesLoadBraces

  call neobundle#untap()
endif
"}}}

if neobundle#tap('vim-tagsgen')"{{{
  call neobundle#config({
        \ 'autoload': {
        \   'commands': ['TagsgenSetDir', 'Tagsgen']
        \ }
        \ })

  let g:tagsgen_tags_command = {
        \ '_': 'ctags',
        \ 'go': 'gotags'
        \ }
  let g:tagsgen_option = {
        \ '_' : '-R',
        \ 'vim': '-R --languages=Vim',
        \ 'python': '-R --languages=Python',
        \ 'go': '{CURFILES} > tags'
        \ }

  au MyAutoCmd BufWinEnter *.{vim,go,python} TagsgenSetDir
  au MyAutoCmd BufWritePost *.{vim,go,python} Tagsgen

  call neobundle#untap()
endif
"}}}

if neobundle#tap('vim-visual-increment')"{{{
  call neobundle#config({
        \ 'autoload': {
        \   'mappings': [['sx', '<Plug>Visual']]
        \ }
        \ })

  call neobundle#untap()
endif
"}}}

if neobundle#tap('vim-easymotion')"{{{
  call neobundle#config({
        \ 'autoload': {
        \   'mappings': [['sxno', '<Plug>(easymotion-']],
        \   'commands': ['EMCommandLineNoreMap', 'EMCommandLineMap', 'EMCommandLineUnMap']
        \ }
        \ })

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

if neobundle#tap('vim-markdown')"{{{
  call neobundle#config({
        \ 'autoload': {
        \   'filetypes': 'markdown'
        \ }
        \ })

  call neobundle#untap()
endif
"}}}

if neobundle#tap('previm')"{{{
  call neobundle#config({
        \ 'autoload': {
        \   'commands': ['PrevimOpen']
        \ }
        \ })

  call neobundle#untap()
endif
"}}}

if neobundle#tap('vim-filetype-haskell')"{{{
  call neobundle#config({
        \ 'autoload': {
        \   'filetypes': 'haskell'
        \ }
        \ })

  call neobundle#untap()
endif
"}}}

if neobundle#tap('jazzradio.vim')"{{{
  call neobundle#config({
        \ 'autoload': {
        \   'unite_sources': ['jazzradio'],
        \   'commands': ['JazzradioUpdateChannels', 'JazzradioStop',
        \        {'complete': 'customlist,jazzradio#channel_key_complete', 'name': 'JazzradioPlay'}],
        \   'function_prefix': 'jazzradio'
        \ }
        \ })

  call neobundle#untap()

endif
"}}}

if neobundle#tap('tern_for_vim')"{{{
  call neobundle#config({
        \ 'autoload': {
        \   'commands': ['TernDocBrowse', 'TernType', 'TernRename', 'TernDefPreview',
        \        'TernDoc', 'TernDef', 'TernDefTab', 'TernDefSplit', 'TernRefs'],
        \   'filetypes': ['javascript', 'coffee']
        \ }
        \ })

  au MyAutoCmd FileType coffee call tern#Enable()
  au MyAutoCmd FileType coffee setlocal omnifunc=tern#Complete

  call neobundle#untap()
endif
"}}}

if neobundle#tap('memolist.vim')"{{{
  call neobundle#config({
        \ 'autoload': {
        \   'commands': ['MemoList', 'MemoGrep', 'MemoNew']
        \ }
        \ })

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
  call neobundle#config({
        \ 'autoload': {
        \   'mappings': [['n', '<Plug>ZoomWin']],
        \   'commands': ['ZoomWin']
        \ }
        \ })

  nmap so <Plug>ZoomWin

  call neobundle#untap()
endif
"}}}

if neobundle#tap('lingr-vim')"{{{
  call neobundle#config({
        \ 'autoload': {
        \   'mappings': [['sxno', '<Plug>(lingr-messages-quote)']],
        \   'commands': ['LingrLaunch', 'LingrExit']
        \ }
        \ })

  let g:lingr_vim_user = 'yukimemi'

  call neobundle#untap()
endif
"}}}

if neobundle#tap('googlesuggest-source.vim')"{{{
  call neobundle#config({
        \ 'autoload': {
        \   'insert': 1
        \ }
        \ })

  call neobundle#untap()
endif
"}}}

if neobundle#tap('vim-operator-blockwise')"{{{
  call neobundle#config({
        \ 'autoload': {
        \   'mappings': [['n', '<Plug>(operator-blockwise-']]
        \ }
        \ })

  " yank
  nmap YY <Plug>(operator-blockwise-yank-head)
  " delete
  nmap DD <Plug>(operator-blockwise-delete-head)
  " change
  nmap CC <Plug>(operator-blockwise-change-head)

  call neobundle#untap()
endif
"}}}

if neobundle#tap('caw.vim')"{{{

  nmap <Leader>c <Plug>(caw:I:toggle)
  vmap <Leader>c <Plug>(caw:I:toggle)

  call neobundle#untap()
endif
"}}}

if neobundle#tap('vim-operator-surround')"{{{
  call neobundle#config({
        \ 'autoload': {
        \   'mappings': [['nx', '<Plug>(operator-surround'],
        \                ['n', '<Plug>(operator-surround-repeat)']]
        \ }
        \ })

  " operator mappings
  map sA <Plug>(operator-surround-append)
  map sD <Plug>(operator-surround-delete)
  map sR <Plug>(operator-surround-replace)

  call neobundle#untap()
endif
"}}}

if neobundle#tap('unite-haddock')"{{{
  call neobundle#config({
        \ 'autoload': {
        \   'unite_sources': ['haddock', 'hoogle']
        \ }
        \ })

  au MyAutoCmd FileType haskell call s:my_haskell_mappings()

  function! s:my_haskell_mappings()
    nnoremap <buffer> K :<C-u>UniteWithCursorWord hoogle<CR>
    nnoremap <buffer> [Space]h :<C-u>Unite hoogle<CR>
  endfunction

  call neobundle#untap()
endif
"}}}

if neobundle#tap('vim-gista')"{{{
  call neobundle#config({
        \ 'autoload': {
        \   'unite_sources': ['g', 'gista'],
        \   'mappings': [['n', '<Plug>(gista-']],
        \   'commands': ['Gista']
        \ }
        \ })

  let g:gista#github_user = 'yukimemi'

  call neobundle#untap()
endif
"}}}

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
        \ }
        \ }
  call extend(g:quickrun_config, g:watchdogs_config)

  " auto check at save
  let g:watchdogs_check_BufWritePost_enable = 1

  let g:watchdogs_check_BufWritePost_enables = {
        \ "javascript": 0
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
  call neobundle#config({
        \ 'autoload': {
        \   'mappings': [['sxno', '<Plug>(clever-f-']]
        \ }
        \ })

  let g:clever_f_smart_case = 1
  let g:clever_f_use_migemo = 1

  call neobundle#untap()
endif
"}}}

if neobundle#tap('agit.vim')"{{{
  call neobundle#config({
        \ 'autoload': {
        \   'mappings': [['n', '<Plug>(agit-']],
        \   'commands': ['Agit']
        \ }
        \ })

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
  call neobundle#config({
        \ 'autoload': {
        \   'mappings': [['i', '<Plug>(marching_']],
        \   'commands': ['MarchingDisableDebug', 'MarchingDebugCheck', 'MarchingDebugClearLog',
        \                'MarchingBufferClearCache', 'MarchingEnableDebug', 'MarchingDebugLog'],
        \   'filetypes': 'cpp'
        \ }
        \ })

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
  call neobundle#config({
        \ 'autoload': {
        \   'filetypes': 'typescript'
        \ }
        \ })

  au MyAutoCmd BufNewFile,BufRead *.ts call s:my_typescript_settings()

  function! s:my_typescript_settings()
    setl omnifunc=TSScompleteFunc
    TSSstarthere
  endfunction

  call neobundle#untap()
endif
"}}}

if neobundle#tap('typescript-vim')"{{{
  call neobundle#config({
        \ 'autoload': {
        \   'filetypes': 'typescript'
        \ }
        \ })

  call neobundle#untap()
endif
"}}}

if neobundle#tap('vim-js-indent')"{{{
  call neobundle#config({
        \ 'autoload': {
        \   'filetypes': ['javascript', 'typescript']
        \ }
        \ })


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


endif
"}}}
" disable plugin
let plugin_dicwin_disable = 1

