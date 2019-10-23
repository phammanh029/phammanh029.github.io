
# for androidx migration:

## for Android
- https://developer.android.com/jetpack/androidx/migrate/class-mappings
- https://developer.android.com/jetpack/androidx/migrate

## for flutter
- https://flutter.dev/docs/development/packages-and-plugins/androidx-compatibility

In android/gradle/wrapper/gradle-wrapper.properties change the line starting with distributionUrl like this:
`distributionUrl=https\://services.gradle.org/distributions/gradle-4.10.2-all.zip`
In android/build.gradle, replace:

`dependencies {
    classpath 'com.android.tools.build:gradle:3.2.1'
}`
by


`dependencies {
    classpath 'com.android.tools.build:gradle:3.3.0'
}`
In android/gradle.properties, append

`android.enableJetifier=true
android.useAndroidX=true`
In android/app/build.gradle:

Under android {, make sure compileSdkVersion and targetSdkVersion are at least 28.

Replace all deprecated libraries with the AndroidX equivalents. For instance, if you’re using the default .gradle files make the following changes:

In android/app/build.gradle


`testInstrumentationRunner "android.support.test.runner.AndroidJUnitRunner"`
by
`testInstrumentationRunner "androidx.test.runner.AndroidJUnitRunner"`
Finally, under dependencies {, replace


`androidTestImplementation 'com.android.support.test:runner:1.0.2'
androidTestImplementation 'com.android.support.test.espresso:espresso-core:3.0.2'`
by
`androidTestImplementation 'androidx.test:runner:1.1.1'
androidTestImplementation 'androidx.test.espresso:espresso-core:3.1.1'`
# Errors
 - No toolchains found in the NDK toolchains folder for ABI with prefix: mips64el-linux-android:
  using : classpath 'com.android.tools.build:gradle:3.2.1' in gradle build file
# useful package
- dismissable control with behavior
(https://pub.dev/packages/flutter_slidable)
![demo](https://raw.githubusercontent.com/letsar/flutter_slidable/master/doc/images/slidable_overview.gif)
- launcher url:(https://pub.dev/packages/url_launcher)
- sms sender(https://pub.dev/packages/sms)
- images picker (https://pub.dev/packages/image_picker)
### State management
- provider (https://pub.dev/packages/provider)
- flutter bloc (https://pub.dev/packages/flutter_bloc)
- network image cache (https://pub.dev/packages/cached_network_image)

### GPS
 - location (https://pub.dev/packages/location)
 - geolocator (https://pub.dev/packages/geolocator)
 - bggeolocation (https://pub.dev/packages/flutter_background_geolocation)
### connectivity (https://pub.dev/packages/connectivity)
### sharing: 
  - share (https://pub.dev/packages/share)
### defice info: 
(https://pub.dev/packages/device_info)

## great posts
- https://medium.com/flutter-community/flutter-deep-dive-part-1-renderflex-children-have-non-zero-flex-e25ffcf7c272
## UI

### Snaplist [https://github.com/ariedov/flutter_snaplist]

![](https://camo.githubusercontent.com/290da53945fac576d9d362ffe40bcdf836def643/68747470733a2f2f6d656469612e67697068792e636f6d2f6d656469612f3237625448616c797765566f6332707353322f67697068792e676966)

### Liquid-Pull-To-Refresh [https://github.com/aagarwal1012/Liquid-Pull-To-Refresh]
![](https://github.com/aagarwal1012/Liquid-Pull-To-Refresh/blob/master/display/liquid.gif?raw=true)

### before_after [https://github.com/xsahil03x/before_after]

![](https://user-images.githubusercontent.com/25670178/61337576-978f1780-a853-11e9-9249-3637d0861ebb.gif)

### flutter_slidable [https://pub.dev/packages/flutter_slidable]

![](https://raw.githubusercontent.com/letsar/flutter_slidable/master/doc/images/slidable_overview.gif)

### flutter [url_launcher: ^5.2.3](https://pub.dev/packages/url_launcher#-installing-tab-)


