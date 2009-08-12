@echo off
echo Importing govnokod.sql...
mysql -u root < govnokod.sql
set /p a="Done! Press enter."