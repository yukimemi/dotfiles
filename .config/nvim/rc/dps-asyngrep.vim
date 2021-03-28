let g:asyngrep_debug = v:true
let g:asyngrep_cfg_path = $VIM_PATH . "/asyngrep.toml"

nnoremap <space>ss <cmd>Agp<cr>
nnoremap <space>sr <cmd>Agp --tool=ripgrep<cr>
nnoremap <space>sp <cmd>Agp --tool=pt<cr>
nnoremap <space>sj <cmd>Agp --tool=jvgrep<cr>

nnoremap <space>sS <cmd>Agp --tool=default-all<cr>
nnoremap <space>sR <cmd>Agp --tool=ripgrep-all<cr>
nnoremap <space>sP <cmd>Agp --tool=pt-all<cr>
nnoremap <space>sJ <cmd>Agp --tool=jvgrep-all<cr>

