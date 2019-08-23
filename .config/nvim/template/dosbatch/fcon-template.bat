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

set base=%cmdDir%..

pushd "%cmdDir%"

set cfg=%base%\cfg
set fcon=%base%\src\fcon.ps1

rem ƒtƒ@ƒCƒ‹–¼‚æ‚ècfgFileName‚ÆtaskIdŽæ“¾
for /f "tokens=1,2 delims=-" %%i in ("%cmdName%") do (
  set cfgFileName=%%i.xml
  set taskId=%%j
)

if "%taskId%"=="" set taskId=Startup

echo powershell -ExecutionPolicy ByPass %fcon% %cfg%\%cfgFileName% %taskId%
powershell -ExecutionPolicy ByPass %fcon% %cfg%\%cfgFileName% %taskId%
set exitCode=%errorlevel%

{{_cursor_}}

echo Exit. [ExitCode: %exitCode%]

pause
popd

exit /b %exitCode%


