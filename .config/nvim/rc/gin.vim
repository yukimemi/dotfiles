if !g:plugin_use_gin
  finish
endif

Keymap n <leader>gs <cmd>GinStatus<cr>
Keymap n <leader>gc <cmd>Gin commit -v<cr>
Keymap n <leader>gb <cmd>GinBranch<cr>
Keymap n <leader>gg <cmd>Gin grep<cr>
Keymap n <leader>gd <cmd>Gin diff<cr>
Keymap n <leader>gl <cmd>Gin log<cr>
Keymap n <leader>gL <cmd>execute printf('Gin log -p %s', expand('%'))<cr>
Keymap n <leader>gp <cmd>Gin push<cr>

