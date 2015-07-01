function! ZenkakuSpace()
  highlight ZenkakuSpace cterm=underline ctermfg=darkgrey gui=underline guifg=darkgrey
  silent! match ZenkakuSpace /　/
endfunction

if has('syntax')
  au MyAutoCmd VimEnter,BufEnter * call ZenkakuSpace()
endif
"}}}

" autochdir"{{{
au MyAutoCmd BufEnter * execute ":silent! lcd " . escape(expand("%:p:h"), ' ')
"}}}

function! s:str2byte(str)"{{{
  return map(range(len(a:str)), 'char2nr(a:str[v:val])')
endfunction
"}}}

function! s:byte2hex(bytes)"{{{
  return join(map(copy(a:bytes), 'printf("%02X", v:val)'), '')
endfunction
"}}}

function! s:auto_mkdir(dir, force)"{{{
  " Hack #202: http://vim-users.jp/2011/02/hack202/
  if !isdirectory(a:dir) && (a:force ||
        \ input(printf('"%s" does not exist. Create? [y/N]', a:dir)) =~? '^y\%[es]$')
    call mkdir(iconv(a:dir, &encoding, &termencoding), 'p')
  endif
endfunction
au MyAutoCmd BufWritePre * call s:auto_mkdir(expand('<afile>:p:h'), v:cmdbang)
"}}}

function! s:rtrim()"{{{
  " delete space at the end of line
  let save_cursor = getpos(".")
  %s/\s\+$//e
  call setpos(".", save_cursor)
endfunction
au MyAutoCmd BufWritePre *.coffee,*.js,*.ps1,*.md,*.jade,Vagrantfile,.vimrc call <SID>rtrim()
com! Rtrim call <SID>rtrim()
"}}}

function! s:format()"{{{
  " auto indent format
  let save_view = winsaveview()
  normal gg=G
  call winrestview(save_view)
endfunction
nnoremap [Space]f :<C-u>call <SID>format()<CR>
"au MyAutoCmd BufWrite * call <SID>format()
"}}}

function! s:addQuote()"{{{
  normal gg2dd
  9,$s/^/> /
  normal gg
endfunction
au MyAutoCmd FileType mail nnoremap <silent><buffer> [Space]q :<C-u>silent! call <SID>addQuote()<CR>
"}}}

" diff original"{{{
command! DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis | wincmd p | diffthis
"}}}

" save as root"{{{
com! Wsu w !sudo tee > /dev/null %
"}}}

" remove file if 0 byte"{{{
" http://qiita.com/hykw/items/6dbb43bdcd8874a0daf7
au MyAutoCmd BufWritePost * call s:Hykw_removeFileIf0Byte()
function! s:Hykw_removeFileIf0Byte()
  let filename = expand('%:p')
  if getfsize(filename) > 0
    " do nothing
    return
  endif

  let msg = printf("\n%s is empty, remove?(y/N)", filename)
  if input(msg) == 'y'
    call delete(filename)
    bdelete
  endif
endfunction
"}}}

" vp doesn't replace paste buffer"{{{
function! RestoreRegister()
  let @" = s:restore_reg
  return ''
endfunction
function! s:Repl()
  let s:restore_reg = @"
  return "p@=RestoreRegister()\<cr>"
endfunction
vmap <silent> <expr> p <sid>Repl()
"}}}

