import 'package:flutter/material.dart';
import 'package:hot_place/features/splash/splash.screen.dart';

import 'features/app/theme/custom_palette.theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Karma',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: CustomPalette.backgroundColor,
        dialogBackgroundColor: CustomPalette.appBarColor,
        appBarTheme: AppBarTheme(
          color: CustomPalette.appBarColor,
        )
      ),
      home: const SplashScreen()
    );
  }
}
