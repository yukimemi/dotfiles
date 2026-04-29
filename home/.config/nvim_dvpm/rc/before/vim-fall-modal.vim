" =============================================================================
" File        : vim-fall-modal.vim
" Author      : yukimemi
" Last Change : 2025/10/26 19:56:27.
" =============================================================================

augroup vimrc-fall-modal
  autocmd!
  autocmd User FallModalSetup call fall_modal#default#setup()
  autocmd User FallModalDefaultConfigPost:insert call s:fall_modal_insert_mode_config()
  autocmd User FallModalDefaultConfigPost:normal call s:fall_modal_normal_mode_config()
  autocmd User FallModalEnterPrompt:* call fall_modal#mode#change_mode('insert')
augroup END

function s:fall_modal_insert_mode_config() abort
  cnoremap <C-f> <Right>
  cnoremap <C-b> <Left>
  cnoremap <CR> <Cmd>call fall_modal#mode#change_mode('normal')<CR><CR>
endfunction

function s:fall_modal_normal_mode_config() abort
  cnoremap <ESC> <C-c>
endfunction

