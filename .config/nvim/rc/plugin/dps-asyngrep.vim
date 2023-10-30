" hook_add {{{
let g:asyngrep_debug = v:false
let g:asyngrep_cfg_path = expand("~/.config/asyngrep/asyngrep.toml")

set grepformat="%f:%l:%c:%m"

Keymap n <space>ss <cmd>Agp<cr>
Keymap n <space>sr <cmd>Agp --tool=ripgrep<cr>
Keymap n <space>sp <cmd>Agp --tool=pt<cr>
Keymap n <space>sj <cmd>Agp --tool=jvgrep<cr>

Keymap n <space>sS <cmd>Agp --tool=default-all<cr>
Keymap n <space>sR <cmd>Agp --tool=ripgrep-all<cr>
Keymap n <space>sP <cmd>Agp --tool=pt-all<cr>
Keymap n <space>sJ <cmd>Agp --tool=jvgrep-all<cr>
" }}}
