@echo off
title p,s,t pong, snake, tetris
setlocal enabledelayedexpansion
color a
cls

set "localversion=1.2.1"
set "REPO_URL=https://github.com/sakul-glitch/Littel_Projekt-s"
set "wep_URL=https://youtube.com/@coolnes_of_fire"

echo.
echo -cheking for: files...
timeout /t 2 /nobreak > nul
goto :check_f_1

:check_f_1
    if exist "pong.bat" echo -f_1 found...(
    
    timeout /t 1 /nobreak > nul
    goto :check_f_2
    else if not exist "pong.bat"
    echo >f_1 not found, please download pong.bat from %REPO_URL% or %wep_URL%
    echo %REPO_URL% or %wep_URL%
)

:check_f_2
    if exist "snake.bat" (
    echo -f_2 found...
    timeout /t 1 /nobreak > nul
    goto :check_f_3
    else if not exist "snake.bat"
    echo -f_2 not found, please download pong.bat from %REPO_URL% or %wep_URL%
    echo %REPO_URL% or %wep_URL%
)

if exist "tetris.bat" (
    echo >f_3 found...
    timeout /t 1 /nobreak > nul
    goto :menu
    else if not exist "tetris.bat"
    echo -f_3 not found, please download pong.bat from %REPO_URL% or %wep_URL%
    echo %REPO_URL% or %wep_URL%
)

echo -all files found, starting menu...
    timeout /t 2 /nobreak > nul
    goto :menu
    cls

rem Menu und Spielauswahl ist ein einfaches Textmenü oder?

:menu
echo --------------------------------------
echo        willkommen zum p,s,t!
echo       pong, snake, tetris,
echo       Version: %localversion%
echo       -by sakul-glitch-
echo --------------------------------------
echo.
echo Bitte wähle ein Spiel aus:
echo #--------------------------------------# 
echo 1. Pong
echo #--------------------------------------# 
echo 2. Snake
echo #--------------------------------------#
echo 3. Tetris
echo #--------------------------------------#
echo 4. Beenden
echo #--------------------------------------#
echo.
echo Hinweis: Dieses Spiel ist in Entwicklung und kann Fehler enthalten.
echo.
echo Weitere Informationen findest du auf:
echo %REPO_URL%
echo %wep_URL%
echo --------------------------------------
echo.
set /p choice="Gib deine Wahl ein: "
if /i "%choice%"=="1" goto pong
if /i "%choice%"=="2" goto snake
if /i "%choice%"=="3" goto tetris
if /i "%choice%"=="4" exit

else wähle bitte eine gültiges spiel!
    timeout /t 2 /nobreak > nul
    goto :menu
    timeout /t 2 /nobreak > nul
    goto :eof
