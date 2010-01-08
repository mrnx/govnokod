@echo off

echo Exporting govnokod.sql...
mysqldump --add-drop-database --add-drop-table --routines --net_buffer_length=4K --disable-add-locks --databases govnokod -u root > govnokod.sql

set /p a="Done! Press any key."