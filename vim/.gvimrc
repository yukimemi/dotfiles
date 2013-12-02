"=============================================================================
"    Description: .gvimrcサンプル設定
"         Author:
"  Last Modified: 0000-00-00 00:00
"        Version: 0.00
"=============================================================================
scriptencoding utf-8
"----------------------------------------
"システム設定
"----------------------------------------
"エラー時の音とビジュアルベルの抑制。
set noerrorbells
set novisualbell
set visualbell t_vb=

if has('multi_byte_ime') || has('xim')
    set iminsert=0 imsearch=0
    if has('xim') && has('GUI_GTK')
        "XIMの入力開始キー
        "set imactivatekey=C-space
    endif
endif

"IMEの状態をカラー表示
if has('multi_byte_ime')
    highlight Cursor guifg=NONE guibg=Green
    highlight CursorIM guifg=NONE guibg=Purple
endif

" ファイルタイプ別プラグイン設定
filetype on

" OS judge
let s:is_windows = has('win16') || has('win32') || has('win64')
let s:is_cygwin = has('win32unix')
let s:is_darwin = has('mac') || has('macunix') || has('gui_macvim')
let s:is_linux = !s:is_windows && !s:is_cygwin && !s:is_darwin

"----------------------------------------
" 表示設定
"----------------------------------------
"ツールバーを非表示
"set guioptions-=mT
set guioptions=none
"set guioptions+=r
"コマンドラインの高さ
set cmdheight=2

"カラー設定:
if s:is_darwin
    colorscheme molokai
    set background=dark
else
    " 輝度を高くする
    let g:solarized_visibility = "high"
    " コントラストを高くする
    let g:solarized_contrast = "high"
    set background=dark
    colorscheme solarized
endif
"source $HOME/.vim/bundle/Mark/plugin/mark.vim

"フォント設定
"フォントは英語名で指定すると問題が起きにくくなります
if has('xfontset')
    "  set guifontset=a14,r14,k14
elseif has('win32unix') || has('win64unix')
    set gfn=ＭＳ\ ゴシック\ 10
elseif has('gui_macvim')
    "   set gfn=Osaka-Mono:h10
    "	set guifontwide=Osaka:h12
    "   set gfn=しねきゃぷしょん:h14
    "set gfn=しねきゃぷしょん:h12
    "set gfn=Ricty\ Regular:h12
    "set gfn=しねきゃぷしょん:h12
    "set gfn=あんずもじ等幅:h12
    "set gfn=Osaka-Mono:h11
 	set gfn=Ricty\ Regular\ for\ Powerline:h12
    "set gfn=S2G-Uni-font:h12
    "set gfn=S2G-Luna-font:h13
    "set gfn=HuiFont:h12
    "set gfn=kiloji:h13
elseif has('unix')
    "   set gfn=Takaoゴシック\ 12
    "   set gfn=IPAゴシック\ 10
elseif has('win32') || has('win64')
    "  set gfn=ＭＳ\ ゴシック\ 10
    set guifont=MS_Gothic:h9:cSHIFTJIS
    "set guifont=MS_Gothic:h10:cSHIFTJIS
    "set guifont=メイリオ:h7:cSHIFTJIS
    "set gfn=Ricty\ Regular\ for\ Powerline:h8:w6
    "set guifontwide=Ricty:h8:w6
     "set gfn=あずきフォント:h8:cSHIFTJIS
     "set gfn=うずらフォント:h8:cSHIFTJIS
     "set gfn=S2Gうにフォント:h8:cSHIFTJIS
    set guifontwide=MS_Gothic:h9:cSHIFTJIS
    "set guifontwide=メイリオ:h7:cSHIFTJIS
endif


"印刷用フォント
if has('printer')
    if has('win32') || has('win64')
        "    set printfont=MS_Mincho:h12:cSHIFTJIS
        "    set printfont=MS_Gothic:h12:cSHIFTJIS
    endif
endif

" Macのみ
if has('mac')
    gui
    set transparency=7
    set antialias
elseif has('win32') || has('win64')
    gui
    set transparency=220
    augroup MyGUI
        autocmd!
        au GUIEnter * set lines=130 | set columns=120
    augroup END
endif

""""""""""""""""""""""""""""""
"Window位置の保存と復帰
""""""""""""""""""""""""""""""
if has('unix')
    let s:infofile = '~/.vim/.vimpos'
else
    let s:infofile = '~/_vimpos'
endif

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

augroup SaveWindowParam
    autocmd!
    execute 'autocmd SaveWindowParam VimLeave * call s:SaveWindowParam("'.s:infofile.'")'
augroup END

if filereadable(expand(s:infofile))
    execute 'source '.s:infofile
endif
unlet s:infofile

" 起動時サイズ指定
if has('win32') || has('win64')
    set lines=130
    set columns=120
    " Alt + ～ をシミュレート
    nnoremap [Space]r :<C-u>simalt ~r<CR>
    nnoremap [Space]x :<C-u>simalt ~x<CR>
endif

"起動時に最大化
"autocmd GUIEnter * simalt ~x
"autocmd BufEnter * macaction performZoom:
if has('mac')
    if has("gui_running")
        set fuoptions=maxvert,maxhorz
        au GUIEnter * set fullscreen
        "au GUIEnter * set lines=130 | set columns=120
    endif
elseif has('win32') || has('win64')
    if has("gui_running")
        "autocmd GUIEnter * simalt ~x
        "autocmd FileType vimfiler simalt ~x
        "autocmd BufLeave,BufHidden,BufDelete,VimLeave vimfiler simalt ~r<CR>
        "autocmd BufEnter * macaction performZoom:
    endif
endif
"----------------------------------------
"メニューアイテム作成
"----------------------------------------
silent! aunmenu &File.Save
silent! aunmenu &File.保存(&S)
silent! aunmenu &File.差分表示(&D)\.\.\.
let message_revert="再読込しますか?"
amenu <silent> 10.330 &File.再読込(&U)<Tab>:e!  :if confirm(message_revert, "&Yes\n&No")==1<Bar> e! <Bar> endif<CR>
amenu <silent> 10.331 &File.バッファ削除(&K)<Tab>:bd  :confirm bd<CR>
amenu <silent> 10.340 &File.保存(&W)<Tab>:w  :if expand('%') == ''<Bar>browse confirm w<Bar>else<Bar>confirm w<Bar>endif<CR>
amenu <silent> 10.341 &File.更新時保存(&S)<Tab>:update  :if expand('%') == ''<Bar>browse confirm w<Bar>else<Bar>confirm update<Bar>endif<CR>
amenu <silent> 10.400 &File.現バッファ差分表示(&D)<Tab>:DiffOrig  :DiffOrig<CR>
amenu <silent> 10.401 &File.裏バッファと差分表示(&D)<Tab>:Diff\ #  :Diff #<CR>
amenu <silent> 10.402 &File.差分表示(&D)<Tab>:Diff  :browse vertical diffsplit<CR>


