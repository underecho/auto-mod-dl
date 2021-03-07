@echo off
bitsadmin /transfer download https://raw.githubusercontent.com/underecho/auto-mod-dl/main/DL.bat %CD%\DL.bat
start DL.bat boot
exit
