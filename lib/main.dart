import 'package:flutter/material.dart';
import 'package:flutter_app/auth/presentation/sign_in.page.dart';
import 'package:flutter_app/shared/style/style.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SNS APP',
      theme: const CustomLightTheme().theme,
      darkTheme: const CustomDarkTheme().theme,
      home: const SignInPage(),
    );
  }
}
