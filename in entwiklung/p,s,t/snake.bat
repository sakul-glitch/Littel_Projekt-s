@echo off
chcp 65001 >nul
setlocal enabledelayedexpansion

:: Spielfeldgröße
set /a width=16
set /a height=10

:: Startposition der Schlange
set /a len=3
set "x[1]=8"
set "y[1]=5"
set "x[2]=7"
set "y[2]=5"
set "x[3]=6"
set "y[3]=5"
set dir=R

:: Futter platzieren
call :spawn_food

:mainloop
cls
call :draw
set /p input="Richtung (w=hoch, s=runter, a=links, d=rechts, 0=Ende): "
if "%input%"=="0" goto :eof
if /i "%input%"=="w" set dir=U
if /i "%input%"=="s" set dir=D
if /i "%input%"=="a" set dir=L
if /i "%input%"=="d" set dir=R

:: Kopf bewegen
set /a hx=!x[1]!
set /a hy=!y[1]!
if "%dir%"=="U" set /a hy-=1
if "%dir%"=="D" set /a hy+=1
if "%dir%"=="L" set /a hx-=1
if "%dir%"=="R" set /a hx+=1

:: Kollision mit Wand
if !hx! lss 1 goto :gameover
if !hx! gtr %width% goto :gameover
if !hy! lss 1 goto :gameover
if !hy! gtr %height% goto :gameover

:: Kollision mit sich selbst
for /l %%i in (1,1,!len!) do if !x[%%i]!=!hx! if !y[%%i]!=!hy! (rem) else goto :gameover

:: Futter gefressen?
if !hx!==!fx! if !hy!==!fy! (
    set /a len+=1
    set "x[!len!]=!x[!len!-1]!"
    set "y[!len!]=!y[!len!-1]!"
    call :spawn_food
) else (
    for /l %%i in (!len!,2,-1) do (
        set "x[%%i]=!x[%%i-1]!"
        set "y[%%i]=!y[%%i-1]!"
    )
)
set "x[1]=!hx!"
set "y[1]=!hy!"
goto mainloop

:draw
for /l %%y in (1,1,%height%) do (
    set "line="
    for /l %%x in (1,1,%width%) do (
        set "char= "
        if %%x==!fx! if %%y==!fy! set "char=*"
        for /l %%i in (1,1,!len!) do if %%x==!x[%%i]! if %%y==!y[%%i]! set "char=#"
        set "line=!line!!char!"
    )
    echo !line!
)
exit /b

:spawn_food
:retry
set /a fx=%random%%%width%+1
set /a fy=%random%%%height%+1
for /l %%i in (1,1,!len!) do if !x[%%i]!=!fx! if !y[%%i]!=!fy! (rem) else goto retry
exit /b

:gameover
echo Game Over! Laenge: !len!
pause
exit /b
