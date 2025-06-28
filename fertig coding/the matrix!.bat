@echo off
setlocal enabledelayedexpansion
set "localversion=1.6.1"
title The Matrix!..
color a
cls

:: TODO: -info
:: Dieses Script zeigt eine Matrix-ähnliche Konsole mit Zufallszeichen und Timer.
:: Es enthält Optionen für Dauer, Größe, Zeichen, Geschwindigkeit, Farbe, Animation und Audioeffekte.
:: NEU: Stabilere Zeitmessung, kleinere Performance-Optimierungen.

:: Optionale Sounds aktivieren?
echo.
echo Sound aktivieren? [j/n]
set /p soundOn=
if /i "%soundOn%"=="j" (set "sound=1") else (set "sound=0")

:: Starteffekt
if %sound%==1 powershell -c "[console]::beep(400,400); Start-Sleep -Milliseconds 150; [console]::beep(600,200)"
echo ==============================
echo     M A T R I X 
echo ==============================
echo.
echo (Mit Taste [Strg+C] kannst du die Matrix jederzeit stoppen!)
echo.
echo Tippe "standart" um direkt zu starten.
echo -> 1min, hoehe:20, breite:100, farbe:gruen, voreingespeicherte Zeichen

echo.
:ask_time
set /p timeChoice=Wie lange (1-24 Min/w=Endlos/standart): 
if /i "%timeChoice%"=="standart" (
    set "stopTime=60" & set "zeilen=20" & set "spalten=100" & set "zeichen=.!^\u00b0\u00b4`#\""*~0123456789,'" & goto count_zeichen
)
if /i "%timeChoice%"=="w" (
    set "stopTime=0"
    goto ask_zeilen
)
echo.%timeChoice%|findstr /r "^[0-9][0-9]*$">nul&&(set /a timeCheck=%timeChoice%) || set timeCheck=0
if %timeCheck% geq 1 if %timeCheck% leq 24 (
    set /a stopTime=timeCheck*60
    goto ask_zeilen
)
echo Ungueltige Eingabe!&goto ask_time

:ask_zeilen
set /p zeilen=Zeilen (10-40): 
echo.%zeilen%|findstr /r "^[0-9][0-9]*$">nul||goto ask_zeilen
if %zeilen% lss 10 goto ask_zeilen
if %zeilen% gtr 40 goto ask_zeilen

:ask_spalten
set /p spalten=Spalten (20-100): 
echo.%spalten%|findstr /r "^[0-9][0-9]*$">nul||goto ask_spalten
if %spalten% lss 20 goto ask_spalten
if %spalten% gtr 100 goto ask_spalten

:ask_zeichen
echo Welche Zeichen? Standard: .!^\u00b0\u00b4`#\""*~0123456789,'
set /p zeichen=Eigene Liste (Enter=Standard): 
if "%zeichen%"=="" set "zeichen=.!^\u00b0\u00b4`#\""*~0123456789,'"

:count_zeichen
set /a zeichenLen=0
for /L %%i in (0,1,199) do (
    set "ch=!zeichen:~%%i,1!"
    if "!ch!"=="" goto done_len
    set /a zeichenLen+=1
)
:done_len

:ask_speed
set /p speed=Geschwindigkeit (1-10): 
if "%speed%"=="" set speed=3
echo.%speed%|findstr /r "^[0-9][0-9]*$">nul||goto ask_speed
if %speed% lss 1 goto ask_speed
if %speed% gtr 10 goto ask_speed
set /a speedMS=speed*20+10

:ask_color
echo Farbe: a=Gr\u00fcn 2=Dunkelgr\u00fcn b=Hell-Cyan f=Weiss 0=Schwarz
set /p farbe=Code: 
if "%farbe%"=="" set farbe=a
color %farbe% 2>nul||color a

:ask_anim
echo Animationen: [1]=Blink [2]=Farbwechsel [3]=Beides [0]=Keine
set /p anim=Auswahl (0-3): 
if "%anim%"=="" set anim=3
if %anim% lss 0 set anim=3
if %anim% gtr 3 set anim=3

:matrix_start
cls
echo Starte Matrix...
if %sound%==1 powershell -c "[console]::beep(200,200); Start-Sleep -Milliseconds 100"
time /T > matrix_start.tmp
for /f "tokens=1,2 delims=: " %%a in (matrix_start.tmp) do set /a "startsec=1%%a*60+1%%b-100"
del matrix_start.tmp

:matrixLoop
time /T > matrix_now.tmp
for /f "tokens=1,2 delims=: " %%a in (matrix_now.tmp) do set /a "nowsec=1%%a*60+1%%b-100"
del matrix_now.tmp
set /a elapsed=nowsec - startsec

if not "%stopTime%"=="0" (
    set /a left=stopTime - elapsed
    if !left! leq 0 goto done
    set /a min=left/60 & set /a sec=left%%60
    if !sec! lss 10 set sec=0!sec!
    set "timer=Rest: !min!:!sec!"
) else (
    set /a min=elapsed/60 & set /a sec=elapsed%%60
    if !sec! lss 10 set sec=0!sec!
    set "timer=Verg: !min!:!sec!"
)

if %anim% geq 2 call :zufallsfarbe
if %anim% geq 2 color !nextcolor!

cls
echo !timer!
for /L %%Z in (1,1,%zeilen%) do (
    set "line="
    set /a blink=!random! %% 10
    for /L %%S in (1,1,%spalten%) do (
        set "c="
        if !blink! lss 2 (
            if %anim% geq 1 (
                set "c= "
            ) else (
                set /a idx=!random! %% zeichenLen
                call set "c=%%zeichen:~!idx!,1%%"
            )
        ) else (
            set /a idx=!random! %% zeichenLen
            call set "c=%%zeichen:~!idx!,1%%"
        )
        set "line=!line!!c!"
    )
    echo !line!
)

timeout /nobreak /t 1 >nul
goto matrixLoop

:done
if %sound%==1 powershell -c "[console]::beep(400,150); Start-Sleep -Milliseconds 80; [console]::beep(300,120)"
echo.
echo Matrix beendet.
pause>nul
exit /b

:zufallsfarbe
set /a zuf=%random% %% 4
for %%f in (a 2 b f) do (
    set /a i+=1
    if !i! gtr %zuf% goto setcolor
    set "nextcolor=%%f"
)
:setcolor
exit /b
