@echo off

if not exist std_err goto rpo
set /p d=<error_date
if not %d%==%date% goto rpo
set /p var=<std_err
if %var%==bd goto bd
if %var%==archive goto archive
if %var%==upload goto upload

:rpo
echo.
echo Проверка файла с данными РПО...
set /p f=<Last_file_RPO.txt
cd C:\ftp\rpo
if not exist *.??F goto rpo_fail
for %%i in (*) do set a=%%i
if %a%==%f% goto rpo_fail
echo.
echo Копирование файлов...
copy %a% C:\RPO
if not exist C:\RPO\%a% goto rpo_copy_fail
echo %a%>"C:\Program Files\Ending\Last_file_RPO.txt"
set var=bd
echo Готово.
echo.

:bd
echo.
echo Проверка базы данных...
set /p b=<"C:\Program Files\Ending\Last_file_BD.txt"
cd "c:\Program Files\RussianPost\PostMove"
for %%i in (*.zip) do set a=%%i
if %a%==%b% goto bd_fail
echo.
echo Копирование Базы данных...
copy %a% c:\ARXIV_BASE\
copy %a% d:\ARXIV_BASE\
echo %a%>"C:\Program Files\Ending\Last_file_BD.txt"
set var=archive
echo Готово.
echo.

:archive
echo.
echo Архивация файлов РПО...
"c:\Program Files\WinRAR\Rar.exe" a -as -rr10p c:\RPO.rar c:\RPO\*.* >> c:\rpo_archive.log
if %errorlevel%==0 (del c:\rpo_archive.log) else goto archive_fail
"c:\Program Files\WinRAR\Rar.exe" t c:\RPO.rar >> c:\rpo_archive.log
if %errorlevel%==0 (del c:\rpo_archive.log) else goto archive_fail
copy c:\RPO.rar "c:\Program Files\RussianPost\PostMove\"
copy c:\RPO.rar c:\ARXIV_BASE\
copy c:\RPO.rar d:
set var=upload
echo.
echo Архивация завершена без ошибок.
echo.
echo.
pause

:upload
echo.
echo Отправка файлов РПО на почтамт
echo.
start /wait C:\ftp\start_upload.cmd
echo.
cd c:\ftp\rpo
if exist *.??F goto upload_fail
del "C:\Program Files\Ending\std_err"
del "C:\Program Files\Ending\error_date"
exit

:rpo_fail
echo.
echo Похоже, не сформированы файлы для отправки.
echo.
echo Запустите программу "Доставочный участок".
echo Выберите в меню "Итоги", затем - "Сформировать файлы для отправки".
echo Запустите программу "Конец дня" ещё раз.
echo.
pause
exit

:rpo_copy_fail
echo.
echo Ошибка копирования.
echo Запустите программу "Конец дня" ещё раз.
echo.
pause
exit

:bd_fail
echo %var%>"C:\Program Files\Ending\std_err"
echo %var%>>"C:\Program Files\Ending\error_log"
date /t > "C:\Program Files\Ending\error_date"
date /t >> "C:\Program Files\Ending\error_log"
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

:archive_fail
echo %var%>"C:\Program Files\Ending\std_err"
echo %var%>>"C:\Program Files\Ending\error_log"
date /t > "C:\Program Files\Ending\error_date"
date /t >> "C:\Program Files\Ending\error_log"
echo.
echo ОШИБКА! Обратитесь к системному адиристратору!
echo.
pause
exit

:upload_fail
echo %var%>"C:\Program Files\Ending\std_err"
echo %var%>>"C:\Program Files\Ending\error_log"
date /t > "C:\Program Files\Ending\error_date"
date /t >> "C:\Program Files\Ending\error_log"
echo.
echo Ошибка отправки файлов.
echo Попробуйте ещё раз через некоторое время
echo (или завтра).
echo.
pause
exit