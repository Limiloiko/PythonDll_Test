@echo off
@setlocal EnableExtensions

rem Enable ANSI escape codes
<nul set /p ".=%~2"

echo [34mStarting Build process[0m
echo:
set start=%time%

:: Runs your command
echo [34mChanging current workspace in shell[0m
echo:
:: Jump to parent
echo [34mCopying files[0m
echo:
copy Build\sconstruct .
copy Build\sconscript .

echo [34mInstalling dependencies[0m
echo:
python -m pip install -r Build\requirements.txt

echo [34mCalling scons[0m
scons

echo [34mRemoving files[0m
echo:
del sconstruct
del sconscript

set end=%time%
set options="tokens=1-4 delims=:.,"
for /f %options% %%a in ("%start%") do set start_h=%%a&set /a start_m=100%%b %% 100&set /a start_s=100%%c %% 100&set /a start_ms=100%%d %% 100
for /f %options% %%a in ("%end%") do set end_h=%%a&set /a end_m=100%%b %% 100&set /a end_s=100%%c %% 100&set /a end_ms=100%%d %% 100

set /a hours=%end_h%-%start_h%
set /a mins=%end_m%-%start_m%
set /a secs=%end_s%-%start_s%
set /a ms=%end_ms%-%start_ms%
if %ms% lss 0 set /a secs = %secs% - 1 & set /a ms = 100%ms%
if %secs% lss 0 set /a mins = %mins% - 1 & set /a secs = 60%secs%
if %mins% lss 0 set /a hours = %hours% - 1 & set /a mins = 60%mins%
if %hours% lss 0 set /a hours = 24%hours%
if 1%ms% lss 100 set ms=0%ms%

:: Mission accomplished
set /a totalsecs = %hours%*3600 + %mins%*60 + %secs%
echo [32mcommand took %hours%:%mins%:%secs%.%ms% (%totalsecs%.%ms%s total)[0m
echo:
