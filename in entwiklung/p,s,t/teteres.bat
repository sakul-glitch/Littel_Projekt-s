@echo off
chcp 65001 >nul
setlocal enabledelayedexpansion

:: Spielfeldgröße
set /a width=8
set /a height=12

:: Spielfeld initialisieren
for /l %%y in (1,1,%height%) do (
    set "row=        "
    set "field[%%y]=!row:~0,%width%!"
)

:mainloop
cls
call :draw
set /p input="Links=1 | Rechts=2 | Runter=3 | Beenden=0: "
if "%input%"=="0" goto :eof
if "%input%"=="1" call :move left
if "%input%"=="2" call :move right
if "%input%"=="3" call :move down
call :gravity
goto mainloop

:draw
for /l %%y in (1,1,%height%) do (
    set "line=!field[%%y]!"
    echo !line!
)
exit /b

:move
:: Dummyfunktion für Bewegung (noch nicht implementiert)
exit /b

:gravity
:: Dummyfunktion für Schwerkraft (noch nicht implementiert)
exit /b
