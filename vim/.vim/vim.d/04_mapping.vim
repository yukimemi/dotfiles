inoremap <silent> jj <ESC>
nnoremap j gj
nnoremap k gk
nnoremap <Down> gj
nnoremap <Up>   gk
nnoremap h <Left>
nnoremap l <Right>
" open folding in "l"
nnoremap <expr> l foldlevel(line('.')) ? "\<Right>zo" : "\<Right>"
" for buffer
nnoremap gh :bp<CR>
nnoremap gl :bn<CR>
" for tab
nnoremap <C-l> gt
nnoremap <C-h> gT

nmap <Space> [Space]
nnoremap [Space] <Nop>

" Useful save mappings.
nnoremap <silent> <Leader><Leader> :<C-u>update<CR>

" Change current directory.
nnoremap [Space]cd :<C-u>call <SID>cd_buffer_dir()<CR>
function! s:cd_buffer_dir()"{{{
  let filetype = getbufvar(bufnr('%'), '&filetype')
  if filetype ==# 'vimfiler'
    let dir = getbufvar(bufnr('%'), 'vimfiler').current_dir
  elseif filetype ==# 'vimshell'
    let dir = getbufvar(bufnr('%'), 'vimshell').save_dir
  else
    let dir = isdirectory(bufname('%')) ? bufname('%') : fnamemodify(bufname('%'), ':p:h')
  endif

  cd `=dir`
endfunction
"}}}

" like emacs
cnoremap <C-b> <Left>
cnoremap <C-f> <Right>
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
cnoremap <C-d> <Del>
cnoremap <C-y> <C-r>
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>

" Vim-users.jp - Hack #74: http://vim-users.jp/2009/09/hack74/
nnoremap <silent> [Space]ev  :<C-u>tabedit $MYVIMRC<CR>
nnoremap <silent> [Space]eg  :<C-u>tabedit $MYGVIMRC<CR>

" cmdwin
nnoremap : q:i
vnoremap : q:A

"  for git mergetool
if &diff
  nnoremap <buffer> <Leader>1 :diffget LOCAL<CR>
  nnoremap <buffer> <Leader>2 :diffget BASE<CR>
  nnoremap <buffer> <Leader>3 :diffget REMOTE<CR>
  nnoremap <buffer> <Leader>u :<C-u>diffupdate<CR>
  nnoremap <buffer> u u:<C-u>diffupdate<CR>
endif

" hilight over 100 column {{{
" http://blog.remora.cx/2013/06/source-in-80-columns-2.html
noremap <Plug>(ToggleColorColumn)
      \ :<c-u>let &colorcolumn = len(&colorcolumn) > 0 ? '' :
      \   join(range(101, 9999), ',')<CR>

nmap <silent> cc <Plug>(ToggleColorColumn)
"}}}

