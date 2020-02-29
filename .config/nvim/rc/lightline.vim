let g:lightline = {
      \ 'colorscheme': 'simplicity',
      \ 'mode_map': {
      \   'n' : 'N',
      \   'i' : 'I',
      \   'R' : 'R',
      \   'v' : 'V',
      \   'V' : 'V-L',
      \   'c' : 'C',
      \   "\<c-v>": 'V-B',
      \   's' : 'S',
      \   'S' : 'S-L',
      \   "\<c-s>": 'S-B'
      \   },
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'ginastatus', 'cocstatus', 'readonly', 'filename', 'bomb', 'reanimate' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'gitbranch#name',
      \   'ginastatus': 'GinaStatus',
      \   'readonly': 'LightLineReadonly',
      \   'modified': 'LightLineModified',
      \   'filename': 'LightLineFilename',
      \   'filetype': 'LightLineFiletype',
      \   'fileformat': 'LightLineFileformat',
      \   'bomb': 'LightLineBomb',
      \   'cocstatus': 'coc#status',
      \   'reanimate': 'LightLineReanimate'
      \ },
      \ }

" Use auocmd to force lightline update.
au MyAutoCmd User CocStatusChange,CocDiagnosticChange call lightline#update()

function! LightLineModified()
  if &filetype == "help"
    return ""
  elseif &modified
    return "+"
  elseif &modifiable
    return ""
  else
    return ""
  endif
endfunction

function! LightLineReadonly()
  if &filetype == "help"
    return ""
  elseif &readonly
    return ""
  else
    return ""
  endif
endfunction

function! LightLineFugitive()
  if exists("*fugitive#head")
    let _ = fugitive#head()
    return strlen(_) ? ''._ : ''
  endif
  return ''
endfunction

function! LightLineFilename()
  return ('' != LightLineReadonly() ? LightLineReadonly() . ' ' : '') .
        \ ('' != expand('%:t') ? expand('%:t') : '[No Name]') .
        \ ('' != LightLineModified() ? ' ' . LightLineModified() : '')
endfunction

function! LightLineFiletype()
  if g:is_linux
    return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
  else
    return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype . ' ' . WebDevIconsGetFileTypeSymbol() : 'no ft') : ''
  endif
endfunction

function! LightLineFileformat()
  if g:is_linux
    return winwidth(0) > 70 ? &fileformat : ''
  else
    return winwidth(0) > 70 ? (&fileformat . ' ' . WebDevIconsGetFileFormatSymbol()) : ''
  endif
endfunction

function! LightLineBomb() abort
  return &bomb ? 'bomb' : ''
endfunction

function! LightLineReanimate()
  return reanimate#is_saved() ? reanimate#last_point() : "no save"
endfunction

function! GinaStatus() abort
  if IsInstalled("autoload/gina.vim")
    let staged = gina#component#status#staged() ? gina#component#status#staged() : 0
    let unstaged = gina#component#status#unstaged() ? gina#component#status#unstaged() : 0
    let conflicted = gina#component#status#conflicted() ? gina#component#status#conflicted() : 0
    return printf(
          \ 'suc: [%s, %s, %s]',
          \ staged,
          \ unstaged,
          \ conflicted,
          \)
  else
    return ""
  endif
endfunction

