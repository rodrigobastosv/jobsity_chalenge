[![Jobsity Chalenge CI](https://github.com/rodrigobastosv/jobsity_chalenge/actions/workflows/ci.yaml/badge.svg)](https://github.com/rodrigobastosv/jobsity_chalenge/actions/workflows/ci.yaml)
[![codecov](https://codecov.io/gh/rodrigobastosv/jobsity_chalenge/branch/main/graph/badge.svg?token=0SD58R3iwE)](https://codecov.io/gh/rodrigobastosv/jobsity_chalenge)

# Jobsity Chalenge
The APK of the app was generated and can be downloaded in https://drive.google.com/file/d/1lm6d3ROtwsKbTlvFEu3eMcKXQ2hHh5YF/view?usp=sharing

# Run the project
To run the project, just run `flutter run` on the root folder.

# Tests
The code is pretty much all covered with tests, with a coverage higher than 95%. It was done Unit, Cubit and Widgets Tests.

To run the tests of the project, just run `flutter test` on the root folder

# Build the app
To build the app, just run `flutter build apk --release` on the root folder

# Features
- Clean Arquictecure and clear separation of concerns
- SignIn of multiple users
- SignIn with Fingerprint
- SignUp of multiple users
- Search for Shows
- Shows Details (with episodes)
- People Search
- Caching of images
- Infinite ListView with pagination on the shows and people searchs
- App Icon
- App SplashScreen
- Animations with Lottie
- CI, tests and code coverage

# Infomration
- The app is using flutter_bloc for state management, more precisely the state management is done using cubit's
- We have to store some local data, all this data is stored using Hive for local storage. This decision was made, because Hive is much faster than other options like Shared Preferences and Sqflite.
- All the images that are fetched from the API are cached locally, so it can be loades faster.
- Although the app is very simple, I wanted to create its CI using github actions. It executes steps such as test, sending the coverage report to codecov and build the app.

# Tips
- To use the fingerprint authentication you have to have a device tha support this type of authentication and you have to make the first sign in. After the first sign in is done, on the next sign in the auth with fingerprint button will appear.
- The app supports multiple users. After creating a PIN a user can save his favorite shows. All the shows of all the users are stored separately.

# Lint
The app is using flutter_lints as the rules to lint the project
