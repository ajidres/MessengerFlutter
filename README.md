# MessengerFlutter

A Flutter-based messaging application using Firebase as the backend.

## Prerequisites

- Flutter SDK (latest stable version)
- Dart SDK (comes with Flutter)
- Firebase account
- Android Studio/Xcode (for emulator/simulator or device testing)

## Installation

### 1. Clone the repository

```bash
git clone https://github.com/ajidres/MessengerFlutter.git
cd MessengerFlutter
```

### 2. Install dependencies
```bash
flutter pub get
```

### 3. Firebase CLI configuration
- If you haven't already, install the [Firebase CLI](https://firebase.google.com/docs/cli#setup_update_cli).
- Log into Firebase using your Google account by running the following command:
```bash
firebase login
```
- Install the FlutterFire CLI by running the following command from any directory:
```bash
dart pub global activate flutterfire_cli
```

### 4. Configure Firebase in the app
- Use the FlutterFire CLI to configure your Flutter apps to connect to Firebase.
- From your Flutter project directory, run the following command to start the app configuration workflow:
```bash
flutterfire configure
```
- From your Flutter project directory, run the following command to install the core plugin:
```bash
flutter pub add firebase_core
```
- From your Flutter project directory, run the following command to ensure that your Flutter app's Firebase configuration is up-to-date:
```bash
flutterfire configure
```
- In your lib/main.dart file, import the Firebase core plugin and the configuration file you generated earlier:
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

- Also in your lib/main.dart file, initialize Firebase using the DefaultFirebaseOptions object exported by the configuration file:
WidgetsFlutterBinding.ensureInitialized();
await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);
runApp(const MyApp());

- Rebuild your Flutter application:
```bash
flutter run
```


