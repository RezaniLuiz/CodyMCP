:: SPDX-License-Identifier: GPL-3.0-or-later
@echo off
setlocal
chcp 65001 >nul
title CodyMCP Bridge
cd /d "%~dp0"

echo.
echo   === CodyMCP Bridge ===
echo.

REM
echo   [1/3] Looking for Python...
set "PY="

REM 
where py >nul 2>nul && set "PY=py -3"
call :validate_py && goto :found

REM 
REM 
set "PY=python"
call :validate_py && goto :found

REM 
REM 
REM 
for %%R in (
    "%LOCALAPPDATA%\Programs\Python"
    "%ProgramFiles%"
    "%ProgramFiles(x86)%"
) do (
    if exist "%%~R" (
        for /f "delims=" %%D in ('dir /b /ad /o-n "%%~R\Python3*" 2^>nul') do (
            if exist "%%~R\%%D\python.exe" (
                set PY="%%~R\%%D\python.exe"
                call :validate_py && goto :found
            )
        )
    )
)

set "PY="
goto :need_install

:found
echo         Found: %PY%
goto :install_deps

:need_install
REM 
echo         Not found. Installing via winget...
echo.
winget install --id Python.Python.3.12 --source winget --accept-package-agreements --accept-source-agreements
echo.
echo   Checking again...
set "PY=py -3"
call :validate_py && goto :ready
set "PY=python"
call :validate_py && goto :ready
echo.
echo   ERROR: Python not found after install.
echo   Install manually: https://www.python.org/downloads/
echo   Tick "Add python.exe to PATH" then run this again.
echo.
pause
exit /b 1
:ready
echo         Python ready!

:install_deps
REM 
echo.
echo   [2/3] Checking websockets library...
%PY% -c "import websockets" >nul 2>nul
if errorlevel 1 (
    echo         Installing websockets - first time only...
    %PY% -m pip install --user websockets
    if errorlevel 1 (
        echo.
        echo   ERROR: Could not install websockets ^(see pip output above^).
        echo   Common causes: no internet, or Python has no working pip.
        echo   If you used the Microsoft Store python, install from
        echo   https://www.python.org/downloads/ instead ^(tick "Add to PATH"^).
        echo.
        pause
        exit /b 1
    )
)
echo         OK

REM 
echo.
echo   [3/3] Starting bridge...
REM 
for /f "tokens=5" %%a in ('netstat -aon ^| findstr :17613 ^| findstr LISTENING 2^>nul') do (
    taskkill /F /PID %%a >nul 2>nul
)
echo.
echo  ############################################################
echo  ##                                                        ##
echo  ##   KEEP THIS TERMINAL OPEN - DO NOT CLOSE THIS WINDOW ! ##
echo  ##                                                        ##
echo  ##   CodyMCP stops working if you close it. Just          ##
echo  ##   minimize this window and leave it running.           ##
echo  ##                                                        ##
echo  ############################################################
echo.
%PY% "%~dp0bridge.py"

echo.
echo   Bridge stopped. Press any key to close.
pause >nul
exit /b 0

REM 
REM 
REM 
REM 
REM 
REM 
REM 
:validate_py
%PY% -m pip --version >nul 2>nul || exit /b 1
%PY% -c "import sys; sys.exit(0 if sys.version_info >= (3, 9) else 1)" >nul 2>nul
exit /b %errorlevel%
