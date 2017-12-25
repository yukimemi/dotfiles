@echo off
setlocal enabledelayedexpansion
REM ====================================================================== {{{1
set tm=%time: =0%
set today=%date:~-10,4%%date:~-5,2%%date:~-2,2%
set nowtime=%tm:~0,2%%tm:~3,2%%tm:~6,2%%tm:~9,2%
set now=%today%_%nowtime%
set cmdDir=%~dp0
set cmdFile=%~f0
set cmdName=%~n0
set cmdFileName=%~nx0
REM ======================================================================

pushd "%cmdDir%.."
set ROOT=%CD%\

set /p BASE_C=BASE_C:
set /p BASE_D=BASE_D:
set exitCode=%errorlevel%

rem set LINKCMD_F=mklink /h
set LINKCMD_F=mklink
set LINKCMD_D=mklink /d
set RDCMD=rd /s /q

rem Make symlink. {{{1
mkdir %BASE_C%\.cache > nul 2>&1
mkdir %BASE_C%\.cargo > nul 2>&1
mkdir %BASE_C%\.config > nul 2>&1
mkdir %BASE_D%\.ghq > nul 2>&1
mkdir %BASE_C%\.memolist > nul 2>&1
mkdir %BASE_C%\.rustup > nul 2>&1
mkdir %BASE_C%\.stack > nul 2>&1
mkdir %BASE_C%\.vim > nul 2>&1
mkdir %BASE_C%\app > nul 2>&1
mkdir %BASE_C%\bin > nul 2>&1
mkdir %BASE_C%\Documents > nul 2>&1
mkdir %BASE_C%\Downloads > nul 2>&1
mkdir %BASE_C%\Pictures > nul 2>&1
mkdir %BASE_C%\Desktop > nul 2>&1
%LINKCMD_D% "%USERPROFILE%\.cache" "%BASE_C%\.cache" > nul 2>&1
%LINKCMD_D% "%USERPROFILE%\.cargo" "%BASE_C%\.cargo" > nul 2>&1
%LINKCMD_D% "%USERPROFILE%\.config" "%BASE_C%\.config" > nul 2>&1
%LINKCMD_D% "%USERPROFILE%\.ghq" "%BASE_D%\.ghq" > nul 2>&1
%LINKCMD_D% "%USERPROFILE%\.memolist" "%BASE_C%\.memolist" > nul 2>&1
%LINKCMD_D% "%USERPROFILE%\.rustup" "%BASE_C%\.rustup" > nul 2>&1
%LINKCMD_D% "%USERPROFILE%\.stack" "%BASE_C%\.stack" > nul 2>&1
%LINKCMD_D% "%USERPROFILE%\.vim" "%BASE_C%\.vim" > nul 2>&1
%LINKCMD_D% "%USERPROFILE%\app" "%BASE_C%\app" > nul 2>&1
%LINKCMD_D% "%USERPROFILE%\bin" "%BASE_C%\bin" > nul 2>&1
%LINKCMD_D% "%USERPROFILE%\Documents" "%BASE_C%\Documents" > nul 2>&1
%LINKCMD_D% "%USERPROFILE%\Downloads" "%BASE_C%\Downloads" > nul 2>&1
%LINKCMD_D% "%USERPROFILE%\Pictures" "%BASE_C%\Pictures" > nul 2>&1
%LINKCMD_D% "%USERPROFILE%\Desktop" "%BASE_C%\Desktop" > nul 2>&1

rem VimFx {{{1
if exist "%USERPROFILE%\.config\vimfx" %RDCMD% "%USERPROFILE%\.config\vimfx"
%LINKCMD_D% "%USERPROFILE%\.config\vimfx" "%ROOT%.config\vimfx"

rem vim {{{1
if exist "%USERPROFILE%\.vimrc" del "%USERPROFILE%\.vimrc"
%LINKCMD_F% "%USERPROFILE%\.vimrc" "%ROOT%.config\nvim\init.vim"
if exist "%USERPROFILE%\.gvimrc" del "%USERPROFILE%\.gvimrc"
%LINKCMD_F% "%USERPROFILE%\.gvimrc" "%ROOT%.gvimrc"
if exist "%USERPROFILE%\.vim" %RDCMD% "%USERPROFILE%\.vim"
%LINKCMD_D% "%USERPROFILE%\.vim" "%ROOT%.config\nvim"

rem cmd {{{1
if exist "%USERPROFILE%\.init.cmd" del "%USERPROFILE%\.init.cmd"
%LINKCMD_F% "%USERPROFILE%\.init.cmd" "%ROOT%win\cmd\init.cmd"
if exist "%USERPROFILE%\bin\j.bat" del "%USERPROFILE%\bin\j.bat"
%LINKCMD_F% "%USERPROFILE%\bin\j.bat" "%ROOT%win\cmd\j.bat"
if exist "%USERPROFILE%\bin\ghl.bat" del "%USERPROFILE%\bin\ghl.bat"
%LINKCMD_F% "%USERPROFILE%\bin\ghl.bat" "%ROOT%win\cmd\ghl.bat"

rem stack {{{1
if exist "%USERPROFILE%\.stack" %RDCMD% "%USERPROFILE%\.stack"
%LINKCMD_D% "%USERPROFILE%\.stack" "%ROOT%.stack"

echo Exit Code: [%exitCode%]

pause
popd

exit /b %exitCode%

