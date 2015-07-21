set background=light
hi clear
if exists("syntax_on")
syntax reset
endif
let colors_name = "sakura"
"hi Normal       guifg=#000000 guibg=#F8F3E3
hi Normal       guifg=#000000 guibg=#FFFBF0
hi IncSearch    gui=UNDERLINE guifg=#000000 guibg=#40ffff
hi Search       gui=NONE guifg=NONE guibg=lightyellow
hi ErrorMsg     gui=BOLD guifg=#ffffff guibg=#ff3333
hi WarningMsg   gui=BOLD guifg=#ffffff guibg=#ff3333
hi ModeMsg      gui=NONE guifg=#0070ff guibg=NONE
hi MoreMsg      gui=NONE guifg=#a800ff guibg=NONE
hi Question     gui=NONE guifg=#008050 guibg=NONE
hi StatusLine   gui=BOLD guifg=#f8f8f8 guibg=#505085
hi StatusLineNC gui=BOLD guifg=#a0a0b0 guibg=#505085
hi VertSplit    gui=NONE guifg=#f8f8f8 guibg=#303040
hi Visual       gui=NONE guifg=#404060 guibg=#dddde8
hi DiffText     gui=NONE guifg=#7800ff guibg=#e0d8ff
hi DiffChange   gui=NONE guifg=#dd0000 guibg=#ffe0f0
hi DiffDelete   gui=BOLD guifg=#0000ff guibg=#ccccff
hi DiffAdd      gui=NONE guifg=#000060 guibg=#d8d8ff
hi Cursor guibg=Sys_Highlight guifg=Sys_HighlightText
hi CursorIM     gui=NONE guifg=#000000 guibg=#8000ff
hi Folded       gui=NONE guifg=#000099 guibg=#eef3ff
hi FoldColumn   gui=NONE guifg=#aa60ff guibg=#f0f0f4
hi Directory    gui=NONE guifg=#0000ff guibg=NONE
hi LineNr       gui=NONE guifg=#0000FF guibg=#EFEFEF
hi NonText      gui=BOLD guifg=#0000ff guibg=#efebe0
hi SpecialKey   gui=NONE guifg=#009060 guibg=NONE
hi Title        gui=NONE guifg=#004060 guibg=#c8f0f8
hi WildMenu     gui=BOLD guifg=#f8f8f8 guibg=#00aacc
" Groups for syntax highlighting
hi Comment      gui=NONE guifg=#157030 guibg=NONE
hi Constant     gui=NONE guifg=#CC3300 guibg=#ffeeee
hi Special      gui=NONE guifg=#005252 guibg=#c6f6e6
hi Identifier   gui=NONE guifg=#993300 guibg=NONE
hi Statement    gui=BOLD guifg=#0000f0 guibg=NONE
hi PreProc      gui=BOLD guifg=#CC3333 guibg=NONE
hi Type         gui=BOLD guifg=#0000cc guibg=NONE
hi Todo         gui=NONE guifg=#ff0070 guibg=#ffe0f4
hi Ignore       gui=NONE guifg=#f8f8f8 guibg=NONE
hi Error        gui=BOLD guifg=#ffffff guibg=#ff3333
" HTML
hi htmlLink                 gui=UNDERLINE
hi htmlBoldUnderline        gui=BOLD
hi htmlBoldItalic           gui=BOLD
hi htmlBold                 gui=BOLD
hi htmlTag                  gui=NONE       guifg=#0000ff
hi htmlEndTag               gui=NONE       guifg=#0000ff
hi htmlBoldUnderlineItalic  gui=BOLD
hi htmlUnderlineItalic      gui=UNDERLINE
hi htmlUnderline            gui=UNDERLINE
hi htmlItalic               gui=italic
" Special
hi helpExample gui=NONE guifg=#0040ff guibg=NONE
