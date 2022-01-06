" Init:
set encoding=utf-8
scriptencoding utf-8

" Release autogroup in MyAutoCmd.
augroup MyAutoCmd | autocmd! | augroup END

" settings.
set incsearch hlsearch wrapscan
set ignorecase smartcase infercase
set clipboard=unnamedplus

" Judge os type.
let g:is_windows = has('win16') || has('win32') || has('win64')
let g:is_cygwin = has('win32unix')
let g:is_darwin = has('mac') || has('macunix') || has('gui_macvim')
let g:is_linux = !g:is_windows && !g:is_cygwin && !g:is_darwin

" backup dir.
let $BACKUP_PATH = expand('~/.cache/vscode-neovim/back')
let s:undo_dir = $BACKUP_PATH . '/undo'
let s:backup_dir = $BACKUP_PATH . '/back'
let s:directory = $BACKUP_PATH . '/dir'
let s:view_dir = $BACKUP_PATH . '/view'
silent! call mkdir(s:undo_dir, 'p')
silent! call mkdir(s:backup_dir, 'p')
silent! call mkdir(s:directory, 'p')
silent! call mkdir(s:view_dir, 'p')

set undofile
exe 'set undodir=' . s:undo_dir
exe 'set backupdir=' . s:backup_dir
exe 'set directory=' . s:directory
exe 'set viewdir=' . s:view_dir

" mappings.
nnoremap <silent> j gj
nnoremap <silent> k gk
xnoremap <silent> j gj
xnoremap <silent> k gk
nnoremap <silent> <Down> gj
nnoremap <silent> <Up>   gk
nnoremap <silent> h <Left>
nnoremap <silent> l <Right>
inoremap <silent> <c-l> <C-g>U<Right>
noremap <silent> gh ^
noremap <silent> gl $
nnoremap <silent> Y y$

" Useful save mappings.
nnoremap <silent> <space><space> <cmd>Write<cr>

" Open file with explorer.
nnoremap <silent> ,o <cmd>call VSCodeNotify('revealFileInOS')<cr>

" nohlsearch.
nnoremap <silent> <esc><esc> <cmd>nohlsearch<cr>

" utility functions.
function! s:switchEditor(...) abort
  let count = a:1
  let direction = a:2
  for i in range(1, count ? count : 1)
    call VSCodeCall(direction ==# 'next' ? 'workbench.action.nextEditorInGroup' : 'workbench.action.previousEditorInGroup')
  endfor
endfunction

function! s:manageEditorSize(...)
  let count = a:1
  let to = a:2
  for i in range(1, count ? count : 1)
    call VSCodeNotify(to ==# 'increase' ? 'workbench.action.increaseViewSize' : 'workbench.action.decreaseViewSize')
  endfor
endfunction

command! -bar ToScratch
      \ setlocal buftype=nofile bufhidden=hide noswapfile

command! -nargs=1 -complete=command L
      \ <mods> new | ToScratch |
      \ call setline(1, split(execute(<q-args>), '\n'))

" tab.
nnoremap <silent> <c-l> <cmd>call <SID>switchEditor(v:count, 'next')<cr>
nnoremap <silent> <c-h> <cmd>call <SID>switchEditor(v:count, 'prev')<cr>

" quickfix.
nnoremap z= <cmd>call VSCodeNotify('keyboard-quickfix.openQuickFix')<cr>

" Use prefix s.
nnoremap <silent> s <Nop>
nnoremap <silent> s= <cmd>call VSCodeNotify('workbench.action.evenEditorWidths')<cr>
nnoremap <silent> so <cmd>call VSCodeNotify('workbench.action.toggleEditorWidths')<cr>
nnoremap <silent> s0 <cmd>Only<cr>
nnoremap <silent> sO <cmd>Tabonly<cr>
nnoremap <silent> st <cmd>Tabnew<cr>
nnoremap <silent> ss <cmd>Split<cr>
nnoremap <silent> sv <cmd>Vsplit<cr>
nnoremap <silent> sq <cmd>Quit<cr>
nnoremap <silent> sQ <cmd>Qall<cr>
nnoremap <silent> sbk <cmd>Quit!<cr>
nnoremap <silent> sbq <cmd>Quit!<cr>

" Window move.
nnoremap <silent> sj <cmd>call VSCodeNotify('workbench.action.focusBelowGroup')<cr>
nnoremap <silent> sJ <cmd>call VSCodeNotify('workbench.action.moveEditorToBelowGroup')<cr>
nnoremap <silent> sk <cmd>call VSCodeNotify('workbench.action.focusAboveGroup')<cr>
nnoremap <silent> sK <cmd>call VSCodeNotify('workbench.action.moveEditorToAboveGroup')<cr>
nnoremap <silent> sh <cmd>call VSCodeNotify('workbench.action.focusLeftGroup')<cr>
nnoremap <silent> sH <cmd>call VSCodeNotify('workbench.action.moveEditorToLeftGroup')<cr>
nnoremap <silent> sl <cmd>call VSCodeNotify('workbench.action.focusRightGroup')<cr>
nnoremap <silent> sL <cmd>call VSCodeNotify('workbench.action.moveEditorToRightGroup')<cr>
nnoremap <silent> sw <cmd>call VSCodeNotify('workbench.action.focusNextGroup')<cr>
nnoremap <silent> sW <cmd>call VSCodeNotify('workbench.action.focusPreviousGroup')<cr>

" Window size.
nnoremap <silent> s> <cmd>call <SID>manageEditorSize(v:count, 'increase')<cr>
nnoremap <silent> s+ <cmd>call <SID>manageEditorSize(v:count, 'increase')<cr>
nnoremap <silent> s< <cmd>call <SID>manageEditorSize(v:count, 'decrease')<cr>
nnoremap <silent> s- <cmd>call <SID>manageEditorSize(v:count, 'decrease')<cr>

" Comment.
xmap gc  <Plug>VSCodeCommentary
nmap gc  <Plug>VSCodeCommentary
omap gc  <Plug>VSCodeCommentary
nmap gcc <Plug>VSCodeCommentaryLine

" autocmd.
au MyAutoCmd FileType * set fo-=c fo-=r fo-=o

" Use plugin with packer.nvim.
" let $VIM_PATH = expand('~/.config/nvim')
" exe 'set runtimepath^=' . expand('~/.config/nvim')
" exe "lua require('vscode-packer')"
" Use plugin with plug.vim
exe printf("source %s", expand("~/.config/nvim/vscode-plug.vim"))
