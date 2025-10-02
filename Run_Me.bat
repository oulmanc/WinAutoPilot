@echo off
cd /d %~dp0
Color c0

ECHO *****************************************************************************
ECHO *   THIS SCRIPT WILL GATHER THE HARDWARE HASH FROM THIS DEVICE              * 
ECHO *   NOTE: THIS SCRIPT WILL NOT FUNCTION UNLESS IT IS RUN AS ADMINISTRATOR   *    
ECHO *****************************************************************************

ECHO Are you sure you want to run this script? 

Set /P A=[Y/N]:

IF /I %A%==Y GOTO YES
IF /I %A%==N GOTO NO

:NO
Pause
Exit

:YES
color 0f
powershell.exe -Command "Unblock-File '%~dp0\GetDeviceInfo.ps1'"
start powershell.exe -executionpolicy RemoteSigned -file "%~dp0\GetDeviceInfo.ps1"
exit
