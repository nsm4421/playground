import 'package:flutter/material.dart';
import 'package:my_app/core/di/dependency_injection.dart';

import 'presentation/pages/export.pages.dart';

void main() async {
  configureDependencies(); // dependency injection

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FullStackApp',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SignUpPage(),
    );
  }
}
