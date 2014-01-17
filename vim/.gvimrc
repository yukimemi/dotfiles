"{{{ ========== Basics ================================================================
scriptencoding utf-8

" OS judge
let s:is_windows = has('win16') || has('win32') || has('win64')
let s:is_cygwin = has('win32unix')
let s:is_darwin = has('mac') || has('macunix') || has('gui_macvim')
let s:is_linux = !s:is_windows && !s:is_cygwin && !s:is_darwin

"===================================================================================}}}

"{{{ ========== Appearance ============================================================
" hide all
set guioptions=none

" color
if s:is_darwin
    colorscheme solarized
    let g:solarized_visibility = "high"
    let g:solarized_contrast = "high"
    set background=dark
else
    colorscheme solarized
    let g:solarized_visibility = "high"
    let g:solarized_contrast = "high"
    set background=dark
endif

" font
if s:is_windows
    set gfn=MS_Gothic:h9:cSHIFTJIS
    set guifontwide=MS_Gothic:h9:cSHIFTJIS
else
    set gfn=Ricty\ Regular\ for\ Powerline:h12
endif

" only mac
if s:is_darwin
    gui
    set transparency=10
    set antialias
elseif s:is_windows
    gui
    set transparency=220
    au MyAutoCmd GUIEnter * set lines=130 | set columns=120
endif

" save window position and restore
let s:infofile = '~/.vim/.vimpos'

function! s:SaveWindowParam(filename)
    redir => pos
    exec 'winpos'
    redir END
    let pos = matchstr(pos, 'X[-0-9 ]\+,\s*Y[-0-9 ]\+$')
    let file = expand(a:filename)
    let str = []
    let cmd = 'winpos '.substitute(pos, '[^-0-9 ]', '', 'g')
    cal add(str, cmd)
    let l = &lines
    let c = &columns
    cal add(str, 'set lines='. l.' columns='. c)
    silent! let ostr = readfile(file)
    if str != ostr
        call writefile(str, file)
    endif
endfunction

execute 'au MyAutoCmd VimLeave * call s:SaveWindowParam("'.s:infofile.'")'

if filereadable(expand(s:infofile))
    execute 'source '.s:infofile
endif
unlet s:infofile

" initiallize size
if s:is_windows
    set lines=130
    set columns=120
    " Alt + ï½¡¦
    nnoremap [Space]r :<C-u>simalt ~r<CR>
    nnoremap [Space]x :<C-u>simalt ~x<CR>
endif

" Maximize
"au MyAutoCmd GUIEnter * simalt ~x
"au MyAutoCmd BufEnter * macaction performZoom:

if s:is_darwin
    if has("gui_running")
        set fuoptions=maxvert,maxhorz
        "au MyAutoCmd GUIEnter * set fullscreen
    endif
elseif s:is_windows
    if has("gui_running")
        "au MyAutoCmd GUIEnter * simalt ~x
        "au MyAutoCmd FileType vimfiler simalt ~x
        "au MyAutoCmd BufLeave,BufHidden,BufDelete,VimLeave vimfiler simalt ~r<CR>
        "au MyAutoCmd BufEnter * macaction performZoom:
    endif
endif
"===================================================================================}}}
