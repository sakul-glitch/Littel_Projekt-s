@echo off
title Auto Start Add (Addon-Modus)
color a
set "localversion=1.2.5"
cls
echo =============================================
echo         *** ADDON-MODUS AKTIV *** 
echo =============================================
echo Dieses Skript ist als Erweiterung gedacht!
echo (Kannst du überall einbinden oder von Hand starten)
echo.
call :animation "Starte Addon..."
ping -n 2 127.0.0.1 >nul

REM Ladebalken-Animation
cls
echo <=== Vorbereitung wird getroffen... ===^>
setlocal enabledelayedexpansion
set "bar="
for /L %%i in (1,1,20) do (
    set "bar=!bar!█"
    cls
    echo Lade: !bar!
    ping -n 1 127.0.0.1 >nul
)
endlocal

:main
cls
echo.
echo --------------------------------------
echo        - Ihre Optionen -
echo --------------------------------------
echo.
echo [j] Zum automatischen Starten HINZUFÜGEN
echo #--------------------------------------# 
echo [n] Zum automatischen Starten ENTFERNEN
echo #--------------------------------------# 
echo [i] Informationen
echo #--------------------------------------# 
echo [r] Risiken
echo #--------------------------------------# 
echo [u] Updates
echo #--------------------------------------# 
echo [w] Weiteres Menü
echo #--------------------------------------# 
echo.

set /p choice=Waehle Befehl... -> 

if /i "%choice%"=="j" goto :add
if /i "%choice%"=="n" goto :remove
if /i "%choice%"=="i" goto :info
if /i "%choice%"=="r" goto :risks
if /i "%choice%"=="u" goto :updater
if /i "%choice%"=="w" goto :weiter
else goto :why

:add
cls
echo === AUTOSTART HINZUFÜGEN ===
set "startupfolder=%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup"
set /p exe_path=Pfad zur EXE-Datei: 
if not exist "%exe_path%" (
    echo [Fehler] Datei nicht gefunden!
    call :animation "Fehler!"
    pause
    goto :main
)

set /p linkname=Name der Verknüpfung (darf keine Leerzeichen/sonderzeichen enthalten!) :
echo.%linkname% | findstr /R "[\\/:*?\"<>|]" >nul
if not errorlevel 1 (
    echo [Fehler] Ungültige Zeichen im Namen!
    call :animation "Fehler!"
    pause
    goto :main
)

call :animation "Verknüpfung wird erstellt..."
powershell -Command "$s=(New-Object -COM WScript.Shell).CreateShortcut('%startupfolder%\%linkname%.lnk');$s.TargetPath='%exe_path%';$s.Save()"
echo ✓ Verknüpfung hinzugefügt!
call :animation "Fertig!"
REM Sound Feedback (optional, erfordert 'media\success.wav')
REM powershell -c (New-Object Media.SoundPlayer "media\success.wav").PlaySync()
pause
goto :main

:remove
cls
echo === AUTOSTART ENTFERNEN ===
set "startupfolder=%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup"
echo Deine Autostart-Verknüpfungen:
dir "%startupfolder%\*.lnk" /b
echo.
set /p delname=Gib den Namen der zu entfernenden Verknüpfung ein (ohne .lnk): 
if exist "%startupfolder%\%delname%.lnk" (
    call :animation "Entferne Verknüpfung..."
    del "%startupfolder%\%delname%.lnk"
    echo ✓ Verknüpfung entfernt!
    call :animation "Fertig!"
) else (
    echo Verknüpfung nicht gefunden!
    call :animation "Fehler!"
)
pause
goto :main

:info
cls
echo === INFORMATIONEN ===
echo.
echo Dieses Skript ist ein Addon:
echo #--------------------------------------# 
echo - Fügt Programme zum Windows-Autostart hinzu
echo #--------------------------------------# 
echo - Oder entfernt sie bequem
echo #--------------------------------------# 
echo - Mit Animationen & optional Sound
echo #--------------------------------------# 
echo - Kein Admin nötig (sofern du Schreibrechte hast)
echo #--------------------------------------# 
echo - Nutzt nur Windows-Verknüpfungen
echo #--------------------------------------# 
pause 
goto :main

:risks
cls
echo Risiken:
echo #--------------------------------------# 
echo - Zu viele Autostart-Programme = langsamer Start
echo #--------------------------------------# 
echo - Prüfe immer, ob du die Programme wirklich willst
echo #--------------------------------------# 
echo - Verknüpfungen können von anderen Nutzern entfernt werden
echo #--------------------------------------# 
pause
goto :main

:updater
echo Zu was möchten Sie wissen?

echo #--------------------------------------# 
echo [1] Warum ein "Updater"?
echo #--------------------------------------# 
echo [2] Was ist ein "Updater"?
echo #--------------------------------------# 
echo [3] Github öffnen (externe Seite)
echo #--------------------------------------# 
echo [b] Zurück
echo #--------------------------------------# 
set /p upval=Waehle... ->
if "%upval%"=="1" (
    echo Ein Updater hält dein Programm auf dem neuesten Stand!
    pause
    goto :updater
) 
if "%upval%"=="2" (
    echo Ein Updater prüft und installiert neue Versionen automatisch.
    pause
    goto :updater
)
if "%upval%"=="3" (
    start https://github.com/sakul-glitch.exe
    goto :updater
)
if /i "%upval%"=="b" goto :main
goto :updater
else goto :why


:why
echo never gona give you up!
echo We're no strangers to love
echo You know the rules and so do I 
echo A full commitment's what I'm thinkin' of
echo You wouldn't get this from any other guy
echo I just wanna tell you how I'm feeling
echo Gotta make you understand
echo Never gonna give you up, never gonna let you down
echo Never gonna run around and desert you
echo Never gonna make you cry, never gonna say goodbye
echo Never gonna tell a lie and hurt you
echo We've known each other for so long
echo Your heart's been aching, but you're too shy to say it
echo Inside, we both know what's been going on
echo We know the game and we're gonna play it
echo And if you ask me how I'm feeling
echo Don't tell me you're too blind to see
echo Never gonna give you up, never gonna let you down
echo Never gonna run around and desert you
echo Never gonna make you cry, never gonna say goodbye
echo Never gonna tell a lie and hurt you
echo Never gonna give you up, never gonna let you down
echo Never gonna run around and desert you
echo Never gonna make you cry, never gonna say goodbye
echo Never gonna tell a lie and hurt you
echo We've known each other for so long
echo Your heart's been aching, but you're too shy to say it
echo Inside, we both know what's been going on
echo We know the game and we're gonna play it
echo I just wanna tell you how I'm feeling
echo Gotta make you understand
echo Never gonna give you up, never gonna let you down 
echo Never gonna run around and desert you
echo Never gonna make you cry, never gonna say goodbye
echo Never gonna tell a lie and hurt you
echo Never gonna give you up, never gonna let you down
echo Never gonna run around and desert you
echo Never gonna make you cry, never gonna say goodbye
echo Never gonna tell a lie and hurt you
echo Never gonna give you up, never gonna let you down
echo Never gonna run around and desert you
echo Never gonna make you cry, never gonna say goodbye
echo Never gonna tell a lie and hurt you
pause /t 5 /nobreak >nul
cls
goto :main

:animation
setlocal enabledelayedexpansion
set "msg=%~1"
set "dots="
for /L %%i in (1,1,3) do (
    set "dots=!dots!."
    cls
    echo !msg!!dots!
    ping -n %anim_delay% 127.0.0.1 >nul
)
endlocal
exit /b
