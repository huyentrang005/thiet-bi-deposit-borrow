@echo off
chcp 65001 >nul
echo ========================================================
echo   KHOI DONG SERVER DAPP TAI http://localhost:8000
echo ========================================================
echo.
echo Dang mo may chu cuc bo: http://localhost:8000
echo Vui long giu nguyen cua so nay trong khi su dung web!
echo.
python -m http.server 8000 --directory web
pause
