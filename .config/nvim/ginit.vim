" Enable Mouse
set mouse=a

" Set Editor Font
if exists(':GuiFont')
  " GuiFont! Cica:h10
  GuiFont! HackGen Console NF:h10
endif

" Disable GUI Tabline
if exists(':GuiTabline')
  GuiTabline 0
endif

" Disable GUI Popupmenu
if exists(':GuiPopupmenu')
  GuiPopupmenu 0
endif

" Enable GUI ScrollBar
if exists(':GuiScrollBar')
  GuiScrollBar 0
endif

if exists(':GuiWindowOpacity')
  GuiWindowOpacity 0.9
endif

if exists(':GuiAdaptiveFont')
  GuiAdaptiveFont 1
endif

if exists(':GuiAdaptiveColor')
  GuiAdaptiveColor 1
endif

if exists(':GuiAdaptiveStyle')
  GuiAdaptiveStyle Fusion
endif

if exists('g:fvim_loaded')
  set gfn=Cica:h13
  set gfw=Cica:h13

  " Ctrl-ScrollWheel for zooming in/out
  nnoremap <silent> <C-ScrollWheelUp> :set guifont=+<CR>
  nnoremap <silent> <C-ScrollWheelDown> :set guifont=-<CR>
  nnoremap <A-CR> :FVimToggleFullScreen<CR>

  " Cursor tweaks
  " FVimCursorSmoothMove v:true
  " FVimCursorSmoothBlink v:true

  " Background composition
  FVimBackgroundComposition 'transparent'
  FVimBackgroundOpacity 0.90
  " FVimBackgroundAltOpacity 0.85         " value between 0 and 1, non-default bg opacity.
  " FVimBackgroundImage 'C:/foobar.png'   " background image
  " FVimBackgroundImageVAlign 'center'    " vertial position, 'top', 'center' or 'bottom'
  " FVimBackgroundImageHAlign 'center'    " horizontal position, 'left', 'center' or 'right'
  " FVimBackgroundImageStretch 'fill'     " 'none', 'fill', 'uniform', 'uniformfill'
  " FVimBackgroundImageOpacity 0.85       " value between 0 and 1, bg image opacity

  " Title bar tweaks
  " FVimCustomTitleBar v:true             " themed with colorscheme

  " Debug UI overlay
  " FVimDrawFPS v:false

  " Font tweaks
  " FVimFontAntialias v:true
  " FVimFontAutohint v:true
  " FVimFontHintLevel 'full'
  " FVimFontLigature v:true
  " FVimFontLineHeight '+1.0' " can be 'default', '14.0', '-1.0' etc.
  " FVimFontSubpixel v:true
  " FVimFontNoBuiltinSymbols v:true " Disable built-in Nerd font symbols

  " Try to snap the fonts to the pixels, reduces blur
  " in some situations (e.g. 100% DPI).
  " FVimFontAutoSnap v:true

  " Font weight tuning, possible valuaes are 100..900
  " FVimFontNormalWeight 400
  " FVimFontBoldWeight 700

  " Font debugging -- draw bounds around each glyph
  " FVimFontDrawBounds v:true

  " UI options (all default to v:false)
  " FVimUIPopupMenu v:true      " external popup menu
  " FVimUIWildMenu v:false      " external wildmenu -- work in progress

  " Keyboard mapping options
  " FVimKeyDisableShiftSpace v:true " disable unsupported sequence <S-Space>
  " FVimKeyAutoIme v:true           " Automatic input method engagement in Insert mode
  " FVimKeyAltGr v:true             " Recognize AltGr. Side effect is that <C-A-Key> is then impossible

  " Default options (workspace-agnostic)
  " FVimDefaultWindowWidth 1600     " Default window size in a new workspace
  " FVimDefaultWindowHeight 900

  " Detach from a remote session without killing the server
  " If this command is executed on a standalone instance,
  " the embedded process will be terminated anyway.
  " FVimDetach

  " =========== BREAKING CHANGES -- the following commands are disabled ============
  " FVimUIMultiGrid v:true     -- per-window grid system -- done and enabled by default
  " FVimUITabLine v:false      -- external tabline -- not implemented
  " FVimUICmdLine v:false      -- external cmdline -- not implemented
  " FVimUIMessages v:false     -- external messages -- not implemented
  " FVimUITermColors v:false   -- not implemented
  " FVimUIHlState v:false      -- not implemented

endif

" Right Click Context Menu (Copy-Cut-Paste)
nnoremap <silent><RightMouse> :call GuiShowContextMenu()<CR>
inoremap <silent><RightMouse> <Esc>:call GuiShowContextMenu()<CR>
xnoremap <silent><RightMouse> :call GuiShowContextMenu()<CR>gv
snoremap <silent><RightMouse> <C-G>:call GuiShowContextMenu()<CR>gv


