import 'package:flutter/material.dart';
import 'package:hot_place/features/app/constant/route.constant.dart';
import 'features/app/theme/custom_palette.theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: routerConfig,
      title: 'Karma',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: CustomPalette.backgroundColor,
        dialogBackgroundColor: CustomPalette.appBarColor,
        appBarTheme: AppBarTheme(
          color: CustomPalette.appBarColor,
        )
      ),
    );
  }
}
