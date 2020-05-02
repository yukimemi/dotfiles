let g:lightline = {
      \ 'colorscheme': 'gruvbox_material',
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
      \             [ 'gitbranch', 'cocstatus', 'readonly', 'filename', 'bomb' ],
      \             [ 'vista'] ]
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
      \   'vista': 'NearestMethodOrFunction',
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
    if IsInstalled('vim-devicons')
      return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype . ' ' . WebDevIconsGetFileTypeSymbol() : 'no ft') : ''
    else
      return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
    endif
  endif
endfunction

function! LightLineFileformat()
  if g:is_linux
    return winwidth(0) > 70 ? &fileformat : ''
  else
    if IsInstalled('vim-devicons')
      return winwidth(0) > 70 ? &fileformat . ' ' . WebDevIconsGetFileFormatSymbol() : ''
    else
      return winwidth(0) > 70 ? &fileformat : ''
    endif
  endif
endfunction

function! LightLineBomb() abort
  return &bomb ? 'bomb' : ''
endfunction

function! LightLineReanimate()
  if IsInstalled("vim-reanimate")
    return reanimate#is_saved() ? reanimate#last_point() : "no save"
  else
    return ""
  endif
endfunction

function! GinaStatus() abort
  if IsInstalled("gina.vim")
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

function! NearestMethodOrFunction() abort
  if IsInstalled('vista.vim')
    return get(b:, 'vista_nearest_method_or_function', '')
  else
    return ""
  endif
endfunction
