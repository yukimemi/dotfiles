let g:vsctm_extensions_path = dein#get('vscode').path .. '/extensions'

function! s:use_vsctm() abort
  syntax off
  TSBufDisable highlight
  VsctmHighlightEnable
  echom "Use vsctm !"
endfunction

let s:use_vsctm_filetypes = ['ps1', 'typescript', 'javascript', 'dosbatch']

call map(s:use_vsctm_filetypes, { -> execute("au MyAutoCmd FileType " .. v:val .. " call s:use_vsctm()") })



