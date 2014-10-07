@echo off
REM {{{ env settings ===========================================
set THIS_FILE_PASS=%~dp0
set THIS_FILE_NAME=%~nx0
set tm=%time: =0%
set TODAY=%date:~-10,4%%date:~-5,2%%date:~-2,2%_%tm:~0,2%%tm:~3,2%%tm:~6,2%%tm:~9,2%

set GHQ_PATH=%USERPROFILE%\.ghq\src

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

REM check ghq
ghq -v
if errorlevel 1 (
  echo ERROR !!! ghq command not found !
  exit 1
)

REM =====================================================}}}

REM ghq
ghq get git://github.com/caisui/vimperator.git
ghq get git://gist.github.com/377348.git
ghq get git://github.com/vimpr/vimperator-rc.git
ghq get https://github.com/petitviolet/vimp-plugins
ghq get git://github.com/vimpr/vimperator-plugins.git
ghq get git://github.com/Jagua/vimperator-plugins-sample

REM vimperator
if exist "%USERPROFILE%\_vimperatorrc" rename "%USERPROFILE%\_vimperatorrc" "_vimperatorrc.bak_%TODAY%"
%LINKCMD_F% "%USERPROFILE%\_vimperatorrc" "%THIS_FILE_PASS%vimperator\.vimperatorrc"
if not exist "%USERPROFILE%\vimperator\plugin" mkdir "%USERPROFILE%\vimperator\plugin"
if exist "%USERPROFILE%\vimperator\plugin\plugin_loader.js" del "%USERPROFILE%\vimperator\plugin\plugin_loader.js"
%LINKCMD_F% "%USERPROFILE%\vimperator\plugin\plugin_loader.js" "%GHQ_PATH%\github.com\vimpr\vimperator-plugins\plugin_loader.js"
if exist "%USERPROFILE%\vimperator\colors" %RDCMD% "%USERPROFILE%\vimperator\colors"
%LINKCMD_D% "%USERPROFILE%\vimperator\colors" "%GHQ_PATH%\github.com\vimpr\vimperator-rc\anekos\colors

REM vim
if exist "%USERPROFILE%\.vimrc" rename "%USERPROFILE%\.vimrc" ".vimrc.bak_%TODAY%"
%LINKCMD_F% "%USERPROFILE%\.vimrc" "%THIS_FILE_PASS%vim\.vimrc"
if exist "%USERPROFILE%\.gvimrc" rename "%USERPROFILE%\.gvimrc" ".gvimrc.bak_%TODAY%"
%LINKCMD_F% "%USERPROFILE%\.gvimrc" "%THIS_FILE_PASS%vim\.gvimrc"
if exist "%USERPROFILE%\.vim" %RDCMD% "%USERPROFILE%\.vim"
%LINKCMD_D% "%USERPROFILE%\.vim" "%THIS_FILE_PASS%vim\.vim"

pause

