@echo off
SETLOCAL ENABLEDELAYEDEXPANSION

cd %~dp0
if "%1"=="boot" goto boot
start update.bat 
exit

:boot
echo "   _  _   _ _____ ___  "
echo "  /_\| | | |_   _/ _ \ "
echo " / _ \ |_| | | || (_) |"
echo "/_/ \_\___/  |_| \___/ "                   
echo " __  __  ___  ___  "
echo "|  \/  |/ _ \|   \ "
echo "| |\/| | (_) | |) |"
echo "|_|  |_|\___/|___/ "                 
echo " ___ _  _ ___ _____ _   _     _    ___ ___ "
echo "|_ _| \| / __|_   _/_\ | |   | |  | __| _ \"
echo " | || .` \__ \ | |/ _ \| |__ | |__| _||   /"
echo "|___|_|\_|___/ |_/_/ \_\____||____|___|_|_\"

if exist %APPDATA%\.minecraft\launcher_profiles.json goto install
echo hmm... couldn't find minecraft. then, perform download only.
timeout 5 >nul
call :download
goto finish

:installForge
echo trying install Forge...
aria2c https://files.minecraftforge.net/maven/net/minecraftforge/forge/1.12.2-14.23.5.2854/forge-1.12.2-14.23.5.2854-installer.jar
java -jar .\forge-1.12.2-14.23.5.2854-installer.jar
del .\forge-1.12.2-14.23.5.2854-installer.jar
exit /b

:install
echo found minecraft. then try automatic install.
echo checking Forge files...
if not exist %APPDATA%\.minecraft\versions\1.12.2-forge-14.23.5.2854\1.12.2-forge-14.23.5.2854.jar call :installForge
timeout 5 >nul
call :download
aria2c https://raw.githubusercontent.com/underecho/auto-mod-dl/main/data/install.exe
if not exist %APPDATA%\.minecraft\elek (
    mkdir %APPDATA%\.minecraft\elek
    if not exist %APPDATA%\.minecraft\elek\mods mkdir %APPDATA%\.minecraft\elek\mods
)
xcopy .\mods %APPDATA%\.minecraft\elek\mods /Y
call install.exe %APPDATA%\.minecraft\launcher_profiles.json %APPDATA%\.minecraft\elek\
rd /s /q .\mods
goto finish


:download
echo download pack data
aria2c https://raw.githubusercontent.com/underecho/auto-mod-dl/main/data/pack.txt
echo download mod data
aria2c -i pack.txt -d ./mods
echo Done.
timeout 3 >nul
exit /b

:finish
echo delete temp files...
if exist .\pack.txt del .\pack.txt
if exist .\install.exe del .\install.exe
echo Done.

pause