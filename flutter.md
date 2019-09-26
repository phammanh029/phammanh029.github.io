
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
# useful package
https://pub.dev/packages/flutter_slidable
![demo](https://raw.githubusercontent.com/letsar/flutter_slidable/master/doc/images/slidable_overview.gif)
- launcher url:
https://pub.dev/packages/url_launcher


