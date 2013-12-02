@echo off
pushd "%~dp0" > nul
set tm=%time: =0%
set ps1file=%~n0_%date:~-10,4%%date:~-5,2%%date:~-2,2%_%tm:~0,2%%tm:~3,2%%tm:~6,2%%tm:~9,2%.ps1
for /f "usebackq skip=10 delims=" %%i in ("%~f0") do @echo %%i >> "%ps1file%"
powershell -NoProfile -ExecutionPolicy unrestricted -File "%ps1file%" %*
del "%ps1file%"
popd > nul
pause
GOTO :EOF
# ========== do ps1 file as a dosbatch ==========

