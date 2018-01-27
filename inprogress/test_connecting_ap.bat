:: This BAT file is used to check wireless AP have succeeded to work.
:: 1st part beginning ===
@echo off
setlocal enabledelayedexpansion
netsh interface set interface name="Internal" admin=disable
timeout /t 5
netsh interface set interface name="Internal" admin=enable
timeout /t 10
ipconfig > d:\lab\1.txt
set start=3
set "lines=1"
set/a i=-1,start-=1
set "ok=" 
for /f "tokens=15 delims=: " %%a in ('more/e +%start% ^< d:\lab\1.txt') do (
set/a i+=1 & for /f %%z in ('echo/%%i%%') do (
if "%%z"=="%lines%" set ok=1
)
if not defined ok set var2=%%a
)
echo !var2!
if "%var2:192.168=%"=="%var2%" (echo !var2! not included 192.168) else echo !var2! included 192.168
if "%var2:192.168=%"=="%var2%" (echo !var2! not included 192.168) else start d:\lab\ip.bat
:: 1st end ===
::
:: 2nd part binning ===
@echo off
netsh wlan show interface > d:\wifi.txt
timeout /t 5
findstr /i homeap d:\wifi.txt && findstr 連線 d:\wifi.txt
if errorlevel 1 goto NOT_MATCH
echo MATCH
pause
goto END

:NOT_MATCH
echo NOT_MATCH
pause
:END
:: 2nd end ===
::
:: 3rd part binning ===
@echo off
blat -server 127.0.0.1:25 -f sender@mail_domain -u sender@mail_domain -pw "password here" -to receiver@mail_domain -s "Ipconfig" -body "ipconfig ok" -attach d:\lab\1.txt
:: 3rd end ===
