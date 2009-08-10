@echo off
echo Importing govnokod.sql...
mysql -u root < govnokod_full.sql
set /p a="Done! Press enter."