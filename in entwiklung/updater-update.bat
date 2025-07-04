@echo off
color 0a
title Littel_Projekt-s - Update-Check Skript.
cls

REM TODO: -info
REM Dieses Script prüft deine lokale Version, vergleicht sie mit der Online-Version und lädt ggf. das Update.
REM Im Anschluss kannst du verschiedene Tools updaten oder zur Projektseite wechseln.
REM Animierte Begrüßung sorgt für Freude beim Start! :)

REM ====== KONFIGURATION ======================
set "LOCAL_VERSION=1.3.5"
set "REPO_OWNER=sakul-glitch"
set "REPO_NAME=Littel_Projekt-s"
set "BRANCH=main"
set "VERSION_FILE=version.txt"
set "DOWNLOAD_URL=https://github.com/sakul-glitch/Littel_Projekt-s"
set "RAW_URL=https://github.com/sakul-glitch/Littel_Projekt-s"


:start
REM ====== KOPFZEILE ==========================
echo.
echo ==========================================
echo   Littel_Projekt-s - Update-Check Skript
echo ==========================================
echo.
echo Deine lokale Version: %LOCAL_VERSION%
echo.
echo Pruefe Online-Version...
echo.
echo Hinweis: Dieses Skript prüft die neueste Version von GitHub.
echo.
echo powershell wird verwendet, um die neueste Version abzurufen.
echo.
echo bitte nicht unterbrechen, das Skript benötigt eine Internetverbindung.
echo.
echo und bitte nicht das Skript schließen, es wird automatisch fortgesetzt.
echo.
echo und bitte nicht erschrecken, wenn du powershell siehst, das ist normal.
echo.
REM viel zu viel kontext... aber ich mag es, wenn es freundlich ist und der Nutzer weiß, was passiert!
timeout /t 12 >nul

REM ====== ONLINE-VERSION ABRUFEN =============

set "ONLINE_VERSION="
for /f "delims=" %%v in ('powershell -Command "try { Invoke-WebRequest -Uri '%RAW_URL%' -UseBasicParsing -ErrorAction Stop | Select-Object -ExpandProperty Content } catch {''}"') do set "ONLINE_VERSION=%%v"
for /f "tokens=* delims= " %%a in ("%ONLINE_VERSION%") do set "ONLINE_VERSION=%%a"
goto :MENU

if "%ONLINE_VERSION%"=="" 
    echo.
    echo [FEHLER] Konnte keine Online-Version abrufen!
    echo.
    echo Bitte stelle sicher, dass du eine Internetverbindung hast.
    echo.
    echo Wenn du offline bist, kannst du die neueste Version manuell herunterladen.
    echo.
    echo Hinweis: Das Skript versucht, die neueste Version von GitHub zu laden.
    echo.
    echo Wenn du Probleme hast, die Version abzurufen, kann es an einer fehlenden Internetverbindung liegen.
    echo.
    echo Bitte pruefe deine Internetverbindung und versuche es erneut.
    echo.
    echo Wenn das Problem weiterhin besteht, kontaktiere den Entwickler.
    echo.
    echo Hinweis: Du kannst auch manuell die neueste Version von GitHub herunterladen:
    echo.
    echo -/- %DOWNLOAD_URL% -/- %BRANCH% -/- %REPO_NAME% -/- %REPO_OWNER% -/-
    echo.
    echo Download-Link:
    echo %DOWNLOAD_URL%
    echo.
    echo Druecke eine Taste, um es "erneut" zu versuchen oder das Programm zu "beenden"...
    echo.
    set /p "retry=Druecke eine Taste, um es erneut zu versuchen oder 'x' zum Beenden: "
    if %choice%=="erneut" goto :start
    if %choice%==x (
        echo.
        echo Programm wird beendet.
        echo.
        timeout /t 3 >nul
        exit /b
        goto :MENU
        rem ich mag es nicht, wenn manuell eingegeben werden muss, aber manchmal ist es nötig
    )
    pause
    exit /b

echo.
echo Online-Version erfolgreich abgerufen!
echo.
echo Online-Version:   %ONLINE_VERSION%
echo.

REM ====== VERSIONSVERGLEICH ==================
REM Auch hier Whitespaces entfernen (zur Sicherheit)
for /f "tokens=* delims= " %%a in ("%LOCAL_VERSION%") do set "LOCAL_VERSION=%%a"
for /f "tokens=* delims= " %%a in ("%ONLINE_VERSION%") do set "ONLINE_VERSION=%%a"

