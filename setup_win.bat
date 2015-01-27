@echo off
REM {{{ env settings ===========================================
set THIS_FILE_PASS=%~dp0
set THIS_FILE_NAME=%~nx0
set tm=%time: =0%
set TODAY=%date:~-10,4%%date:~-5,2%%date:~-2,2%_%tm:~0,2%%tm:~3,2%%tm:~6,2%%tm:~9,2%

set GHQ_HOME=%USERPROFILE%\.ghq\src

echo THIS_FILE_PASS=[%THIS_FILE_PASS%]
echo THIS_FILE_NAME=[%THIS_FILE_NAME%]

REM judge OS
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
if exist "%USERPROFILE%\_vimperatorrc" del "%USERPROFILE%\_vimperatorrc"
%LINKCMD_F% "%USERPROFILE%\_vimperatorrc" "%THIS_FILE_PASS%vimperator\.vimperatorrc"
if not exist "%USERPROFILE%\vimperator\plugin" mkdir "%USERPROFILE%\vimperator\plugin"
if exist "%USERPROFILE%\vimperator\plugin\plugin_loader.js" del "%USERPROFILE%\vimperator\plugin\plugin_loader.js"
%LINKCMD_F% "%USERPROFILE%\vimperator\plugin\plugin_loader.js" "%GHQ_HOME%\github.com\vimpr\vimperator-plugins\plugin_loader.js"
if exist "%USERPROFILE%\vimperator\colors" %RDCMD% "%USERPROFILE%\vimperator\colors"
%LINKCMD_D% "%USERPROFILE%\vimperator\colors" "%GHQ_HOME%\github.com\vimpr\vimperator-rc\anekos\colors"

REM vim
if exist "%USERPROFILE%\.vimrc" del "%USERPROFILE%\.vimrc"
%LINKCMD_F% "%USERPROFILE%\.vimrc" "%THIS_FILE_PASS%vim\.vimrc"
if exist "%USERPROFILE%\.gvimrc" del "%USERPROFILE%\.gvimrc"
%LINKCMD_F% "%USERPROFILE%\.gvimrc" "%THIS_FILE_PASS%vim\.gvimrc"
if exist "%USERPROFILE%\.vim" %RDCMD% "%USERPROFILE%\.vim"
%LINKCMD_D% "%USERPROFILE%\.vim" "%THIS_FILE_PASS%vim\.vim"

REM zsh
REM if exist "%CYGWIN_HOME%\.zshrc" rename "%CYGWIN_HOME%\.zshrc" ".zshrc.bak_%TODAY%"
REM %LINKCMD_F% "%CYGWIN_HOME%\.zshrc" "%CYGWIN_HOME%\.oh-my-zsh\templates\zshrc.zsh-template"
REM if exist "%CYGWIN_HOME%\.zshenv" rename "%CYGWIN_HOME%\.zshenv" ".zshenv.bak_%TODAY%"
REM %LINKCMD_F% "%CYGWIN_HOME%\.zshenv" "%THIS_FILE_PASS%zsh\.zshenv"

REM screenrc
REM if exist "%CYGWIN_HOME%\.screenrc" rename "%CYGWIN_HOME%\.screenrc" ".screenrc.bak_%TODAY%"
REM %LINKCMD_F% "%CYGWIN_HOME%\.screenrc" "%THIS_FILE_PASS%.screenrc"

REM mintty
REM if exist "%CYGWIN_HOME%\.minttyrc" rename "%CYGWIN_HOME%\.minttyrc" ".minttyrc.bak_%TODAY%"
REM %LINKCMD_F% "%CYGWIN_HOME%\.minttyrc" "%THIS_FILE_PASS%.minttyrc"
REM if exist "%CYGWIN_HOME%\.inputrc" rename "%CYGWIN_HOME%\.inputrc" ".inputrc.bak_%TODAY%"
REM %LINKCMD_F% "%CYGWIN_HOME%\.inputrc" "%THIS_FILE_PASS%.inputrc"
REM if exist "%CYGWIN_HOME%\.bashrc" rename "%CYGWIN_HOME%\.bashrc" ".bashrc.bak_%TODAY%"
REM %LINKCMD_F% "%CYGWIN_HOME%\.bashrc" "%THIS_FILE_PASS%.bashrc"

pause
