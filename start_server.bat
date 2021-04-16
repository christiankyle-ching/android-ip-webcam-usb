@echo OFF
break ON

@REM Default Values
SET /A port_phone = 8080
SET /A port_local = 7000

@REM Define Values if arguments are supplied
IF NOT [%1]==[] SET /A port_phone = %1
IF NOT [%2]==[] SET /A port_local = %2

echo *** USE IP WEBCAM THRU USB INSTEAD OF WIFI ***
echo.
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
echo.
echo Attempting to forward to USB...
adb forward tcp:%port_local% tcp:%port_phone%

echo.
echo.
echo Now forwarding IP Webcam server to your localhost:
echo.
echo IP Webcam Settings (open in browser): http://localhost:%port_local%
echo.
echo Video URL (OBS Media Source): http://^<YOUR_USERNAME^>:^<YOUR_PASS^>^@localhost:%port_local%/video
echo Audio URL (OBS Media Source): http://^<YOUR_USERNAME^>:^<YOUR_PASS^>^@localhost:%port_local%/audio.wav
echo.
pause >nul
