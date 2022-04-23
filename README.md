# Jobsity Chalenge

# Running the project
To run the project, just run `flutter run` on the root folder.

# Features
- Clean Arquictecure and clear separation of concerns
- SignIn of multiple users
- SignIn with Fingerprint
- SignUp of multiple users
- Search for Shows
- Shows Details (with episodes)
- People Search
- App Icon
- App SplashScreen

# Infomration
- The app is using flutter_bloc for state management, more precisely the state management is done using cubit's
- We have to store some local data, all this data is stored using Hive for local storage. This decision was made, because Hive is much faster than other options like Shared Preferences and Sqflite.
- All the images that are fetched from the API are cached locally, so it can be loades faster.

# Tips
- To use the fingerprint authentication you have to have a device tha support this type of authentication and you have to make the first sign in. After the first sign in is done, on the next sign in the auth with fingerprint button will appear.
- The app supports multiple users. After creating a PIN a user can save his favorite shows. All the shows of all the users are stored separately.

# Lint
The app is using flutter_lints as the rules to lint the project

# Tests
The code is pretty much all covered with tests, with a coverage higher than 95%. It was done Unit, Cubit and Widgets Tests.
