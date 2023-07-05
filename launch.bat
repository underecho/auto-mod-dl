@echo off
SETLOCAL ENABLEDELAYEDEXPANSION

cd %~dp0
if "%1"=="boot" goto boot
start u.bat 
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
aria2c https://maven.minecraftforge.net/net/minecraftforge/forge/1.19.2-43.2.14/forge-1.19.2-43.2.14-installer.jar
java -jar .\forge-1.19.2-43.2.14-installer.jar
del .\forge-1.19.2-43.2.14-installer.jar
exit /b

:install
echo found minecraft. then try automatic install.
echo checking Forge files...
if not exist %APPDATA%\.minecraft\versions\1.19.2-forge-43.2.14\1.19.2-forge-43.2.14.json call :installForge
timeout 5 >nul
call :download
aria2c https://raw.githubusercontent.com/underecho/auto-mod-dl/main/data/dist.zip
call powershell -command "Expand-Archive dist.zip"
if not exist %APPDATA%\.minecraft\baka (
    mkdir %APPDATA%\.minecraft\baka
    if not exist %APPDATA%\.minecraft\baka\mods mkdir %APPDATA%\.minecraft\baka\mods
)
xcopy .\pack\mods %APPDATA%\.minecraft\baka\mods /Y
call .\dist\dist\install.exe %APPDATA%\.minecraft\launcher_profiles.json %APPDATA%\.minecraft\baka\
rd /s /q .\pack
rd /s /q .\dist
goto finish

:download
echo download pack data
aria2c https://raw.githubusercontent.com/underecho/auto-mod-dl/main/data/pack.zip
call powershell -command "Expand-Archive pack.zip"
del .\pack.zip
echo Done.
timeout 3 >nul
exit /b

:finish
echo delete temp files...
if exist .\pack.txt del .\pack.txt
if exist .\dist.zip del .\dist.zip
echo Done.

pause