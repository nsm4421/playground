import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_app/firebase_options.dart';
import 'package:my_app/screen/auth/login.screen.dart';
import 'package:my_app/screen/home/home.screen.dart';

import 'configurations.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // firebase setting
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // dependency injection
  configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Karma',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.blue,
            secondary: Colors.blueGrey,
            tertiary: Colors.grey),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) =>
            snapshot.data != null && snapshot.hasData
                ? const HomeScreen()
                : const LoginScreen(),
      ),
    );
  }
}
