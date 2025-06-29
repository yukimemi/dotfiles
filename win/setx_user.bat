@echo off
rem ============================================================================
rem File        : setx_user.bat
rem Author      : yukimemi
rem Last Change : 2025/06/21 21:49:11.
rem ============================================================================

rem setlocal enabledelayedexpansion
set tm=%time: =0%
set today=%date:~-10,4%%date:~-5,2%%date:~-2,2%
set nowtime=%tm:~0,2%%tm:~3,2%%tm:~6,2%%tm:~9,2%
set now=%today%_%nowtime%
set cmdDrive=%~d0
set cmdDir=%~dp0
set cmdFile=%~f0
set cmdName=%~n0
set cmdFileName=%~nx0

pushd "%cmdDir%"

set BATLOGPATH="%cmdDir%%cmdName%_%computername%_%now%.log"

rem call :main %* >> %BATLOGPATH% 2>&1
call :main %*

set exitCode=%errorlevel%

echo Exit Code: [%exitCode%]

pause
popd

exit /b %exitCode%

rem ============================================================================
:main

setx CARGO_NET_GIT_FETCH_WITH_CLI "true"
setx YAZI_FILE_ONE "C:\Program Files\Git\usr\bin\file.exe"

setx PATH "%USERPROFILE%\.cargo\bin;%USERPROFILE%\.deno\bin;%USERPROFILE%\.bun\bin;%USERPROFILE%\go\bin;%LOCALAPPDATA%\Local\Microsoft\WindowsApps;%LOCALAPPDATA%\Programs\Espanso;%APPDATA%\npm;%LOCALAPPDATA%\Microsoft\WindowsApps;%LOCALAPPDATA%\Microsoft\WinGet\Links;%LOCALAPPDATA%\mise\shims"

exit /b %errorlevel%

rem ============================================================================
:log
set msg=%*
set tm=%time: =0%
echo %date% %tm% %msg%
exit /b

