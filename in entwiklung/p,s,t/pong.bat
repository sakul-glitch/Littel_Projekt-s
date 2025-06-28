@echo off
chcp 65001 >nul
setlocal enabledelayedexpansion

:: Spielfeldgröße
set /a width=20
set /a height=10

:: Schläger-Positionen
set /a p1=5
set /a p2=5

:: Ball-Position und Richtung
set /a bx=10
set /a by=5
set /a dx=1
set /a dy=1

:mainloop
cls
call :draw
:: Spieler 1 Zug
set /p move1="Spieler 1 (w=hoch, s=runter, Enter=bleibt): "
if /i "%move1%"=="w" if %p1% gtr 1 set /a p1-=1
if /i "%move1%"=="s" if %p1% lss %height% set /a p1+=1

:: Ball bewegen
set /a bx+=dx
set /a by+=dy

:: Ball Kollision mit Wand
if %by% leq 1 set /a dy*=-1 & set /a by=1
if %by% geq %height% set /a dy*=-1 & set /a by=%height%

:: Ball Kollision mit Schläger 1
if %bx% leq 1 if %by%==%p1% set /a dx*=-1 & set /a bx=2

:: Ball Kollision mit Schläger 2
if %bx% geq %width% if %by%==%p2% set /a dx*=-1 & set /a bx=%width%-1

:: Punkt für Spieler 2
if %bx% lss 1 (
    echo Spieler 2 bekommt einen Punkt!
    pause
    set /a bx=10
    set /a by=5
    set /a dx=1
    set /a dy=1
)

:: Punkt für Spieler 1
if %bx% gtr %width% (
    echo Spieler 1 bekommt einen Punkt!
    pause
    set /a bx=10
    set /a by=5
    set /a dx=-1
    set /a dy=1
)

:: Spieler 2 Zug
set /p move2="Spieler 2 (o=hoch, l=runter, Enter=bleibt): "
if /i "%move2%"=="o" if %p2% gtr 1 set /a p2-=1
if /i "%move2%"=="l" if %p2% lss %height% set /a p2+=1

goto mainloop

:draw
for /l %%y in (1,1,%height%) do (
    set "line="
    for /l %%x in (1,1,%width%) do (
        set "char= "
        if %%x==1 if %%y==!p1! set "char=|"
        if %%x==%width% if %%y==!p2! set "char=|"
        if %%x==!bx! if %%y==!by! set "char=O"
        set "line=!line!!char!"
    )
    echo !line!
)
exit /b
