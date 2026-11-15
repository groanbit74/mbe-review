@echo off
setlocal
cd /d "%~dp0"
echo METAL BUILDING EDITOR - Windows x64
if not exist "runtime-lock.json" (
  echo Extract the complete package into a new folder before starting.
  pause
  exit /b 1
)
set "PSE=%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe"
if defined PROCESSOR_ARCHITEW6432 set "PSE=%SystemRoot%\Sysnative\WindowsPowerShell\v1.0\powershell.exe"
"%PSE%" -NoLogo -NoProfile -ExecutionPolicy Bypass -File "%~dp0Start Editor.ps1"
set "RESULT=%ERRORLEVEL%"
if not "%RESULT%"=="0" pause
exit /b %RESULT%
