" let g:asyngrep_debug = v:true
let g:asyngrep_cfg_path = $VIM_PATH . "/asyngrep.toml"

nnoremap <space>agr <cmd>Agp --tool=ripgrep<cr>
nnoremap <space>agp <cmd>Agp --tool=pt<cr>
nnoremap <space>agj <cmd>Agp --tool=jvgrep<cr>

