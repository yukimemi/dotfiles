nnoremap <leader>g :Grepper -tool git<cr>
if executable("pt")
  nnoremap <leader>G :Grepper -tool pt<cr>
elseif executable("rg")
  nnoremap <leader>G :Grepper -tool rg<cr>
endif

nmap gs <Plug>(GrepperOperator)
xmap gs <Plug>(GrepperOperator)

au MyAutoCmd VimEnter * call <SID>grepper_aft()

function! s:grepper_aft() abort
  silent! packadd vim-grepper
  let g:grepper = get(g:, 'grepper', {})
  let g:grepper.tools = ['git', 'pt', 'rg', 'sift', 'findstr']
  let g:grepper.rg.grepprg = 'rg -H -i --no-heading --vimgrep --hidden --no-ignore'
  let g:grepper.pt.grepprg = 'pt --nogroup -i --nocolor --smart-case --skip-vcs-ignores --hidden'
endfunction

