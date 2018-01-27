:: This BAT is used for print data on monitor from a specific file, and only print to a specified start line to the end line.
@echo off & setlocal ENABLEEXTENSIONS
set start=5
set "lines=8"
set/a i=-1,start-=1
set "ok=" 
for /f "delims=" %%a in ('more/e +%start% ^< d:\lab\1.txt') do (
set/a i+=1 & for /f %%z in ('echo/%%i%%') do (
if "%%z"=="%lines%" set ok=1
)
if not defined ok echo/%%a
)
pause>nul
