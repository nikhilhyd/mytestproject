@echo off

REM Change directory to your project folder
cd /d C:\Users\nikhi\Downloads\cicd\proj

REM Check if user passed a commit message
if "%~1"=="" (
    echo Usage: gitpush.bat "commit message"
    exit /b 1
)

set COMMIT_MSG=%~1

echo Adding files...
git add .

echo Committing with message: %COMMIT_MSG%
git commit -m "%COMMIT_MSG%"

echo Pushing to origin main...
git push origin main

echo Done!
pause
