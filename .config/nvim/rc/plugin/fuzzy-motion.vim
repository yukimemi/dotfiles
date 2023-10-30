" hook_add {{{
Keymap n ss <cmd>FuzzyMotion<cr>

let g:fuzzy_motion_auto_jump = v:false
let g:fuzzy_motion_disable_match_highlight = v:false
let g:fuzzy_motion_matchers = ["fzf", "kensaku"]
let g:fuzzy_motion_word_regexp_list = [
      \ '[0-9a-zA-Z_-]+',
      \ '([0-9a-zA-Z_-]|[.])+',
      \ '([0-9a-zA-Z]|[()<>.-_#''"]|(\s=+\s)|(,\s)|(:\s)|(\s=>\s))+'
      \ ]

" }}}
