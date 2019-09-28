# simulate on simulator:
 - simulate press key:
 ```adb shell input keyevent [key code]```
 for keycode, you can get it from https://developer.android.com/reference/android/view/KeyEvent.html#KEYCODE_HEADSETHOOK
 example: ```adb shell input keyevent 79``` will trigger event press media key on microphone
