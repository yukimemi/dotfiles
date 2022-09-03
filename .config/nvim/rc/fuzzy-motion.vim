nnoremap <cr> <cmd>FuzzyMotion<cr>

let s:fuzzy_motion_ignore_filetype = ['qf', 'quickfix']

call map(s:fuzzy_motion_ignore_filetype, { -> execute("au MyAutoCmd FileType " .. v:val .. " silent! nnoremap <buffer> <cr> <cr>") })

let g:fuzzy_motion_auto_jump = v:true
let g:fuzzy_motion_disable_match_highlight = v:false
let g:fuzzy_motion_word_regexp_list = [
      \ '[0-9a-zA-Z_-]+',
      \ '([0-9a-zA-Z_-]|[.])+',
      \ '([0-9a-zA-Z]|[()<>.-_#''"]|(\s=+\s)|(,\s)|(:\s)|(\s=>\s))+'
      \ ]
