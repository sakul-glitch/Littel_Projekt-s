@echo off
title Dancy's Batch Script
color 0a

setlocal enabledelayedexpansion
set "Local_version=1.2.1"
set "name=Dancy boy"
set "info=das ist noch in entwicklung und wird noch verbessert!"

set "hüf=call ani_hüf"
set "spri=call ani_spri"

echo loading...
timeout /t 2 >nul
echo.


menu bitte:echo 1. %hüf%
echo 2. %spri%
echo 3. %name%
echo 4. %info%
echo 5. Beenden
echo.
set /p choice=Bitte Auswahl eingeben:
if /i "%choice%"=="1" goto :hüf
if /i "%choice%"=="2" goto :spri
if /i "%choice%"=="3" goto :name
if /i "%choice%"=="4" goto :info
if /i "%choice%"=="5" goto :ENDE
echo.
echo [FEHLER] Ungueltige Eingabe. Bitte erneut versuchen.
timeout /t 2 >nul
goto menu bitte

:hüf
echo.
echo --- [Hüf] Animation wird ausgefuehrt ---
call ani_hüf
timeout /t 2 >nul
goto menu bitte

:spri
echo.
echo --- [Spri] Animation wird ausgefuehrt ---
call ani_spri
timeout /t 2 >nul
goto menu bitte

:name
echo.
echo --- [
Name] Dancy
echo.
echo Dancy
timeout /t 2 >
nul
goto menu bitte

:info
echo.
echo --- [Info] Informationen ---
echo.
echo %info%
echo.
echo Diese Version ist %Local_version%
echo.
echo Weitere Informationen findest du auf der Projektseite.
echo.
echo Bitte beachte, dass dieses Skript noch in der Entwicklung ist und sich in Zukunft ändern kann.
echo.
echo Vielen Dank für dein Interesse!
timeout
goto menu bitte