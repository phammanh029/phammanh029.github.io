# simulate on simulator:
 - simulate press key:
 ```adb shell input keyevent [key code]```
 for keycode, you can get it from https://developer.android.com/reference/android/view/KeyEvent.html#KEYCODE_HEADSETHOOK
 example: ```adb shell input keyevent 79``` will trigger event press media key on microphone
# issues
 ## install app to device take to long time
 - check to uninstall from all user from device
 - adb uninstall [package name]
