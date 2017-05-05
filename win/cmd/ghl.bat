@echo off

for /f "delims=" %%i in ('gsr --all ^| peco') do (
  cd /D %%i
  break
)

