@ECHO OFF
title diepi dip schop.
set "localversion = 1.0.1"
color a
cls

echo bereite githup vor...
setlocal enabledelayedexpansion
set "downloadurl=https://github.com/sakul-glitch/Littel_Projekt-s"
set "REPO_URL=https://github.com/sakul-glitch/Littel_Projekt-s"
set "wep_URL=https://github.com/sakul-glitch/Littel_Projekt-s"
set "wep_URL2=https://youtube.com/@coolnes_of_fire"
timeout /t 3 /nobreak > nul
echo.
echo githup bereit!
timeout /t 1 /nobreak > nul
echo.
cls

echo.
echo Bitte Wähle eine sache aus:
echo.
echo 1. texter text herunterladen (externer Link)
echo.
echo 2. the matrix! heruntergeladen (externer Link)
echo.
echo 3. Log Manager (externer Link)
echo.
echo 4. kommt bald (externer Link) 
echo.
echo 5. kommt bald (externer Link)
echo.
echo 6. beta,s ansehen (externer Link)
echo.
echo 7. Beenden
echo.
echo.
rem LUL
set /p choice=Gib deine Wahl ein:  


if "%choice%"=="1" (
    echo du wirst auf eine externe Seite weitergeleitet...
    echo Bitte warte einen Moment...
    timeout /t 2 /nobreak > nul
    echo.
    start "" "%downloadurl%"
    goto :menu
)

else if "%choice%"=="2" (
    echo du wirst auf eine externe Seite weitergeleitet...
    echo Bitte warte einen Moment...
    timeout /t 2 /nobreak > nul
    start "" "%wep_URL%"
    goto :menu
) 

else if "%choice%"=="3" (
    echo du wirst auf eine externe Seite weitergeleitet...
    echo Bitte warte einen Moment...
    timeout /t 2 /nobreak > nul
    start "" "%wep_URL2%"
    goto :menu
) 

else if "%choice%"=="4" (
    echo Diese sachen sind noch in Entwicklung.
    echo Bitte besuche die GitHub-Seite für Updates.
    timeout /t 2 /nobreak >nul
    goto :menu
) 

else if "%choice%"=="5" (
    echo Diese sachen sind noch in Entwicklung.
    echo Bitte besuche die GitHub-Seite für Updates.
    timeout /t 2 /nobreak >nul
    goto :menu
) 

else if "%choice%"=="6" (
    echo.
    echo Beta-Versionen ansehen...
    echo.
    echo Du wirst auf eine externe Seite weitergeleitet...
    echo Bitte warte einen Moment...
    timeout /t 2 /nobreak > nul
    pause
    goto :menu
)



else if "%choice%"=="7" (
    echo Beende das Programm...
    timeout /t 2 /nobreak > nul
    echo.
    echo Vielen Dank für die Nutzung des Programms!
    echo.
    echo Bis zum nächsten Mal!
    timeout /t 2 /nobreak > nul
    echo.
    echo Programm wird beendet...
    timeout /t 1 /nobreak > nul 
    exit /b
) 

else (
    echo Ungültige Eingabe. Bitte wähle eine Zahl zwischen "1" und "7".
    pause /t 3 /nobreak > nul
    goto :menu
)