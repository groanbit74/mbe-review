@echo off
setlocal
cd /d "%~dp0"
set "PSE=%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe"
if defined PROCESSOR_ARCHITEW6432 set "PSE=%SystemRoot%\Sysnative\WindowsPowerShell\v1.0\powershell.exe"
"%PSE%" -NoLogo -NoProfile -ExecutionPolicy Bypass -File "%~dp0Start Editor.ps1" -Repair -SetupOnly
if errorlevel 1 pause
