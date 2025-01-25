@echo off

REM Hardcoded path for the installer directory in the sandbox
set "INSTALLER_DIR=C:\Users\WDAGUtilityAccount\default-setup"

REM Ensure TEMP directory exists
if not exist "C:\\Temp" (
    mkdir "C:\\Temp"
)

REM Log file
set LOG_FILE=C:\\Temp\\install_log.txt
echo Installation started at %date% %time% > "%LOG_FILE%"

REM Log the directory contents for debugging
echo Listing files in %INSTALLER_DIR% >> "%LOG_FILE%"
dir "%INSTALLER_DIR%" >> "%LOG_FILE%" 2>&1

REM Start WinRAR installation first and wait for completion
echo Starting WinRAR installation at %date% %time% >> "%LOG_FILE%"
start /wait "" "%INSTALLER_DIR%\\winrar-x64-701.exe" /s >> "%LOG_FILE%" 2>&1
echo Finished WinRAR installation at %date% %time% >> "%LOG_FILE%"

REM Start the rest of the installs sequentially with /wait for each
echo Starting Sublime Text installation at %date% %time% >> "%LOG_FILE%"
start /wait "" "%INSTALLER_DIR%\\sublime_text_build_4192_x64_setup.exe" /verysilent >> "%LOG_FILE%" 2>&1
echo Finished Sublime Text installation at %date% %time% >> "%LOG_FILE%"

echo Starting DB Browser for SQLite installation at %date% %time% >> "%LOG_FILE%"
start /wait "" msiexec /i "%INSTALLER_DIR%\\DB.Browser.for.SQLite-v3.13.1-win64.msi" /quiet /norestart >> "%LOG_FILE%" 2>&1
echo Finished DB Browser for SQLite installation at %date% %time% >> "%LOG_FILE%"

echo Starting Chrome installation at %date% %time% >> "%LOG_FILE%"
start /wait "" "%INSTALLER_DIR%\\ChromeStandaloneSetup64.exe" /silent /install >> "%LOG_FILE%" 2>&1
echo Finished Chrome installation at %date% %time% >> "%LOG_FILE%"

echo Starting Git installation at %date% %time% >> "%LOG_FILE%"
start /wait "" "%INSTALLER_DIR%\\Git-2.47.1.2-64-bit.exe" /verysilent >> "%LOG_FILE%" 2>&1
echo Finished Git installation at %date% %time% >> "%LOG_FILE%"

REM Start slower installers with /wait for each
echo Starting Visual Studio Code installation at %date% %time% >> "%LOG_FILE%"
start /wait "" "%INSTALLER_DIR%\\VSCodeUserSetup-x64-1.96.4.exe" /verysilent --no-welcome --no-update --user-data-dir "%TEMP%" >> "%LOG_FILE%" 2>&1
echo Finished Visual Studio Code installation at %date% %time% >> "%LOG_FILE%"

echo Starting Python installation at %date% %time% >> "%LOG_FILE%"
start /wait "" "%INSTALLER_DIR%\\python-3.12.8-amd64.exe" /quiet InstallAllUsers=1 PrependPath=1 >> "%LOG_FILE%" 2>&1
echo Finished Python installation at %date% %time% >> "%LOG_FILE%"

echo Starting JRE installation at %date% %time% >> "%LOG_FILE%"
start /wait "" "%INSTALLER_DIR%\\jre-8u441-windows-i586.exe" /s >> "%LOG_FILE%" 2>&1
echo Finished JRE installation at %date% %time% >> "%LOG_FILE%"

REM Finish
echo All installations completed at %date% %time% >> "%LOG_FILE%"
exit /b