import 'package:chat_app/common/routes/routes.dart';
import 'package:chat_app/common/theme/themes.dart';
import 'package:chat_app/screen/s_welcome.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Themes();
    return MaterialApp(
        onGenerateRoute: CustomRoutes.onGeneralRoute,
        debugShowCheckedModeBanner: false,
        title: "Chat App",
        themeMode: ThemeMode.system,
        theme: theme.lightTheme,
        darkTheme: theme.darkTheme,
        // home: const HomeScreen());
        home: WelcomeScreen());
  }
}
