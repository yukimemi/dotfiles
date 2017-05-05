@echo off

set PCD_CONFIG=%USERPROFILE%\.pcd

if "%1" equ "add" (
  if "%2" neq "" (
    echo %~dpf2>> "%PCD_CONFIG%"
    goto end
  )
  goto usage
)
if "%1" equ "edit" (
  goto edit
)
if "%1" neq "" (
  goto usage
)
goto query

:usage
echo %0 [add PATH ^| edit]
goto end

:edit
if "%EDITOR%" neq "" (
  "%EDITOR%" "%PCD_CONFIG%"
  goto end
)
notepad "%PCD_CONFIG%"
goto end

:query
rem NOTE:
rem
rem If you have a problem caused by character-set, modify below part like:
rem   'type ^"%USERPROFILE%\.pcd^" ^| iconv -f char -t utf-8 ^| peco --null'
rem
for /f "delims=" %%i in ('type ^"%PCD_CONFIG%^" ^| peco') do (
  cd /D %%i
  break
)

:end
