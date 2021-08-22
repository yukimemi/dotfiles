" settings.
set incsearch hlsearch wrapscan
set ignorecase smartcase infercase
set clipboard=unnamedplus

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
nnoremap <silent> <localleader><localleader> <cmd>Write<cr>

" Open file with explorer.
nnoremap <silent> <localleader>o <cmd>call VSCodeNotify('revealFileInOS')<cr>

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

