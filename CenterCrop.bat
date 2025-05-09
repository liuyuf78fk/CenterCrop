@echo off
setlocal enabledelayedexpansion

set /p imageName=Please enter the image file name (in current folder, e.g., test.jpg): 
set /p width=Please enter the target width (e.g., 800): 
set /p height=Please enter the target height (e.g., 600): 

powershell -ExecutionPolicy Bypass -File CenterCrop.ps1 -InputFile "%imageName%" -TargetWidth %width% -TargetHeight %height%
pause
