@echo off

echo packデータのダウンロード
bitsadmin /transfer download https://raw.githubusercontent.com/underecho/auto-mod-dl/main/data/pack.txt %CD%\pack.txt
echo modデータのダウンロード
aria2c -i pack.txt -d ./mods

echo Done.
pause