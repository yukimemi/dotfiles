@echo off
if "%*"=="" ( 
  REM start "" gvim.exe --noplugin
  start "" gvim.exe
) else (
  REM start "" gvim.exe --noplugin --remote-tab-silent %*
  REM start "" gvim.exe --remote-tab-silent "%*"
  start "" gvim.exe --remote-silent "%*"
)
exit
