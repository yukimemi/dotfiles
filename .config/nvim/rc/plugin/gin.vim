-- hook_add {{{
Keymap n <leader>gs <cmd>GinStatus<cr>
Keymap n <leader>gc <cmd>Gin commit -v<cr>
Keymap n <leader>gb <cmd>GinBranch<cr>
Keymap n <leader>gg <cmd>Gin grep<cr>
Keymap n <leader>gd <cmd>GinDiff<cr>
Keymap n <leader>gl <cmd>GinLog<cr>
Keymap n <leader>gL <cmd>GinLog -p -- %<cr>
Keymap n <leader>gp <cmd>Gin push<cr>

au MyAutoCmd BufRead ginedit://* call s:my_ginedit_cfg()

function s:my_ginedit_cfg() abort
  Keymap nx <buffer> dp <Plug>(gin-diffput)
  Keymap nx <buffer> do <Plug>(gin-diffget)
endfunction
-- }}}
