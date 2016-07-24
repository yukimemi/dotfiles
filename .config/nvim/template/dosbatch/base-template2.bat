@echo off
setlocal enabledelayedexpansion
REM {{{ ä¬ã´ê›íË ===========================================
REM éûçè
set tm=%time: =0%
set TODAY=%date:~-10,4%%date:~-5,2%%date:~-2,2%_%tm:~0,2%%tm:~3,2%%tm:~6,2%%tm:~9,2%
set THIS_FILE_PASS=%~dp0
set THIS_FILE_NAME=%~nx0

echo %TODAY%
echo THIS_FILE_PASS=[%THIS_FILE_PASS%]
echo THIS_FILE_NAME=[%THIS_FILE_NAME%]
REM =====================================================}}}
