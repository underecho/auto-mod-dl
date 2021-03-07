@echo off
if "%1"=="boot" goto boot
start update.bat 
exit

:boot
echo download pack data
bitsadmin /transfer download https://raw.githubusercontent.com/underecho/auto-mod-dl/main/data/pack.txt %CD%\pack.txt
echo download mod data
aria2c -i pack.txt -d ./mods

echo Done.
pause