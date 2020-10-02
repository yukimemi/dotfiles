au MyAutoCmd FileType haskell call <SID>ghcmod_vim_aft()

function! s:ghcmod_vim_aft() abort
  packadd ghcmod-vim
  setl completeopt=menu,preview
  nnoremap <buffer> K :<c-u>GhcModInfoPreview<cr>
endfunction

