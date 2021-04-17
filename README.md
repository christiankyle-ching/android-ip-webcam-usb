# Use IP Webcam thru USB instead of Wi-Fi
A simple batch script to make [IP Webcam (Android)](https://play.google.com/store/apps/details?id=com.pas.webcam) use USB instead of Wi-Fi connection.

## Benefits
1. Can be used with [OBS](https://obsproject.com/) and OBS Virtual Cam to use your Android camera as a webcam with higher definition than other currently free apps.
2. Can reduce problems when the Wi-Fi signal of the phone is too weak.
3. Allows you to use IP Webcam even if it's not connected to any Wi-Fi access point.

## Setup
1. [Enable USB Debugging](https://developer.android.com/studio/debug/dev-options#enable) in your Android phone.
2. Connect your phone thru USB.
3. On your Windows PC, make sure that you have installed (download and extract) [Android SDK Platform Tools](https://developer.android.com/studio/releases/platform-tools) and [add it into your `PATH`](https://www.xda-developers.com/adb-fastboot-any-directory-windows-linux/) environment variable. To test if it works, either:
   - Open a `cmd` window. Type `where adb`. It should show a path where you extracted the platform-tools.
   - Open a `cmd` window, and type `adb devices`. It should list your device if you enabled USB debugging already.

## How to Use?
1. Run the script (forward_ipwebcam_usb.bat).
2. Open IP Webcam, and set settings shown in the window shown. Then, start server.
3. Press any key in the script to continue.
4. To test if it works (thru USB), you should be able to access the `IP Webcam Settings URL` shown in a browser. Use the username and password that you set in IP Webcam.
5. To use this as a virtual webcam in OBS:
   1. Add a `Media Source` in your scene.
   2. Uncheck the `Local File`.
   3. Copy and paste the `Video URL (OBS Media Source)` shown in the script to the `Input`. Replace the `<YOUR_USERNAME>` and `<YOUR_PASS>` with the same credentials you entered in the IP Webcam.
   4. Drag the `Network Buffering` and `Reconnect Delay` all the way to the left (minimum value).
   5. Click `OK`, then `Start Virtual Camera`.
   6. On your video conference software (i.e. Google Meet, Zoom, etc), select the `OBS Virtual Camera` as your camera. As long as your OBS is running, it should work.

## Use custom port

By default, this forwards your phone's port `8080` (IP Webcam's default) to your local machine's port `7000` (script's default).

You can provide a custom port by opening a `cmd` in the folder where the script is located, then use the following syntax:

```shell
forward_ipwebcam_usb [ipwebcam_port] [local_port]
```

For example, the following will forward IP Webcam's port `5000` to a port in your machine `6000`.

```shell
forward_ipwebcam_usb 5000 6000
```

## Notes

You can check the `Task Manager` > `Network Tab` to see that OBS is not fetching the video feed from the network. This means that you can also use this even if the phone is not connected to any Wi-Fi.
