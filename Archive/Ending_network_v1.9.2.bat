@echo off

if not exist std_err goto rpo
set /p d=<error_date
if not %d%==%date% goto rpo
set /p var=<std_err
if %var%==rpo goto bd
if %var%==bd goto archive
if %var%==archive goto upload

:rpo
echo.
echo �஢�ઠ 䠩�� � ����묨 ���...
set /p f=<Last_file_RPO.txt
cd C:\ftp\rpo
if not exist *.??F goto rpo_fail
for %%i in (*) do set a=%%i
if %a%==%f% goto rpo_fail
echo.
echo ����஢���� 䠩���...
copy %a% C:\RPO
if not exist C:\RPO\%a% goto rpo_copy_fail
echo %a%>"C:\Program Files\Ending\Last_file_RPO.txt"
set var=rpo
echo ��⮢�.
echo.

:bd
echo.
echo �஢�ઠ ���� ������...
set /p b=<"C:\Program Files\Ending\Last_File_BD.txt"
cd "c:\Program Files\RussianPost\PostMove"
for %%i in (*.zip) do set a=%%i
if %a%==%b% goto bd_fail
echo.
echo ����஢���� ���� ������...
copy %a% c:\ARXIV_BASE\
copy %a% d:\ARXIV_BASE\
echo %a%>"C:\Program Files\Ending\Last_file_BD.txt"
set var=bd
echo ��⮢�.
echo.

:archive
echo.
echo ��娢��� 䠩��� ���...
"c:\Program Files\WinRAR\Rar.exe" a -as -rr10p c:\RPO.rar c:\RPO\*.* >> c:\rpo_archive.log
if %errorlevel%==0 (del c:\rpo_archive.log) else goto archive_fail
"c:\Program Files\WinRAR\Rar.exe" t c:\RPO.rar >> c:\rpo_archive.log
if %errorlevel%==0 (del c:\rpo_archive.log) else goto archive_fail
copy c:\RPO.rar "c:\Program Files\RussianPost\PostMove\"
copy c:\RPO.rar c:\ARXIV_BASE\
copy c:\RPO.rar d:
set var=archive
echo.
echo ��娢��� �����襭� ��� �訡��.
echo.
echo.
pause

:upload
echo.
echo ��ࠢ�� 䠩��� ��� �� ���⠬�
echo.
start /wait C:\ftp\start_upload.cmd
echo.
cd c:\ftp\rpo
if exist *.??F goto upload_fail
del "C:\Program Files\Ending\std_err"
exit

:rpo_fail
echo.
echo ��宦�, �� ��ନ஢��� 䠩�� ��� ��ࠢ��.
echo.
echo ������� �ணࠬ�� "���⠢��� ���⮪".
echo �롥�� � ���� "�⮣�", ��⥬ - "��ନ஢��� 䠩�� ��� ��ࠢ��".
echo ������� �ணࠬ�� "����� ���" ��� ࠧ.
echo.
pause
exit

:rpo_copy_fail
echo.
echo �訡�� ����஢����.
echo ������� �ணࠬ�� "����� ���" ��� ࠧ.
echo.
pause
exit

:bd_fail
echo %var%>"C:\Program Files\Ending\std_err"
date /t > "C:\Program Files\Ending\error_date"
echo.
echo ��宦�, �� ᤥ���� १�ࢨ஢���� ���� ������.
echo.
echo ������� �ணࠬ�� "���⠢��� ���⮪".
echo.
echo �롥�� � ���� "��ࢨ�", ��⥬ - "���㦨����� ��� ������",
echo  ��⥬ - "����ࢨ஢���� ��� ������".
echo.
echo ������� �ணࠬ�� "����� ���" ��� ࠧ.
echo.
pause
exit

:archive_fail
echo %var%>"C:\Program Files\Ending\std_err"
date /t > "C:\Program Files\Ending\error_date"
echo.
echo ������! ������� � ��⥬���� ����������!
echo.
pause
exit

:upload_fail
echo %var%>"C:\Program Files\Ending\std_err"
date /t > "C:\Program Files\Ending\error_date"
echo.
echo �訡�� ��ࠢ�� 䠩���.
echo ���஡�� ��� ࠧ �१ �����஥ �६�
echo (��� �����).
echo.
pause
exit