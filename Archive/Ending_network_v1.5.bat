@echo off

if exist std_err goto 3
echo �஢�ઠ 䠩�� � ����묨 ���...
set /p f=<Last_file_RPO.txt
cd C:\ftp\rpo
for %%i in (*) do set a=%%i
if not %a%==%f% goto 1
echo.
echo ��宦�, �� ��ନ஢��� 䠩�� ��� ��ࠢ��.
echo.
echo ������� �ணࠬ�� "���⠢��� ���⮪".
echo �롥�� � ���� "�⮣�", ��⥬ - "��ନ஢��� 䠩�� ��� ��ࠢ��".
echo ������� �ணࠬ�� "����� ���" ��� ࠧ.
echo.
pause
exit

:1
echo.
echo ����஢���� 䠩���...
copy %a% C:\RPO
if exist C:\RPO\%a% goto 2
echo.
echo �訡�� ����஢����.
echo ������� �ணࠬ�� "����� ���" ��� ࠧ.
echo.
pause
exit

:2
echo %a%>"C:\Program Files\Ending\Last_file_RPO.txt"
echo rpo>"C:\Program Files\Ending\std_err"
echo ��⮢�.

:3
echo �஢�ઠ ���� ������...
set /p b=<"C:\Program Files\Ending\Last_File_BD.txt"
cd "c:\Program Files\RussianPost\PostMove"
for %%i in (*.zip) do set a=%%i
if not %a%==%b% goto 4
echo.
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

:4
echo.
echo ����஢���� ���� ������...
copy %a% c:\ARXIV_BASE\
copy %a% d:\ARXIV_BASE\
echo %a%>"C:\Program Files\Ending\Last_file_BD.txt"
echo bd>"C:\Program Files\Ending\std_err"
echo ����஢���� ���� ������ �����襭�.

echo.
echo ��娢��� 䠩��� ���...
"c:\Program Files\WinRAR\Rar.exe" a -as -rr10p c:\RPO.rar c:\RPO\*.* >> c:\rpo_archive.log
if %errorlevel%==0 (del c:\rpo_archive.log) else goto 5
"c:\Program Files\WinRAR\Rar.exe" t c:\RPO.rar >> c:\rpo_archive.log
if %errorlevel%==0 (del c:\rpo_archive.log) else goto 5
copy c:\RPO.rar "c:\Program Files\RussianPost\PostMove\"
copy c:\RPO.rar c:\ARXIV_BASE\
copy c:\RPO.rar d:
echo.
echo ��娢��� �����襭� ��� �訡��.
echo.
echo.
echo ��⮢�.
echo.
echo.
pause
del "C:\Program Files\Ending\std_err"
echo.
echo ��ࠢ�� 䠩��� ��� �� ���⠬�
echo.
C:\ftp\start_upload.cmd
echo.
exit

:5
echo.
echo ������! ������� � ��⥬���� ����������!
echo.
pause