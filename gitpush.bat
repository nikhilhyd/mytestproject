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
REM Capture error level (0 = commit created, 1 = nothing to commit)
set COMMIT_RESULT=%ERRORLEVEL%

IF %COMMIT_RESULT% NEQ 0 (
    echo.
    echo ==============================
    echo No changes to commit. Skipping push.
    echo ==============================
    pause
    exit /b 0
)

echo.
echo Commit created successfully. Proceeding with push...

git push origin main

echo.
echo ==============================
echo Push completed.
echo ==============================
pause
