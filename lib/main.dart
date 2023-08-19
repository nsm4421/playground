import 'package:chat_app/common/theme/themes.dart';
import 'package:chat_app/screen/s_home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Themes();
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Chat App",
        themeMode: ThemeMode.system,
        theme: theme.lightTheme,
        darkTheme: theme.darkTheme,
        // home: const HomeScreen());
        home: HomeScreen());
  }
}
