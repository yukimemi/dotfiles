let g:asyncrun_open = 8

" au MyAutoCmd User AsyncRunStart call asyncrun#quickfix_toggle(8, 1)

if has('nvim')
  nnoremap <leader>R <cmd>AsyncRun -mode=term -rows=8 deno run --no-check --unstable -A %<cr>
else
  nnoremap <leader>R <cmd>AsyncRun -mode=async -raw deno run --no-check --unstable -A %<cr>
endif