if /i "%LOCAL_VERSION%"=="%ONLINE_VERSION%" (
    echo Du hast bereits die NEUESTE Version!
    echo.
) else 
    echo *** Es gibt eine NEUE Version! ***
    echo Deine Version:  %LOCAL_VERSION%
    echo Neueste:        %ONLINE_VERSION%
    echo.
    echo möchtest du die NEUE Version herunterladen?
    echo.
    set /p "update_choice=Druecke 'j' zum Herunterladen oder 'n' zum Abbrechen: "
    if /i "%update_choice%"=="j"
    
        echo.
        echo Update wird heruntergeladen...
        echo.
    if /i "%update_choice%"=="n" 
    else ( 
        echo.
        echo Update wird abgebrochen.
        echo.
        echo Du kannst die neueste Version manuell herunterladen.
        echo.
    (
        echo.
        echo --- Update wird heruntergeladen ---
        echo.
        REM Hier den Download-Link anpassen, falls nötig
        start "" "%DOWNLOAD_URL%/releases/latest/download/%REPO_NAME%.zip"
        echo.
        echo Update wurde gestartet. Bitte warte einen Moment...
        timeout /t 5 >nul
    ) else (
        echo.
        echo Update abgebrochen. Du kannst es spaeter manuell herunterladen.
    )
    echo.
    pause
    exit /b
)

REM ====== TOOL-UPDATER-ABSCHNITT =============

:MENU
cls

echo.
echo ==============================
echo   Tools-Updater Auswahlmenue
echo ==============================
echo.
echo 1. updater update    - updaten
echo 2. texter ter        - updaten
echo 3. p,s,t mann        - updaten
echo 4. the matrix!       - updaten
echo 5. Log Mananger      - updaten
echo g. Zu GitHub        (Projektseite)
echo b. Betas testen     (Beta-GitHub)
echo x. Beenden          (Programm beenden)
echo.

set /p choice=Bitte Auswahl eingeben: 

if /i "%choice%"=="1" goto :updater_update
if /i "%choice%"=="2" goto :texter_ter
if /i "%choice%"=="3" goto :p,s,t_mann
if /i "%choice%"=="4" goto :the_matrix!
if /i "%choice%"=="5" goto :log_mananger
if /i "%choice%"=="5" goto :github
if /i "%choice%"=="g" goto :GITHUB
if /i "%choice%"=="b" goto :BETA
if /i "%choice%"=="x" goto :ENDE

echo.
echo [FEHLER] Ungueltige Eingabe. Bitte erneut versuchen.
timeout /t 2 >nul
goto MENU

REM ====== TOOL UPDATES =======================
:updater_update
echo.
echo --- [Updater] Update wird ausgefuehrt ---
start "" "https://github.com/sakul-glitch/Littel_Projekt-s/releases/latest"
timeout /t 2 >nul
goto MENU

:texter_ter
echo.
echo --- [Texter ter] Update wird ausgefuehrt ---
start "" "https://github.com/sakul-glitch/Littel_Projekt-s/releases/latest"
timeout /t 2 >nul
goto MENU

:p,s,t_mann
echo.
echo --- [Weiteres Tool 3] Update wird ausgefuehrt ---
echo [Platzhalter] Tool 3 Aktualisierung...
timeout /t 2 >nul
goto MENU

:the_matrix!
echo.
echo --- [Weiteres Tool 4] Update wird ausgefuehrt ---
echo [Platzhalter] Tool 4 Aktualisierung...
timeout /t 2 >nul
goto MENU

:log_mananger
echo.
echo --- [Weiteres Tool 5] Update wird ausgefuehrt ---
echo [Platzhalter] Tool 5 Aktualisierung...
timeout /t 2 >nul
goto MENU

:GITHUB
echo.
echo --- GitHub-Projektseite wird im Browser geoeffnet ---
start "" "https://github.com/%REPO_OWNER%/%REPO_NAME%"
timeout /t 2 >nul
goto MENU

:BETA
echo.
echo --- Beta-Versionen aufrufen (GitHub Beta-Page) ---
start "" "https://github.com/%REPO_OWNER%/%REPO_NAME%/releases"
timeout /t 2 >nul
goto MENU

:ENDE
echo.
echo Programm wird beendet.
timeout /t 1 >nul
exit /b
