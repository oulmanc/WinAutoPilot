#------------------------------------------------------------------------------
# Forces the script to be run as admin.
#------------------------------------------------------------------------------
WRITE-HOST " "

#The below code is to force the script to run as adamin.
If (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator"))
{   
#"No Administrative rights, it will display a popup window asking user for Admin rights"

$arguments = "& '" + $myinvocation.mycommand.definition + "'"
Start-Process "$psHome\powershell.exe" -Verb runAs -ArgumentList $arguments

break
}

#------------------------------------------------------------------------------
# Forces the script to run itself in its current directory.
#------------------------------------------------------------------------------
#The below code is to force the powershell prompt into the directory of the script. 
$scriptpath = $MyInvocation.MyCommand.Path
$dir = Split-Path $scriptpath
WRITE-HOST "This Script's Directory Is $dir"
set-location $dir

#------------------------------------------------------------------------------
# Create a new folder in the C drive for the CSV file.
#------------------------------------------------------------------------------
# If you are creating a self-contained USB comment these lines out.

New-Item -Type Directory -Path "C:\HWID"
Write-Host -ForegroundColor Green "Creating HWID folder in C drive"
Write-Host ""
Write-Host ""

#------------------------------------------------------------------------------
# Change to the new folder.
#------------------------------------------------------------------------------
# You can set the path to "HWID" if want to create a self-contained USB.
Set-Location -Path "C:\HWID"
Write-Host -ForegroundColor Green "Changing to new folder"
Write-Host ""
Write-Host ""

$env:Path += "C:\Program Files\WindowsPowerShell\Scripts"
Set-ExecutionPolicy -Scope Process -ExecutionPolicy RemoteSigned

#------------------------------------------------------------------------------
# Install the script from online.
#------------------------------------------------------------------------------

Write-Host -ForegroundColor Cyan "Getting the script from Microsoft"
Write-Host ""
Write-Host ""
Install-Script -Name Get-WindowsAutoPilotInfo

#------------------------------------------------------------------------------
# Export the CSV file.
#------------------------------------------------------------------------------

$serial = (Get-CimInstance -CimSession (New-CimSession) -Class Win32_BIOS).SerialNumber
Get-WindowsAutoPilotInfo -OutputFile "AutoPilotHWID-$serial.csv"
