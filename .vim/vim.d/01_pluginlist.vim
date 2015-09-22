" Use neobundle.vim
let $CACHE = expand('~/.cache')
if !isdirectory(expand($CACHE))
  call mkdir(expand($CACHE), 'p')
endif
let s:neobundle_dir = expand('$CACHE/neobundle')

if has('vim_starting') "{{{

  " Load neobundle.
  if finddir('neobundle.vim', '.;') != ''
    execute 'set runtimepath^=' .
          \ fnamemodify(finddir('neobundle.vim', '.;'), ':p')
  elseif &runtimepath !~ '/neobundle.vim'
    if !isdirectory(s:neobundle_dir.'/neobundle.vim')
      execute printf('!git clone %s://github.com/Shougo/neobundle.vim.git',
            \ (exists('$http_proxy') ? 'https' : 'git'))
            \ s:neobundle_dir.'/neobundle.vim'
    endif

    execute 'set runtimepath^=' . s:neobundle_dir.'/neobundle.vim'
  endif
endif
"}}}

call neobundle#begin(expand('$CACHE/neobundle'))
if neobundle#load_cache()

  call neobundle#load_toml('~/.vim/vim.d/neobundle_base.toml')
  call neobundle#load_toml('~/.vim/vim.d/neobundlelazy_base.toml', {'lazy' : 1})

  NeoBundleSaveCache
endif

call neobundle#end()

filetype plugin indent on
syntax enable

" Installation check.
if ! has('gui_running')
  NeoBundleCheck
endif

" Load full plugins
nnoremap <silent> [Space]s :<C-u>call <SID>loadAllPlugins()<CR>
function! s:loadAllPlugins()
  call neobundle#append()

  call neobundle#load_toml('~/.vim/vim.d/neobundle.toml')
  call neobundle#load_toml('~/.vim/vim.d/neobundlelazy.toml', {'lazy' : 1})

  call neobundle#end()
  filetype plugin indent on
  source ~/.vim/vim.d/05_pluginsetting.vim
  echom "Load all plugins done !"
endfunction
