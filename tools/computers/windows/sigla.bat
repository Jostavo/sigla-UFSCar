@echo off
goto check_Permissions

:check_Permissions
    echo Administrative permissions required. Detecting permissions...

    net session >nul 2>&1
    if %errorLevel% == 0 (
        echo Success: Administrative permissions confirmed.
    ) else (
        echo Failure: Current permissions inadequate.
	pause >nul
	exit
    )

@echo off
start /wait msiexec /i %~dp0python-2.7.12.amd64.msi /passive /norestart
set /p ComputerId= Qual o ID do computador?
@echo startup=C:\python27\python.exe C:\Windows\sigla\computer.py %ComputerId% >> %~dp0sigla\sigla.ini
move %~dp0sigla C:\Windows\sigla
start /wait SC CREATE SiGLa Displayname= "SiGLa" binpath= "C:\Windows\sigla\srvstart.exe SiGLa -c C:\Windows\sigla\sigla.ini" start= auto
net start SiGLa
pause >nul