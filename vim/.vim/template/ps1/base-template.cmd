@echo off
pushd "%~dp0" > nul
set tm=%time: =0%
set ps1file=%~n0___%date:~-10,4%%date:~-5,2%%date:~-2,2%_%tm:~0,2%%tm:~3,2%%tm:~6,2%%tm:~9,2%.ps1
for /f "usebackq skip=10 delims=" %%i in ("%~f0") do @echo %%i >> "%ps1file%"
powershell -NoProfile -ExecutionPolicy unrestricted -File "%ps1file%" %*
del "%ps1file%"
popd > nul
pause
exit /b %ERRORLEVEL%
# ========== do ps1 file as a dosbatch ==========
# {{_name_}}
param($hoge = $(Read-Host "{{_cursor_}}"))

$ErrorActionPreference = "stop"
$DebugPreference = "SilentlyContinue" # Continue SilentlyContinue Stop Inquire

$commandPath = Split-Path -parent $myInvocation.MyCommand.path
$commandName = Split-Path -leaf $myInvocation.MyCommand.path
$commandBaseName = (gci $myInvocation.MyCommand.path).BaseName

Set-Location $commandPath

function main() {#{{{

  trap { Write-Host "[main]: Error $($_)"; break }


}#}}}

# call main
Measure-Command { main }
