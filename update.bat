@echo off
del .\DL.bat
aria2c https://raw.githubusercontent.com/underecho/auto-mod-dl/main/DL.bat
start DL.bat boot
exit
