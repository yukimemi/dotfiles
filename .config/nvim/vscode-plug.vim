" =============================================================================
" File        : vscode-plug.vim
" Author      : yukimemi
" Last Change : 2020/02/10 23:42:43.
" =============================================================================

" Plugin:
" Use vim-plug.
set shellslash
let s:cache_vscode = expand('~/.cache/vscode-neovim')
let s:plug_dir = s:cache_vscode . '/plugs'
let s:vim_plug_dir = s:cache_vscode . '/vim-plug'
if has('vim_starting')
  if !isdirectory(s:vim_plug_dir)
    echo "Install vim-plug ..."
    execute '!git clone --depth 1 https://github.com/junegunn/vim-plug.git ' . s:vim_plug_dir . '/autoload'
  endif
  execute 'set runtimepath^=' . fnamemodify(s:vim_plug_dir, ':p')
endif
set noshellslash

" Plugin list.
call plug#begin(s:plug_dir)

Plug 'gilligan/textobj-lastpaste'
Plug 'haya14busa/vim-asterisk'
Plug 'haya14busa/vim-operator-flashy'
Plug 'junegunn/vim-easy-align'
Plug 'kana/vim-operator-replace'
Plug 'kana/vim-operator-user'
Plug 'kana/vim-textobj-entire'
Plug 'kana/vim-textobj-fold'
Plug 'kana/vim-textobj-indent'
Plug 'kana/vim-textobj-line'
Plug 'kana/vim-textobj-user'
Plug 'machakann/vim-sandwich'
Plug 'machakann/vim-swap'
Plug 'ntpeters/vim-better-whitespace'
Plug 't9md/vim-quickhl'
Plug 'unblevable/quick-scope'
Plug 'vim-scripts/autodate.vim'
Plug 'vim-denops/denops.vim'
" Plug 'yukimemi/dps-ahdr'
Plug 'asvetliakov/vim-easymotion'

call plug#end()

" Plugin settings.
let $VIM_PATH = expand('~/.config/nvim')
silent! so $VIM_PATH/rc/autodate.vim
silent! so $VIM_PATH/rc/quick-scope.vim
silent! so $VIM_PATH/rc/textobj-lastpaste.vim
silent! so $VIM_PATH/rc/vim-asterisk.vim
silent! so $VIM_PATH/rc/vim-better-whitespace.vim
silent! so $VIM_PATH/rc/vim-easy-align.vim
silent! so $VIM_PATH/rc/vim-operator-flashy.vim
silent! so $VIM_PATH/rc/vim-operator-replace.vim
silent! so $VIM_PATH/rc/vim-operator-user.vim
silent! so $VIM_PATH/rc/vim-quickhl.vim
silent! so $VIM_PATH/rc/vim-swap.vim
silent! so $VIM_PATH/rc/vim-textobj-entire.vim
silent! so $VIM_PATH/rc/vim-textobj-fold.vim
silent! so $VIM_PATH/rc/vim-textobj-line.vim
silent! so $VIM_PATH/rc/vim-textobj-indent.vim
silent! so $VIM_PATH/rc/vim-textobj-user.vim

let g:EasyMotion_do_mapping = 0
nmap <cr> <Plug>(easymotion-bd-w)
" nmap <cr> <Plug>(easymotion-overwin-w)

