@echo off

if exist std_err goto 4
set /p f=<Last_file_RPO.txt
cd c:\RPO\
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
echo ��⠢��, ��������, ��᪥��.
echo.
pause

vol a:>>c:\log_disk
if %errorlevel%==0 goto 2
echo.
echo ��������! ��⠢��, ��������, ��᪥��!
echo.
pause
echo.
vol a:>>c:\log_disk
if %errorlevel%==0 goto 2
echo.
echo ������! ��⠢��, ��������, ��᪥��!
echo.
pause
echo.
vol a:>>c:\log_disk
if %errorlevel%==0 goto 2
echo.
echo ������! ������� � ��⥬���� ����������!
echo.
pause
echo.
exit

:2
echo.
echo ����஢���� 䠩��� ��� �� ��᪥��...
copy %a% a:\
if exist a:\%a% goto 3
echo.
echo �訡�� ����஢����.
echo ��⠢��, ��������, ����� ��᪥��.
echo ������� �ணࠬ�� "����� ���" ��� ࠧ.
echo.
pause
exit

:3
del c:\log_disk
echo %a%>"C:\Program Files\Ending\Last_file_RPO.txt"
echo rpo>"C:\Program Files\Ending\std_err"
echo ��⮢�.

:4
set /p b=<"C:\Program Files\Ending\Last_File_BD.txt"
cd "c:\Program Files\RussianPost\PostMove"
for %%i in (*.zip) do set a=%%i
if not %a%==%b% goto 5
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

:5
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
if %errorlevel%==0 (del c:\rpo_archive.log) else goto 6
"c:\Program Files\WinRAR\Rar.exe" t c:\RPO.rar >> c:\rpo_archive.log
if %errorlevel%==0 (del c:\rpo_archive.log) else goto 6
copy c:\RPO.rar "c:\Program Files\RussianPost\PostMove\"
copy c:\RPO.rar c:\ARXIV_BASE\
copy c:\RPO.rar d:
echo.
echo ��娢��� �����襭� ��� �訡��.
echo.
echo.
echo ��⮢�.
echo.
echo ���⠭�� ��᪥�� �� �ਢ��� � �⭥�� �����ࠬ �� �����.
echo.
echo.
pause
del "C:\Program Files\Ending\std_err"
exit

:6
echo.
echo ������! ������� � ��⥬���� ����������!
echo.
pause