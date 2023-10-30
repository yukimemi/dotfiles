"---------------------------------------------------------------------------
" Key-mappings:
"

function! s:keymap(force_map, modes, ...) abort
  let arg = join(a:000, ' ')
  let cmd = (a:force_map || arg =~? '<Plug>') ? 'map' : 'noremap'
  for mode in split(a:modes, '.\zs')
    if index(split('nvsxoilct', '.\zs'), mode) < 0
      echoerr 'Invalid mode is detected: ' . mode
      continue
    endif
    execute mode . cmd arg
  endfor
endfunction

command! -nargs=+ -bang Keymap call <SID>keymap(<bang>0, <f-args>)

let g:mapleader = ' '
let g:maplocalleader = '\\'

" Visual mode keymappings:
if (!has('nvim') || $DISPLAY !=# '') && has('clipboard')
  Keymap x y "*y<Cmd>let [@+,@"]=[@*,@*]<CR>
endif

" Enable undo <C-w> and <C-u>.
Keymap i <C-w>  <C-g>u<C-w>
Keymap i <C-u>  <C-g>u<C-u>
Keymap i <C-k>  <C-o>D

" Command-line mode keymappings:
Keymap c <C-a>          <Home>
Keymap c <C-b>          <Left>
Keymap c <C-d>          <Del>
Keymap c <C-f>          <Right>
Keymap c <C-n>          <Down>
Keymap c <C-p>          <Up>
Keymap c <C-g>          <C-c>
Keymap c <C-k> <Cmd>call setcmdline(getcmdpos() ==# 1 ? '' : getcmdline()[:getcmdpos() - 2])<CR>

" Set autoread.
Keymap n <Space>c <Cmd>call <SID>toggle_conceal()<CR>

function s:toggle_conceal() abort
  if &l:conceallevel == 0
    setlocal conceallevel=3
  else
    setlocal conceallevel=0
  endif
  setlocal conceallevel?
endfunction

Keymap nx j gj
Keymap nx k gk
Keymap nx <tab> %
Keymap nx gh ^
Keymap nx gl $

Keymap i <c-l> <c-g>U<right>

Keymap n <space><space> <cmd>update<cr>
Keymap n <esc><esc> <cmd>nohlsearch<cr>

" s: Windows and buffers(High priority)
" The prefix key.
Keymap n s   <Nop>
Keymap n s= <c-w>=
Keymap n sH <c-w>H
Keymap n sJ <c-w>J
Keymap n sK <c-w>K
Keymap n sL <c-w>L
Keymap n sO <cmd>tabonly<cr>
Keymap n sQ <cmd>qa<cr>
Keymap n sbk <cmd>bd!<cr>
Keymap n sbq <cmd>q!<cr>
Keymap n sh <cmd>sp<cr>
Keymap n s0 <cmd>only<cr>
Keymap n sn <cmd>bn<cr>
Keymap n so <c-w>_<c-w>|
Keymap n sp <cmd>bp<cr>
Keymap n sq <cmd>q<cr>
Keymap n sr <c-w>r
Keymap n st <cmd>tabnew<cr>
Keymap n sv <cmd>vs<cr>
Keymap n sw <c-w>w
Keymap n sh <cmd>split<cr>
Keymap n sv <cmd>vsplit<cr>

" Window movement.
Keymap n <c-h> <c-w>h
Keymap n <c-l> <c-w>l
Keymap n <c-j> <c-w>j
Keymap n <c-k> <c-w>k

" Smart <C-f>, <C-b>.
Keymap nx <expr> <C-f> max([winheight(0) - 2, 1])
      \ .. '<C-d>' .. (line('w$') >= line('$') ? 'L' : 'M')
Keymap nx <expr> <C-b> max([winheight(0) - 2, 1])
      \ .. '<C-u>' .. (line('w0') <= 1 ? 'H' : 'M')

Keymap n ZZ  <Nop>
Keymap x r <C-v>

" If press l on fold, fold open.
Keymap n <expr> l foldclosed(line('.')) != -1 ? 'zo0' : 'l'
" If press l on fold, range fold open.
Keymap x <expr> l foldclosed(line('.')) != -1 ? 'zogv0' : 'l'

" Substitute.
Keymap x s :s//g<Left><Left>

" Wordcount
command! WordCount echo getline(1, '$')->join()->strchars()

" Command group opening with a specific character code again.
" Open in UTF-8 again.
command! -bang -bar -complete=file -nargs=? Utf8
      \ edit<bang> ++enc=utf-8 <args>
" Open in iso-2022-jp again.
command! -bang -bar -complete=file -nargs=? Iso2022jp
      \ edit<bang> ++enc=iso-2022-jp <args>
" Open in Shift_JIS again.
command! -bang -bar -complete=file -nargs=? Cp932
      \ edit<bang> ++enc=cp932 <args>
" Open in EUC-jp again.
command! -bang -bar -complete=file -nargs=? Euc
      \ edit<bang> ++enc=euc-jp <args>
" Open in UTF-16 again.
command! -bang -bar -complete=file -nargs=? Utf16
      \ edit<bang> ++enc=ucs-2le <args>

" Tried to make a file note version.
command! WUtf8 setlocal fenc=utf-8
command! WCp932 setlocal fenc=cp932

" Appoint a line feed.
command! -bang -complete=file -nargs=? WUnix
      \ write<bang> ++fileformat=unix <args> | edit <args>
command! -bang -complete=file -nargs=? WDos
      \ write<bang> ++fileformat=dos <args> | edit <args>

" Insert special character
Keymap i <C-v>u  <C-r>=nr2char(0x)<Left>

