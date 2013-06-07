@echo off

if exist std_err goto 4
set /p f=<Last_file_RPO.txt
cd c:\RPO\
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
echo Вставьте, пожалуйста, дискету.
echo.
pause

vol a:>>c:\log_disk
if %errorlevel%==0 goto 2
echo.
echo ВНИМАНИЕ! Вставьте, пожалуста, дискету!
echo.
pause
echo.
vol a:>>c:\log_disk
if %errorlevel%==0 goto 2
echo.
echo ОШИБКА! Вставьте, пожалуста, дискету!
echo.
pause
echo.
vol a:>>c:\log_disk
if %errorlevel%==0 goto 2
echo.
echo ОШИБКА! Обратитесь к системному адиристратору!
echo.
pause
echo.
exit

:2
echo.
echo Копирование файлов РПО на дискету...
copy %a% a:\
if exist a:\%a% goto 3
echo.
echo Ошибка копирования.
echo Вставьте, пожалуста, другую дискету.
echo Запустите программу "Конец дня" ещё раз.
echo.
pause
exit

:3
del c:\log_disk
echo %a%>"C:\Program Files\Ending\Last_file_RPO.txt"
echo rpo>"C:\Program Files\Ending\std_err"
echo Готово.

:4
set /p b=<"C:\Program Files\Ending\Last_File_BD.txt"
cd "c:\Program Files\RussianPost\PostMove"
for %%i in (*.zip) do set a=%%i
if not %a%==%b% goto 5
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

:5
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
if %errorlevel%==0 (del c:\rpo_archive.log) else goto 6
"c:\Program Files\WinRAR\Rar.exe" t c:\RPO.rar >> c:\rpo_archive.log
if %errorlevel%==0 (del c:\rpo_archive.log) else goto 6
copy c:\RPO.rar "c:\Program Files\RussianPost\PostMove\"
copy c:\RPO.rar c:\ARXIV_BASE\
copy c:\RPO.rar d:
echo.
echo Архивация завершена без ошибок.
echo.
echo.
echo Готово.
echo.
echo Достаньте дискету из привода и отнесите операторам на кассу.
echo.
echo.
pause
del "C:\Program Files\Ending\std_err"
exit

:6
echo.
echo ОШИБКА! Обратитесь к системному адиристратору!
echo.
pause