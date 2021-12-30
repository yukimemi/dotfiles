nnoremap <cr> <cmd>FuzzyMotion<cr>

let s:fuzzy_motion_ignore_filetype = ['qf', 'quickfix']

call map(s:fuzzy_motion_ignore_filetype, { -> execute("au MyAutoCmd FileType " .. v:val .. " silent! nnoremap <buffer> <cr> <cr>") })

