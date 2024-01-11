# sample_flutter

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.




### ICON GENERATION
--flutter pub run flutter_launcher_icons:main

### MODEL SERIALIZATION
--flutter packages pub run build_runner build --delete-conflicting-outputs

### BUILD APK WITH FLAVORS
--flutter build apk --flavor Dev -t lib/main.dart
## Android Releases
--flutter build appbundle

## Way to Remove Cache { use if you cant build with build runner. }
sudo rm -Rf /Users/<username>/.pub-cache
sudo rm -Rf packages

## AppRename
-- flutter pub global run rename --appname "Cargo_Tracker"
## App BundleName change
-- flutter pub global run rename --bundleId com.example.sample_flutter
## Generate Icons
-- flutter pub run flutter_launcher_icons:main


#IOS notification config
-- https://firebase.google.com/codelabs/firebase-fcm-flutter#2 