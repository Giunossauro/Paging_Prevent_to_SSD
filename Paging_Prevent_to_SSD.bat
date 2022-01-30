@echo off
echo --- When beep sounds, reduce ram usage to avoid paging (that decrease SSD lifespan)

setlocal
set /a freeRAM=0
set /a limitFreeRAMInPercent=16
set /a usedRAM=0

for /F "skip=1" %%M in ('%SystemRoot%\System32\wbem\wmic.exe ComputerSystem get TotalPhysicalMemory') do (
 set totalRAM=%%M
 goto puloA
)

:puloA

rem This prevents integer 32 overflow of totalMem (note the var is a string)
FOR /F "usebackq" %%n IN (`powershell -NoProfile -Command %totalRAM%/1024`) DO (SET "totalRAM=%%n")

:loop
for /F "skip=1" %%M in ('%SystemRoot%\System32\wbem\wmic.exe OS get FreePhysicalMemory') do (
 set /a freeRAM=%%M
 goto puloB
)

:puloB

set /a usedMem=(%freeMem%*100)/%totalMem%

if %usedRAM% LSS %limitFreeRAMInPercent% (
 powershell "[console]::beep(500,1500)"
)

timeout 7 > NUL
goto loop

endlocal
