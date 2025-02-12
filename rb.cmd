@echo off
:: Check if running as administrator
openfiles >nul 2>&1
if %errorlevel%==0 (
    set forceShutdown=/f
) else (
    set forceShutdown=
)

:: Get the current hour and minute
for /f "tokens=1-2 delims=:" %%A in ("%TIME%") do (
    set /a hour=%%A
    set /a minute=%%B
)

:: Calculate remaining time until midnight in seconds
set /a hoursLeft=23-hour
set /a minutesLeft=59-minute
set /a totalSeconds=(hoursLeft*3600)+(minutesLeft*60)

:: Display the calculated time
:: echo The computer will shut down in %totalSeconds% seconds.

:: Schedule the shutdown with or without forced mode
shutdown /s %forceShutdown% /t %totalSeconds%

::pause
