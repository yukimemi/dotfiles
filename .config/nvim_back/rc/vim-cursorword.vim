function! s:ToggleCursorWord() abort
  let b:cursorword = !get(b:, 'cursorword', 1)
endfunction

com! ToggleCursorWord call s:ToggleCursorWord()

