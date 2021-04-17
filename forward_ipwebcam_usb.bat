@echo OFF
break ON

SET tempDir=.usb_ipwebcam

TITLE IP Webcam thru USB
@REM v0.1

@REM Check if adb is installed
where adb >nul 2>nul
IF ERRORLEVEL 1 GOTO no_adb

@REM Check if only one device is connected
md %tempDir%
attrib %tempDir% +H /D
cd %tempDir%

SET /A device_count=0
adb devices > out_adb_devices.txt
findstr /r .*device$ out_adb_devices.txt > out_findstr_devices.txt
FOR /F %%a IN ('TYPE out_findstr_devices.txt ^| FIND "" /v /c') DO SET /A device_count=%%a

cd .. && rmdir /s /q %tempDir%

IF %device_count%==0 GOTO no_devices
IF %device_count% GTR 1 GOTO too_many_devices

@REM Default Values
SET /A port_phone = 8080
SET /A port_local = 7000

@REM Define Values if arguments are supplied
IF NOT [%1]==[] SET /A port_phone = %1
IF NOT [%2]==[] SET /A port_local = %2

cls
echo.
echo *** USE IP WEBCAM THRU USB INSTEAD OF WIFI ***
echo.
echo Please start the server in your phone's IP Webcam with the following settings...
echo.
echo **IP Webcam -^> Local Broadcasting**
echo.
echo HTTP and RSTP port: %port_phone%
echo Login/password (required, change to whatever you like)
echo.
echo **IP Webcam -^> Video Preferences**
echo.
echo Resolution: 1280 x 720 (recommended)
echo FPS Limit: 24 (recommended)
echo.
echo IP Webcam -^> ^Start server
echo.
pause
cls

echo.
echo Attempting to forward to USB...
adb forward tcp:%port_local% tcp:%port_phone% >nul

echo.
echo Now forwarding IP Webcam server to your localhost:
echo.
echo.
echo IP Webcam Settings URL (open in browser): http://localhost:%port_local%
echo.
echo Video URL (OBS Media Source): http://^<YOUR_USERNAME^>:^<YOUR_PASS^>^@localhost:%port_local%/video
echo Audio URL (OBS Media Source): http://^<YOUR_USERNAME^>:^<YOUR_PASS^>^@localhost:%port_local%/audio.wav
echo.
echo.
echo Check if it's working by opening the IP Webcam Settings URL. Press any key to close this...
pause >nul
GOTO:EOF



@REM #region Errors
:no_adb
cls
echo.
echo ADB is not installed correctly. Please download and install it first
echo.
echo ADB (Android SDK Platform Tools)
echo https://developer.android.com/studio/releases/platform-tools
echo.
echo Add it to PATH
echo https://www.xda-developers.com/adb-fastboot-any-directory-windows-linux/
echo.
echo Press any key to exit...
pause >nul
GOTO:EOF

:no_devices
cls
echo.
echo No devices are connected. Please enable USB Debugging in your Android Phone.
echo https://developer.android.com/studio/debug/dev-options#enable
echo.
echo Press any key to exit...
pause >nul
GOTO:EOF

:too_many_devices
cls
echo.
echo Too many devices found. Please use only one.
echo.
echo Connected Devices: %device_count%
echo Press any key to exit...
pause >nul
GOTO:EOF
@REM #endregion
