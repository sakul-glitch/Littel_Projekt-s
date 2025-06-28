@echo off
setlocal enabledelayedexpansion

title LOG MANAGER TERMINAL
color 0A
set "logdir=Logs"
set "backupdir=Bb"

if not exist "%logdir%" mkdir "%logdir%"
if not exist "%backupdir%" mkdir "%backupdir%"

call :Loading "SYSTEM WIRD INITIALISIERT..."

:Menu
call :Loading "HAUPTMENÜ WIRD GELADEN..."
cls
echo ===================== LOG MANAGER TERMINAL =====================
echo.
echo [1] LOG ANZEIGEN
echo [2] NEUEN LOG ERSTELLEN
echo [3] LOG LÖSCHEN
echo [4] LOG BEARBEITEN (NOTEPAD)
echo [5] LOG UMBENENNEN
echo [6] BACKUP VERWALTEN
echo [7] WIEDERHERSTELLEN
echo [8] BEENDEN
echo ================================================================
set /p choice=Wähle Option 1–8: 

if "%choice%"=="1" goto ShowLog
if "%choice%"=="2" goto CreateLog
if "%choice%"=="3" goto DeleteLog
if "%choice%"=="4" goto EditLog
if "%choice%"=="5" goto RenameLog
if "%choice%"=="6" goto BackupMenu
if "%choice%"=="7" goto RestoreMenu
if "%choice%"=="8" exit
goto Menu

:ShowLog
call :Loading "LOGS WERDEN GELADEN..."
cls
dir /b "%logdir%\*.log" "%logdir%\*.txt"
echo.
set /p logname=Datei anzeigen: 
if not exist "%logdir%\%logname%" (
    echo Datei nicht gefunden!
    pause
    goto Menu
)
type "%logdir%\%logname%"
pause
goto Menu

:CreateLog
call :Loading "NEUER LOG WIRD ERSTELLT..."
cls
set /p logname=Neuer Dateiname (inkl. .log/.txt): 
if exist "%logdir%\%logname%" (
    echo Datei existiert bereits.
    pause
    goto Menu
)
echo %date% - %time% > "%logdir%\%logname%"
notepad "%logdir%\%logname%"
pause
goto Menu

:DeleteLog
call :Loading "LOG WIRD GELÖSCHT..."
cls
dir /b "%logdir%"
set /p filename=Datei zum Löschen: 
if not exist "%logdir%\%filename%" (
    echo Datei nicht gefunden.
    pause
    goto Menu
)
echo *** WARNUNG: DIE DATEI "%filename%" WIRD GELÖSCHT! ***
set /p confirm=Bist du sicher? (J/N): 
if /I "%confirm%"=="J" (
    del "%logdir%\%filename%"
    echo Datei gelöscht.
)
pause
goto Menu

:EditLog
call :Loading "LOG WIRD GEÖFFNET..."
cls
dir /b "%logdir%"
set /p logname=Datei zum Bearbeiten: 
if not exist "%logdir%\%logname%" (
    echo Datei nicht gefunden!
    pause
    goto Menu
)
notepad "%logdir%\%logname%"
pause
goto Menu

:RenameLog
call :Loading "LOG WIRD UMBENANNT..."
cls
dir /b "%logdir%"
set /p oldname=Alter Name: 
if not exist "%logdir%\%oldname%" (
    echo Datei nicht gefunden.
    pause
    goto Menu
)
set /p newname=Neuer Name: 
rename "%logdir%\%oldname%" "%newname%"
echo Umbenannt zu "%newname%"
pause
goto Menu

:BackupMenu
call :Loading "BACKUP-MODUL WIRD GELADEN..."
cls
echo ===== BACKUP MENÜ =====
echo [1] ALLE LOGS BACKUPEN
echo [2] EINZELNE DATEI BACKUPEN
echo [3] ALLE BACKUPS LÖSCHEN
echo [4] ZURÜCK
set /p bopt=Option: 
if "%bopt%"=="1" goto BackupAll
if "%bopt%"=="2" goto BackupSingle
if "%bopt%"=="3" goto DeleteBackups
if "%bopt%"=="4" goto Menu
goto BackupMenu

:BackupAll
call :Loading "SICHERE ALLE DATEIEN..."
cls
for %%f in ("%logdir%\*.log") do call :BackupFile "%%f"
for %%f in ("%logdir%\*.txt") do call :BackupFile "%%f"
echo Backup abgeschlossen.
pause
goto BackupMenu

:BackupSingle
call :Loading "EINZELNE DATEI SICHERN..."
cls
dir /b "%logdir%"
set /p file=Datei: 
if not exist "%logdir%\%file%" (
    echo Datei nicht gefunden.
    pause
    goto BackupMenu
)
call :BackupFile "%logdir%\%file%"
pause
goto BackupMenu

:BackupFile
call :Loading "BACKUP LÄUFT..."
set "src=%~1"
set "dst=%backupdir%\%~nx1"
copy "%src%" "%dst%" >nul
echo Gesichert: %~nx1 → %dst%
exit /b

:DeleteBackups
call :Loading "ALLE BACKUPS LÖSCHEN..."
cls
echo *** WARNUNG: ALLE BACKUPS WERDEN GELÖSCHT! ***
set /p confirm=Sicher? (J/N): 
if /I "%confirm%"=="J" (
    del /q "%backupdir%\*.*"
    echo Alle Backups gelöscht.
)
pause
goto BackupMenu

:RestoreMenu
call :Loading "WIEDERHERSTELLUNG..."
cls
dir /b "%backupdir%"
set /p file=Datei zum Wiederherstellen: 
if not exist "%backupdir%\%file%" (
    echo Datei nicht gefunden!
    pause
    goto Menu
)
set /p newname=Speichern als: 
copy "%backupdir%\%file%" "%logdir%\%newname%"
echo Wiederhergestellt.
pause
goto Menu

:Loading
cls
setlocal EnableDelayedExpansion
set "msg=%~1"
set "bar="
set /a steps=40
for /L %%i in (1,1,!steps!) do (
    set "bar=!bar!="
    cls
    echo.
    echo #L=O=A=D=I=N=G#
    echo !msg!
    echo [!bar!]
    ping localhost -n 1 >nul
)
endlocal
exit /b
