import 'package:chat_app/screen/auth/s_login.dart';
import 'package:chat_app/screen/auth/s_sign_up.dart';
import 'package:chat_app/screen/service/s_index.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:go_router/go_router.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
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
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
          useMaterial3: true),
      darkTheme: ThemeData.dark(),
      routerConfig:_routerConfig
    );
  }
}
