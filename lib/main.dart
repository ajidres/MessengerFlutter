import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:messenger/core/hive_preference_client.dart';
import 'package:messenger/core/injection_container.dart';
import 'package:messenger/presentation/auth/login_page.dart';
import 'package:messenger/presentation/chat/conversations_page.dart';
import 'package:messenger/presentation/home/home_page.dart';
import 'package:messenger/presentation/users/user_page.dart';

import 'core/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await HivePreferenceClient.instance.init();
  setupDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: AuthWrapper()
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    var user = HivePreferenceClient.instance.getUser();
    if (user.id.isNotEmpty) {
      return HomePage(user: user,);
    } else {
      return const LoginPage();
    }
  }
}

