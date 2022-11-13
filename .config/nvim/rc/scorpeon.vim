function! s:use_scorpeon() abort
  " syntax off
  TSBufDisable highlight
  ScorpeonHighlightEnable
  echom "Use scorpeon!"
endfunction

let s:use_scorpeon_filetypes = ['ps1', 'typescript', 'javascript', 'dosbatch', 'markdown', 'toml', 'log', 'xml']

call map(s:use_scorpeon_filetypes, { -> execute("au MyAutoCmd FileType " .. v:val .. " call s:use_scorpeon()") })

let g:scorpeon_extensions_path = [
      \ expand('$CACHE/vscode/extensions'),
      \ expand('$CACHE/scorpeon'),
      \ ]

let g:scorpeon_highlight = {
      \ 'enable': s:use_scorpeon_filetypes,
      \ 'disable': []
      \ }

