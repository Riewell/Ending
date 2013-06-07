@echo off

if exist std_err goto 3
echo Проверка файла с данными РПО...
set /p f=<Last_file_RPO.txt
cd C:\ftp\rpo
for %%i in (*) do set a=%%i
if not %a%==%f% goto 1
echo.
echo Похоже, не сформированы файлы для отправки.
echo.
echo Запустите программу "Доставочный участок".
echo Выберите в меню "Итоги", затем - "Сформировать файлы для отправки".
echo Запустите программу "Конец дня" ещё раз.
echo.
pause
exit

:1
echo.
echo Копирование файлов...
copy %a% C:\RPO
if exist C:\RPO\%a% goto 2
echo.
echo Ошибка копирования.
echo Запустите программу "Конец дня" ещё раз.
echo.
pause
exit

:2
echo %a%>"C:\Program Files\Ending\Last_file_RPO.txt"
echo rpo>"C:\Program Files\Ending\std_err"
echo Готово.

:3
echo Проверка базы данных...
set /p b=<"C:\Program Files\Ending\Last_File_BD.txt"
cd "c:\Program Files\RussianPost\PostMove"
for %%i in (*.zip) do set a=%%i
if not %a%==%b% goto 4
echo.
echo.
echo Похоже, не сделано резервирование базы данных.
echo.
echo Запустите программу "Доставочный участок".
echo.
echo Выберите в меню "Сервис", затем - "Обслуживание баз данных",
echo  затем - "Резервирование баз данных".
echo.
echo Запустите программу "Конец дня" ещё раз.
echo.
pause
exit

:4
echo.
echo Копирование Базы данных...
copy %a% c:\ARXIV_BASE\
copy %a% d:\ARXIV_BASE\
echo %a%>"C:\Program Files\Ending\Last_file_BD.txt"
echo bd>"C:\Program Files\Ending\std_err"
echo Копирование Базы данных завершено.

echo.
echo Архивация файлов РПО...
"c:\Program Files\WinRAR\Rar.exe" a -as -rr10p c:\RPO.rar c:\RPO\*.* >> c:\rpo_archive.log
if %errorlevel%==0 (del c:\rpo_archive.log) else goto 5
"c:\Program Files\WinRAR\Rar.exe" t c:\RPO.rar >> c:\rpo_archive.log
if %errorlevel%==0 (del c:\rpo_archive.log) else goto 5
copy c:\RPO.rar "c:\Program Files\RussianPost\PostMove\"
copy c:\RPO.rar c:\ARXIV_BASE\
copy c:\RPO.rar d:
echo.
echo Архивация завершена без ошибок.
echo.
echo.
echo Готово.
echo.
echo.
pause
del "C:\Program Files\Ending\std_err"
echo.
echo Отправка файлов РПО на почтамт
echo.
C:\ftp\start_upload.cmd
echo.
exit

:5
echo.
echo ОШИБКА! Обратитесь к системному адиристратору!
echo.
pause