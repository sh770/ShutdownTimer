@echo off
:: Define shutdown times
set /a shutdownHalfHour=1800
set /a shutdownOneHour=3600
set /a maxHours1=18*3600
set /a maxHours2=19*3600

:: Get current time
for /f "tokens=1-2 delims=:" %%A in ("%TIME%") do (
    set /a hour=%%A
    set /a minute=%%B
)

:: Calculate seconds until midnight
set /a totalSeconds=((23-hour)*3600) + ((59-minute)*60) + 60

:: Determine shutdown time
if %totalSeconds% GTR %maxHours2% (
    set totalSeconds=%shutdownHalfHour%
    echo More than 19 hours left. Shutting down in 30 minutes.
) else if %totalSeconds% GTR %maxHours1% (
    set totalSeconds=%shutdownOneHour%
    echo More than 18 hours left. Shutting down in 1 hour.
) else (
    echo The computer will shut down in %totalSeconds% seconds.
)

:: Execute shutdown command
shutdown /s /f /t %totalSeconds%
