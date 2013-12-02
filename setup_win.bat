@echo off
REM {{{ 環境設定 ===========================================
set THIS_FILE_PASS=%~dp0
set THIS_FILE_NAME=%~nx0
set tm=%time: =0%
set TODAY=%date:~-10,4%%date:~-5,2%%date:~-2,2%_%tm:~0,2%%tm:~3,2%%tm:~6,2%%tm:~9,2%

REM cygwinのパス
REM set CYGWIN_PATH=%USERPROFILE%\cygwin
set CYGWIN_PATH=C:\cygwin
set CYGWIN_HOME=%CYGWIN_PATH%\home\%USERNAME%

echo THIS_FILE_PASS=[%THIS_FILE_PASS%]
echo THIS_FILE_NAME=[%THIS_FILE_NAME%]

REM コマンド
REM OS判定
for /f "tokens=1-3" %%i in ('ver') do set os=%%k
if "%os%"=="XP" (
    set LINKCMD_F=fsutil hardlink create
    set LINKCMD_D=junction
    set RDCMD=junction -d
) else (
    set LINKCMD_F=mklink /h
    set LINKCMD_D=mklink /d
    set RDCMD=rd /s /q
)

REM =====================================================}}}


REM vimperator
if exist "%USERPROFILE%\_vimperatorrc" rename "%USERPROFILE%\_vimperatorrc" "_vimperatorrc.bak_%TODAY%"
%LINKCMD_F% "%USERPROFILE%\_vimperatorrc" "%THIS_FILE_PASS%vimperator\.vimperatorrc"
if not exist "%USERPROFILE%\vimperator\plugin" mkdir "%USERPROFILE%\vimperator\plugin"
git clone git://github.com/caisui/vimperator.git "%USERPROFILE%\vimperator\caisui"
git clone git://gist.github.com/377348.git "%USERPROFILE%\vimperator\377348"
git clone git://github.com/vimpr/vimperator-plugins.git "%USERPROFILE%\vimperator\vimperator-plugins"
git clone git://github.com/vimpr/vimperator-rc.git "%USERPROFILE%\vimperator\vimperator-rc"
if exist "%USERPROFILE%\vimperator\plugin\plugin_loader.js" del "%USERPROFILE%\vimperator\plugin\plugin_loader.js"
%LINKCMD_F% "%USERPROFILE%\vimperator\plugin\plugin_loader.js" "%USERPROFILE%\vimperator\vimperator-plugins\plugin_loader.js"
if exist "%USERPROFILE%\vimperator\colors" %RDCMD% "%USERPROFILE%\vimperator\colors"
%LINKCMD_D% "%USERPROFILE%\vimperator\colors" "%USERPROFILE%\vimperator\vimperator-rc\anekos\colors"

REM cfiler
if not exist "%APPDATA%\CraftFiler" (
    mkdir "%APPDATA%\CraftFiler"
) else (
    if exist "%APPDATA%\CraftFiler\config.py" rename "%APPDATA%\CraftFiler\config.py" "config.py.bak_%TODAY%"
    %LINKCMD_F% "%APPDATA%\CraftFiler\config.py" "%THIS_FILE_PASS%win\CraftFiler\config.py"
    if exist "%APPDATA%\CraftFiler\cfiler.ini" rename "%APPDATA%\CraftFiler\cfiler.ini" "cfiler.ini_%TODAY%"
    %LINKCMD_F% "%APPDATA%\CraftFiler\cfiler.ini" "%THIS_FILE_PASS%win\CraftFiler\cfiler.ini"
)

REM clnch
if not exist "%APPDATA%\CraftLaunch" (
    mkdir "%APPDATA%\CraftLaunch"
) else (
    if exist "%APPDATA%\CraftLaunch\config.py" rename "%APPDATA%\CraftLaunch\config.py" "config.py.bak_%TODAY%"
    %LINKCMD_F% "%APPDATA%\CraftLaunch\config.py" "%THIS_FILE_PASS%win\CraftLaunch\config.py"
    if exist "%APPDATA%\CraftLaunch\clnch.ini" rename "%APPDATA%\CraftLaunch\clnch.ini" "clnch.ini.bak_%TODAY%"
    %LINKCMD_F% "%APPDATA%\CraftLaunch\clnch.ini" "%THIS_FILE_PASS%win\CraftLaunch\clnch.ini"
    git clone git@github.com:yuyunko/clnch3_extensions.git "%APPDATA%\CraftLaunch\clnch3_extensions"
)

