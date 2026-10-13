@echo off
chcp 65001 >nul
echo ========================================================
echo   DANG DONG BO / CAP NHAT CODE MOI NHAT TU GITHUB
echo ========================================================
echo.

set "PATH=%LOCALAPPDATA%\Programs\Git\cmd;C:\Program Files\Git\cmd;C:\Users\HTPC\AppData\Local\Programs\Git\cmd;C:\Users\LAPTOP\AppData\Local\Programs\Git\cmd;%PATH%"

git.exe pull origin main

if %ERRORLEVEL% equ 0 (
    echo.
    echo ========================================================
    echo   THANH CONG! MA NGUON DA DUOC CAP NHAT MOI NHAT!
    echo ========================================================
) else (
    echo.
    echo [Loi] Khong the lay code ve. Vui long kiem tra ket noi mang.
)

pause
