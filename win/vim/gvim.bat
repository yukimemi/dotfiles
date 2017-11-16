@echo off
if "%*"=="" ( 
  REM start "" gvim.exe --noplugin
  start "" gvim.exe
) else (
  start "" gvim.exe --remote-tab-silent "%*"
)
exit
