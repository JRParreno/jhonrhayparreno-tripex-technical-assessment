# jhon_rhay_parreno_technical_assessment

## Getting Started

This project is a Weather app with login using Google firebase SSO.

## APK File
[Download link](https://drive.google.com/file/d/1Ju_i7tz9KNn8JNZGbUSkjII3gMlODSsj/view?usp=sharing)

## Test Coverage
Note: Firebase integration not included in functional testing, but added in integration testing <br>
- to generate test coverage run ***sh test_coverage.sh*** this is only works in Mac/Linux <br><br>
![image](https://github.com/user-attachments/assets/4497475f-3d87-45b6-a2f1-cac525082580)


## Installion:
- VScode as IDE
- Kindly use Flutter 3.19.6
- Android device

## How to run
Mac/Linux setup:
- type in your terminal ***sh rebuild.sh buil*** to install/rebuild everything
- and click run in vscode

Windows setup:
- flutter clean
- flutter pub get
- flutter pub global activate intl_utils
- flutter packages run intl_utils:generate
- dart run build_runner build

## Unit/Integration test
kindly hit the run icon in the testing section <br>
![image](https://github.com/user-attachments/assets/3d275f00-65e4-4f68-8873-a1b2d2255589)
<br>
Just in case if you have any errors kindly try this:
- dart run build_runner build
- If there are any errors run dart run build_runner build --delete-conflicting-outputs
- and then run again the test in testing section in vscode