REM AutoHotkey
if exist "%USERPROFILE%\My Documents\AutoHotkey.ahk" (
    rename "%USERPROFILE%\My Documents\AutoHotkey.ahk" "AutoHotkey.ahk.bak_%TODAY%"
    %LINKCMD_F% "%USERPROFILE%\My Documents\AutoHotkey.ahk" "%THIS_FILE_PASS%win\AutoHotkey\AutoHotkey.ahk"
) else (
    rename "%USERPROFILE%\Documents\AutoHotkey.ahk" "AutoHotkey.ahk.bak_%TODAY%"
    %LINKCMD_F% "%USERPROFILE%\Documents\AutoHotkey.ahk" "%THIS_FILE_PASS%win\AutoHotkey\AutoHotkey.ahk"
)

REM vim
if exist "%USERPROFILE%\.vimrc" rename "%USERPROFILE%\.vimrc" ".vimrc.bak_%TODAY%"
%LINKCMD_F% "%USERPROFILE%\.vimrc" "%THIS_FILE_PASS%vim\.vimrc"
if exist "%USERPROFILE%\.gvimrc" rename "%USERPROFILE%\.gvimrc" ".gvimrc.bak_%TODAY%"
%LINKCMD_F% "%USERPROFILE%\.gvimrc" "%THIS_FILE_PASS%vim\.gvimrc"
if exist "%USERPROFILE%\.vim" %RDCMD% "%USERPROFILE%\.vim"
%LINKCMD_D% "%USERPROFILE%\.vim" "%THIS_FILE_PASS%vim\.vim"

REM for cygwin
if exist "%CYGWIN_HOME%\.vimrc" rename "%CYGWIN_HOME%\.vimrc" ".vimrc.bak_%TODAY%"
%LINKCMD_F% "%CYGWIN_HOME%\.vimrc" "%THIS_FILE_PASS%vim\.vimrc"
if exist  "%CYGWIN_HOME%\.vim" %RDCMD% "%CYGWIN_HOME%\.vim"
%LINKCMD_D% "%CYGWIN_HOME%\.vim" "%THIS_FILE_PASS%vim\.vim"

REM zsh
if exist "%CYGWIN_HOME%\.zshrc" rename "%CYGWIN_HOME%\.zshrc" ".zshrc.bak_%TODAY%"
%LINKCMD_F% "%CYGWIN_HOME%\.zshrc" "%CYGWIN_HOME%\.oh-my-zsh\templates\zshrc.zsh-template"
if exist "%CYGWIN_HOME%\.zshenv" rename "%CYGWIN_HOME%\.zshenv" ".zshenv.bak_%TODAY%"
%LINKCMD_F% "%CYGWIN_HOME%\.zshenv" "%THIS_FILE_PASS%zsh\.zshenv"

REM screenrc
if exist "%CYGWIN_HOME%\.screenrc" rename "%CYGWIN_HOME%\.screenrc" ".screenrc.bak_%TODAY%"
%LINKCMD_F% "%CYGWIN_HOME%\.screenrc" "%THIS_FILE_PASS%.screenrc_win"

REM mintty
if exist "%CYGWIN_HOME%\.minttyrc" rename "%CYGWIN_HOME%\.minttyrc" ".minttyrc.bak_%TODAY%"
%LINKCMD_F% "%CYGWIN_HOME%\.minttyrc" "%THIS_FILE_PASS%.minttyrc"

REM git
git config --global user.name 'yuyunko'
git config --global user.email 'i.xxxxxxxxxxxxx.13@gmail.com'
git config --global github.user 'yuyunko'
REM git config --global push.default simple
git config --global color.diff auto
REM alias
git config --global alias.ci commit
git config --global alias.co checkout
git config --global alias.st status
