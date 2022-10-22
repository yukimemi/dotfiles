set encoding=utf-8
scriptencoding utf-8

set fileencodings=ucs-bom,utf-8,iso-2022-jp,euc-jp,cp932,latin1
set fileformats=unix,dos

augroup MyAutoCmd | autocmd! | augroup END

let s:package_home = expand('<sfile>:p:h') .. '/plugs'
let s:vim_plug_bootstrap = expand('<sfile>:p:h') .. '/vim-plug'
if !isdirectory(s:vim_plug_bootstrap)
  execute 'silent! !git clone --depth 1 https://github.com/junegunn/vim-plug.git ' .. s:vim_plug_bootstrap .. '/autoload'
endif
execute 'set runtimepath^=' . substitute(fnamemodify(s:vim_plug_bootstrap, ':p') , '[/\\]$', '', '')

call plug#begin(s:package_home)
Plug 'vim-denops/denops.vim'
Plug 'yukimemi/dps-randomcolorscheme'
Plug 'itchyny/vim-cursorword'
call plug#end()

let g:randomcolorscheme_debug = v:true

PlugUpdate
