@echo off
echo --- When beep sounds, reduce ram usage to avoid paging (that decrease SSD lifespan)

setlocal
set /a freeMem=0
set /a limitFreeMemInPercent=16
set /a usedMem=0

for /F "skip=1" %%M in ('%SystemRoot%\System32\wbem\wmic.exe ComputerSystem get TotalPhysicalMemory') do (
 set totalMem=%%M
 goto puloa
)

:puloa

FOR /F "usebackq" %%n IN (`powershell -NoProfile -Command %totalMem%/1024`) DO (SET "totalMem=%%n")

:teste
for /F "skip=1" %%M in ('%SystemRoot%\System32\wbem\wmic.exe OS get FreePhysicalMemory') do (
 set /a freeMem=%%M
 goto pulob
)

:pulob

set /a usedMem=(%freeMem%*100)/%totalMem%

if %usedMem% LSS %limitFreeMemInPercent% (
 powershell "[console]::beep(500,1500)"
)

timeout 7 > NUL
goto teste

endlocal