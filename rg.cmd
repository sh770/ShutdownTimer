@echo off
:: Define time thresholds
set /a maxHours1=18
set /a maxHours2=19
set /a maxSeconds1=maxHours1*3600
set /a maxSeconds2=maxHours2*3600
set /a shutdownInOneHour=3600
set /a shutdownInHalfHour=1800

:: Get the current hour and minute
for /f "tokens=1-2 delims=:" %%A in ("%TIME%") do (
    set /a hour=%%A
    set /a minute=%%B
)

:: Calculate remaining time until midnight in seconds
set /a hoursLeft=23-hour
set /a minutesLeft=59-minute
set /a totalSeconds=(hoursLeft*3600)+(minutesLeft*60)+60

:: Check shutdown conditions
if %totalSeconds% GTR %maxSeconds2% (
    set /a totalSeconds=shutdownInHalfHour
    echo More than %maxHours2% hours left. Setting shutdown in 30 minutes.
) else if %totalSeconds% GTR %maxSeconds1% (
    set /a totalSeconds=shutdownInOneHour
    echo More than %maxHours1% hours left. Setting shutdown in 1 hour.
) else (
    echo The computer will shut down in %totalSeconds% seconds.
)

:: Schedule the forced shutdown
shutdown /s /f /t %totalSeconds%
