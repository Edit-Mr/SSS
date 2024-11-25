:: 你是否有也跟我一樣受不了學校網路一直斷線? 這個程式會每五秒自動檢查並重新連上 Wi-Fi。


@echo off
chcp 65001
setlocal enabledelayedexpansion
mode con: cols=20 lines=10

:: 初始化變數
set /a disconnect_count=0
set /a runtime_seconds=0

:: 設定網路名稱
set "network_name=eduroam"

:: 清屏
cls
echo 正在監控網路狀態...

:loop
:: 累計運行時間
set /a runtime_seconds+=5

:: 檢測網路是否連接
ping -n 1 8.8.8.8 >nul
if %errorlevel% neq 0 (
    :: 網路斷開，增加計數並嘗試重新連接
    set /a disconnect_count+=1
    netsh wlan connect name="%network_name%" >nul 2>&1
    set "status=網路已斷開，正在嘗試重新連接..."
) else (
    set "status=網路已連接。"
)

:: 顯示當前狀態，覆蓋前面的輸出
cls
echo ================================
echo 自動重連 Wi-Fi by 毛哥EM
echo ================================
echo 運行時間: %runtime_seconds% sec
echo 重連次數: %disconnect_count% times
echo 狀態: %status%
echo ================================
timeout /t 5 >nul
goto loop
