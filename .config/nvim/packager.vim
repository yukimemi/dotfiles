" =============================================================================
" File        : packager.vim
" Author      : yukimemi
" Last Change : 2018/11/11 14:08:45.
" =============================================================================

" Plugin:
" Use packager. {{{1
set packpath^=$CACHE_HOME
let s:package_home = $CACHE_HOME . '/pack/packager'
let s:packager_dir = s:package_home . '/opt/vim-packager'
let s:packager_download = v:false
if has('vim_starting')
  if !isdirectory(s:packager_dir)
    echo "Install vim-packager ..."
    execute '!git clone --depth 1 https://github.com/kristijanhusak/vim-packager ' . s:packager_dir
    let s:packager_download = v:true
  endif
endif

let s:cfg_path = $VIM_PATH . '/rc'

function! s:source_plugin_cfg(repo) abort
  " Load plugin config if exist.
  let l:name = substitute(a:repo, '^.*/', '', '')
  let l:plug_cfg = expand(s:cfg_path . '/' . l:name)
  let l:plug_cfg_vim = expand(s:cfg_path . '/' . l:name . '.vim')
  if filereadable(l:plug_cfg)
    execute printf('source %s', l:plug_cfg)
  elseif filereadable(l:plug_cfg_vim)
    execute printf('source %s', l:plug_cfg_vim)
  endif
endfunction

let s:plugins = [
      \ {'repo': 'adrian5/oceanic-next-vim', 'opt': {'type': 'opt'}},
      \ {'repo': 'ctrlpvim/ctrlp.vim'},
      \ {'repo': 'gilligan/textobj-lastpaste'},
      \ {'repo': 'haya14busa/vim-asterisk'},
      \ {'repo': 'kana/vim-operator-replace'},
      \ {'repo': 'kana/vim-operator-user'},
      \ {'repo': 'kana/vim-textobj-entire'},
      \ {'repo': 'kana/vim-textobj-fold'},
      \ {'repo': 'kana/vim-textobj-function'},
      \ {'repo': 'kana/vim-textobj-indent'},
      \ {'repo': 'kana/vim-textobj-line'},
      \ {'repo': 'kana/vim-textobj-user'},
      \ {'repo': 'kaneshin/ctrlp-filetype'},
      \ {'repo': 'kaneshin/ctrlp-memolist'},
      \ {'repo': 'kaneshin/ctrlp-sonictemplate'},
      \ {'repo': 'kristijanhusak/vim-packager', 'opt': {'type': 'opt'}},
      \ {'repo': 'lambdalisue/gina.vim'},
      \ {'repo': 'machakann/vim-sandwich'},
      \ {'repo': 'machakann/vim-swap'},
      \ {'repo': 'machakann/vim-textobj-delimited'},
      \ {'repo': 'mattn/ctrlp-launcher'},
      \ {'repo': 'mattn/ctrlp-mark'},
      \ {'repo': 'mattn/ctrlp-matchfuzzy'},
      \ {'repo': 'mattn/vim-textobj-url'},
      \ {'repo': 'neoclide/coc.nvim', 'opt': {'branch': 'release'}},
      \ {'repo': 'ompugao/ctrlp-history'},
      \ {'repo': 'osyo-manga/vim-operator-search'},
      \ {'repo': 'osyo-manga/vim-operator-stay-cursor'},
      \ {'repo': 'osyo-manga/vim-textobj-multiblock'},
      \ {'repo': 'seroqn/tozzy.vim'},
      \ {'repo': 'suy/vim-ctrlp-commandline'},
      \ {'repo': 'thinca/vim-singleton'},
      \ {'repo': 'tyru/caw.vim'},
      \ ]


function! s:packager_init(packager) abort
  for plug in s:plugins
    let l:opt = get(plug, 'opt', {})
    call a:packager.add(plug.repo, l:opt)
  endfor
endfunction

silent! packadd vim-packager
call packager#setup(function('s:packager_init'))

if s:packager_download
  PackagerInstall
endif

" Source plugin cfg.
for plug in s:plugins
  call s:source_plugin_cfg(plug.repo)
endfor

