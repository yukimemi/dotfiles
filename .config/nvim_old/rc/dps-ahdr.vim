let g:ahdr_debug = v:false
let g:ahdr_cfg_path = $VIM_PATH . "/ahdr.toml"

augroup MyAutoCmdAhdr | autocmd! | augroup END

command! DenopsAhdrDebug call <SID>my_ahdr_debug()

function! s:my_ahdr_debug() abort
  au MyAutoCmdAhdr BufWritePost <buffer> DenopsAhdr waitcmd
endfunction
