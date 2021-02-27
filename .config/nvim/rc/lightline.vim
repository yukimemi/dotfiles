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
      \   'left': [ [ 'mode', 'coc_info', 'coc_hints', 'coc_errors', 'coc_warnings', 'coc_ok', 'spell', 'paste' ],
      \             [ 'gitbranch', 'coc_status', 'readonly', 'filename', 'bomb' ],
      \             [ 'vista', 'quickfix_title', 'deinstatus' ]
      \   ],
      \   'right': [
      \     [ 'lineinfo' ],
      \     [ 'filetype', 'fileencoding', 'fileformat' ],
      \     [ 'scount', 'noscrollbar' ]
      \   ],
      \ },
      \ 'component': {
      \   'spell': "%{&spell ? 'SPELL' : ''}",
      \  },
      \ 'component_function': {
      \   'gitbranch'     : 'gitbranch#name',
      \   'ginastatus'    : 'GinaStatus',
      \   'readonly'      : 'LightLineReadonly',
      \   'modified'      : 'LightLineModified',
      \   'filename'      : 'LightLineFilename',
      \   'filetype'      : 'LightLineFiletype',
      \   'fileformat'    : 'LightLineFileformat',
      \   'bomb'          : 'LightLineBomb',
      \   'quickfix_title': 'LightLineQuickfixTitle',
      \   'cocstatus'     : 'coc#status',
      \   'deinstatus'    : 'dein#get_progress',
      \   'noscrollbar'   : 'LightLineNoScrollbar',
      \   'vista'         : 'NearestMethodOrFunction',
      \   'reanimate'     : 'LightLineReanimate',
      \   'toggl_task'    : 'toggl#task',
      \   'toggl_time'    : 'toggl#time',
      \   'scount'        : 'LightLineSearchCount',
      \ },
      \ 'component_type': {
      \   'coc_warnings': 'warning',
      \   'coc_errors'  : 'error',
      \   'coc_info'    : 'info',
      \   'coc_hints'   : 'hints',
      \   'coc_ok'      : 'left',
      \   'lsp_warnings': 'warning',
      \   'lsp_errors'  : 'error',
      \   'lsp_ok'      : 'middle',
      \ },
      \ 'component_expand': {
      \   'coc_warnings': 'lightline#coc#warnings',
      \   'coc_errors'  : 'lightline#coc#errors',
      \   'coc_info'    : 'lightline#coc#info',
      \   'coc_hints'   : 'lightline#coc#hints',
      \   'coc_ok'      : 'lightline#coc#ok',
      \   'coc_status'  : 'lightline#coc#status',
      \   'lsp_warnings': 'lightline_lsp#warnings',
      \   'lsp_errors'  : 'lightline_lsp#errors',
      \   'lsp_ok'      : 'lightline_lsp#ok',
      \ }
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

function! LightLineCocErrors() abort
  return b:coc_diagnostic_info['error'] != 0 ? ' ' . b:coc_diagnostic_info['error'] : ''
endfunction

function! LightLineCocWarnings() abort
  return b:coc_diagnostic_info['warning'] != 0 ? ' ' . b:coc_diagnostic_info['warning'] : ''
endfunction

function! LightLineCocInformation() abort
  return b:coc_diagnostic_info['information'] != 0 ? ' ' . b:coc_diagnostic_info['information'] : ''
endfunction

function! LightLineCocOk() abort
  return b:coc_diagnostic_info['error'] == 0 &&
        \ b:coc_diagnostic_info['warning'] == 0 &&
        \ b:coc_diagnostic_info['information'] == 0 ?
        \ ' ' : ''
endfunction

function! LightLineQuickfixTitle() abort
  return exists("w:quickfix_title") ? w:quickfix_title : ""
endfunction

function! LightLineNoScrollbar() abort
  if has('nvim') || !IsInstalled("vim-noscrollbar")
    return ''
  endif
  return noscrollbar#statusline(20,'■','◫',['◧'],['◨'])
endfunction

function! LastSearchCount() abort
  let result = searchcount(#{recompute: 0})
  if empty(result)
    return ''
  endif
  if result.incomplete ==# 1     " timed out
    return printf(' /%s [?/??]', @/)
  elseif result.incomplete ==# 2 " max count exceeded
    if result.total > result.maxcount && result.current > result.maxcount
      return printf(' /%s [>%d/>%d]', @/, result.current, result.total)
    elseif result.total > result.maxcount
      return printf(' /%s [%d/>%d]', @/, result.current, result.total)
    endif
  endif
  return printf(' /%s [%d/%d]', @/, result.current, result.total)
endfunction

function! LightLineSearchCount() abort
  if has("nvim")
    return ""
  else
    return v:hlsearch ? LastSearchCount() : ""
  endif
endfunction

function! GinaStatus() abort
  if IsInstalled("gina.vim")
    let staged = gina#component#status#staged() ? gina#component#status#staged() : 0
    let unstaged = gina#component#status#unstaged() ? gina#component#status#unstaged() : 0
    let conflicted = gina#component#status#conflicted() ? gina#component#status#conflicted() : 0
    return printf(
          \ '[%s, %s, %s]',
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
