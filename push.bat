@echo off
chcp 65001 >nul
echo ========================================================
echo   DANG DAY CODE LEN GITHUB CHO NHOM (ECO2432)
echo ========================================================
echo.

set "PATH=C:\Users\HTPC\AppData\Local\Programs\Git\cmd;C:\Users\HTPC\AppData\Local\Programs\Git\ucrt64\bin;%PATH%"

git.exe push -u origin main

if %ERRORLEVEL% equ 0 (
    echo.
    echo ========================================================
    echo   THANH CONG! CODE DA DUOC DAY LEN GITHUB!
    echo ========================================================
) else (
    echo.
    echo [Loi] Vui long kiem tra lai ket noi hoac xac thuc GitHub.
)

pause
