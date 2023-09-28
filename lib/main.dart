import 'package:chat_app/screen/auth/s_login.dart';
import 'package:chat_app/screen/auth/s_sign_up.dart';
import 'package:chat_app/screen/service/s_index.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  if (kDebugMode) {
    try {
      await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
      FirebaseFirestore.instance.useFirestoreEmulator('localhost', 8080);
      FirebaseStorage.instance.useStorageEmulator('localhost', 9199);
    } catch (e) {
      print(e);
    }
  }
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final _routerConfig = GoRouter(initialLocation: "/login", routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const IndexScreen(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/sign_up',
      builder: (context, state) => const SignUpScreen(),
    ),
  ]);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: "Chat App",
      themeMode: ThemeMode.system,
      // light theme
      theme: ThemeData(
          primarySwatch: Colors.yellow,
          brightness: Brightness.light,
          appBarTheme: AppBarTheme(
              titleTextStyle: GoogleFonts.lobsterTwo(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: 32,
          )),
          floatingActionButtonTheme: const FloatingActionButtonThemeData(),
          elevatedButtonTheme:
              ElevatedButtonThemeData(style: ElevatedButton.styleFrom()),
          useMaterial3: true),
      // dark theme
      darkTheme: ThemeData(
          primarySwatch: Colors.yellow,
          brightness: Brightness.dark,
          appBarTheme: AppBarTheme(
            titleTextStyle: GoogleFonts.lobsterTwo(
              fontWeight: FontWeight.bold,
              color: Colors.white70,
              fontSize: 32,
            ),
          ),
          floatingActionButtonTheme: FloatingActionButtonThemeData(),
          elevatedButtonTheme:
              ElevatedButtonThemeData(style: ElevatedButton.styleFrom()),
          useMaterial3: true),
      routerConfig: _routerConfig,
    );
  }
}
