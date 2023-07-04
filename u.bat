@echo off
del .\launch.bat
aria2c https://raw.githubusercontent.com/underecho/auto-mod-dl/main/launch.bat
start launch.bat boot
exit
